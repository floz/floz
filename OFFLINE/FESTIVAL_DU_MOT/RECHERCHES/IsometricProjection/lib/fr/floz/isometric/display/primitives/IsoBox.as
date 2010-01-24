
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
	
	public class IsoBox extends IsoDisplayObject
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _width:Number;
		private var _length:Number;
		private var _height:Number;
		
		private var _geometry:Vector.<Point3D>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoBox( width:Number = 0, length:Number = 0, height:Number = 0 ) 
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
			if ( _width > 0 || _length > 0 || _height > 0 )
			{
				_geometry = new Vector.<Point3D>();
				
				// left
				var isoRect:IsoRect = new IsoRect( 0, _length, _height );
				_geometry = _geometry.concat( translate( isoRect.geometry, IsoMath.isoToScreen( new Point3D( _width, 0, 0 ) ) ) );
				
				// right
				isoRect = new IsoRect( _width, 0, _height );
				_geometry = _geometry.concat( translate( isoRect.geometry, IsoMath.isoToScreen( new Point3D( 0, _length, 0 ) ) ) );
				
				// top
				isoRect = new IsoRect( _width, _length, 0 );
				_geometry = _geometry.concat( translate( isoRect.geometry, IsoMath.isoToScreen( new Point3D( 0, 0, _height ) ) ) );
				
				return true;
			}
			
			return false;
		}
		
		private function drawGeometry():void
		{
			var g:Graphics = this.graphics;
			g.lineStyle( 1, 0x000000 );
			
			var j:int;
			for ( var i:int = 0; i < 3; ++i )
			{
				g.moveTo( _geometry[ int( i * 4 ) ].x, _geometry[ int( i * 4 ) ].y );
				for ( j = 1; j < 4; ++j )
					g.lineTo( _geometry[ int( i * 4 + j ) ].x, _geometry[ int( i * 4 + j ) ].y );
				
				g.lineTo( _geometry[ int( i * 4 ) ].x, _geometry[ int( i * 4 ) ].y );
			}	
		}
		
		private function translate( base:Vector.<Point3D>, vector:Point3D ):Vector.<Point3D>
		{
			var n:int = base.length;
			var trans:Vector.<Point3D> = new Vector.<Point3D>( base.length, true );
			
			var p:Point3D;
			for ( var i:int; i < n; ++i )
			{
				p = base[ i ].clone();
				p.x += vector.x;
				p.y += vector.y;
				p.z += vector.z;
				
				trans[ i ] = p;
			}
			return trans;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}