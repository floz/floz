package de.popforge.coverflow 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;	

	/**
	 * @author aM
	 */
	public class CoverFlow extends Sprite 
	{
		private const _covers: Vector.<Cover> = new Vector.<Cover>();
		
		private var _width: Number;

		private var _offsetCenter: Number;
		private var _offsetDepth: Number;
		private var _offsetCover: Number;
		private var _offsetAngle: Number;

		private var _index: int = -1;
		
		public function CoverFlow( width: Number )
		{
			_width = width;

			_offsetCenter = 144.0;
			_offsetDepth = 256.0;
			_offsetCover = 48.0;
			_offsetAngle = 45.0;
			
			var perspectiveProjection: PerspectiveProjection = new PerspectiveProjection();

			perspectiveProjection.projectionCenter = new Point( 0, 32 );
			perspectiveProjection.fieldOfView = 90.0;
			transform.perspectiveProjection = perspectiveProjection;
			
			addEventListener( Event.ADDED_TO_STAGE, _addedToStage );
		}
		
		public function addCover( cover: Cover ): void
		{
			_covers.push( cover );
			cover.visible = false;
			
			if( _index > -1 )
			{
				_arrange();
				_startEasing();

				cover.hardSet();
			}
		}
		
		public function set index( index: int ): void
		{
			if( index < 0 || index >= _covers.length )
				return;
			
			_index = index;
			
			_arrange();
			_startEasing( );
		}

		public function get index(): int
		{
			return _index;
		}
		
		private function _startEasing(): void
		{
			addEventListener( Event.ENTER_FRAME, _doEasing );
		}
		
		private function _stopEasing(): void
		{
			removeEventListener( Event.ENTER_FRAME, _doEasing );

			_hardSet();
		}
		
		private function _arrange(): void
		{
			var c: Cover;
			var d: CoverDisplace;
			
			var i: int;
			var n: int = _covers.length;
			
			//-- LEFT SIDE
			for( i = 0 ; i < index ; ++i )
			{
				c = _covers[i];
				d = c.targetDisplace;
				d.x = -_offsetCenter - ( index - i ) * _offsetCover;
				d.z = _offsetDepth;
				d.a = -_offsetAngle;

				addChild( c );
			}
			
			//-- CENTER
			{
				c = _covers[index];
				d = c.targetDisplace;
				d.x = 0;
				d.z = 0;
				d.a = 0;
				
				addChild( c );
			}

			//-- RIGHT SIDE
			for( i = index + 1 ; i < n ; ++i )
			{
				c = _covers[i];
				d = c.targetDisplace;
				d.x = _offsetCenter + ( i - index ) * _offsetCover;
				d.z = _offsetDepth;
				d.a = _offsetAngle;

				addChildAt( c, 0 );
			}
		}
		
		private function _doEasing( event: Event ): void
		{
			var complete: Boolean = true;
			
			var i: int = 0;
			var n: int = _covers.length;
			
			for( ; i < n ; ++i )
				if( !_covers[i].easeSet() )
					complete = false;

			if( complete )
				_stopEasing();
			else
				_darkOutside();
		}

		private function _hardSet(): void
		{
			var i: int = 0;
			var n: int = _covers.length;
			
			for( ; i < n ; ++i )
				_covers[i].hardSet();
		}

		private function _darkOutside(): void
		{
			var w0: Number = _width * .5;
			var w1: Number = _width * .25;
			var wn: Number = 1 / ( w0 - w1 );
			
			var i: int = 0;
			var n: int = _covers.length;
			
			var c: Cover;
			var r: Rectangle;
			
			for( ; i < n ; ++i )
			{
				c = _covers[i];
				r = c.getRect( this );
				
				if( r.left < -w0 || r.right > w0 )
				{
					c.visible = false;
				}
				else
				if( r.left < -w1 )
				{
					c.darken = 1.0 + ( r.left + w1 ) * wn;
					c.visible = true;
				}
				else
				if( r.right > w1 )
				{
					c.darken = 1.0 - ( r.right - w1 ) * wn;
					c.visible = true;
				}
				else
				{
					c.darken = 1.0;
					c.visible = true;
				}
			}
		}

		private function _addedToStage( event: Event = null ): void
		{
			if( _index == -1 )
			{
				_index = 0;
				_arrange();
				_hardSet();
				setTimeout( _darkOutside, 250 );
			}
		}
	}
}