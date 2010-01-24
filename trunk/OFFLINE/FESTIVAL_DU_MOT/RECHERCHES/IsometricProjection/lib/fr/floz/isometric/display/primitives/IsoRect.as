
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric.display.primitives 
{
	import flash.display.Graphics;
	import fr.floz.isometric.core.IsoDisplayObject;
	import fr.floz.isometric.geom.IsoMath;
	import fr.floz.isometric.geom.Point3D;
	
	public class IsoRect extends IsoDisplayObject
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _width:Number;
		private var _length:Number;
		private var _height:Number;
		
		private var _geometry:Vector.<Point3D>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoRect( width:Number = 0, length:Number = 0, height:Number = 0 ) 
		{
			this._width = width;
			this._length = length;
			this._height = height;
			
			buildGeometry();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function buildGeometry():void
		{
			if ( validateGeometry() )
			{
				drawGeometry();
			}
			else trace( "3:IsoRect.buildGeometry >> Impossible de tracer le rectangle isométrique." );
		}
		
		private function validateGeometry():Boolean
		{
			_geometry = new Vector.<Point3D>( 4, true );
			_geometry[ 0 ] = new Point3D( 0, 0, 0 );
			
			if ( _width > 0 && _length > 0 && _height <= 0 )
			{
				_geometry[ 1 ] = new Point3D( _width, 0, 0 );
				_geometry[ 2 ] = new Point3D( _width, _length, 0 );
				_geometry[ 3 ] = new Point3D( 0, _length, 0 );
			}
			else if ( _width > 0 && _length <= 0 && _height > 0 )
			{
				_geometry[ 1 ] = new Point3D( _width, 0, 0 )
				_geometry[ 2 ] = new Point3D( _width, 0, _height );
				_geometry[ 3 ] = new Point3D( 0, 0, _height );
			}
			else if ( _width <= 0 && _length > 0 && _height > 0 )
			{
				_geometry[ 1 ] = new Point3D( 0, _length, 0 );
				_geometry[ 2 ] = new Point3D( 0, _length, _height );
				_geometry[ 3 ] = new Point3D( 0, 0, _height );
			}
			else return false;
			
			convertGeometry();			
			return true;
		}
		
		private function convertGeometry():void
		{
			var i:int = _geometry.length;
			while ( --i > -1 )
				_geometry[ i ] = IsoMath.isoToScreen( _geometry[ i ] );
		}
		
		private function drawGeometry():void
		{			
			var g:Graphics = this.graphics;
			g.lineStyle( 1, 0x000000 );
			g.moveTo( _geometry[ 0 ].x, _geometry[ 0 ].y );
			
			var n:int = _geometry.length;
			for ( var i:int = 1; i < n; ++i )
				g.lineTo( _geometry[ i ].x, _geometry[ i ].y );
			
			g.lineTo( _geometry[ 0 ].x, _geometry[ 0 ].y );
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get geometry():Vector.<Point3D> { return _geometry; }
		
	}
	
}