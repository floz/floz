
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric.objects.primitives 
{
	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import fr.floz.isometric.core.IsoDisplayObject;
	import fr.floz.isometric.geom.IsoDrawing;
	import fr.floz.isometric.geom.IsoMath;
	import fr.floz.isometric.geom.Point3D;
	
	public class IsoBox extends IsoDisplayObject
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _width:Number;
		private var _length:Number;
		private var _height:Number;
		
		private var _graphicsPaths:Vector.<GraphicsPath>;
		
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
			if ( ( _width > 0 && _length > 0 && _height > 0 ) )
			{
				_graphicsPaths = new Vector.<GraphicsPath>( 3, true );
				_graphicsPaths[ 0 ] = IsoDrawing.getRectPath( 0, _length, _height, new Point3D( _width, 0, 0 ) );
				_graphicsPaths[ 1 ] = IsoDrawing.getRectPath( _width, 0, _height, new Point3D( 0, _length, 0 ) );
				_graphicsPaths[ 2 ] = IsoDrawing.getRectPath( _width, _length, 0, new Point3D( 0, 0, _height ) );
			}
			else if ( ( _width > 0 && _length > 0 && _height <= 0 ) ||
					  ( _width > 0 && _length <= 0 && _height > 0 ) ||
					  ( _width <= 0 && _length > 0 && _height > 0 ) )
		    {
				_graphicsPaths = new Vector.<GraphicsPath>( 1, true );
				_graphicsPaths[ 0 ] = IsoDrawing.getRectPath( _width, _length, _height );
		    }
			else _graphicsPaths = null;
			
			return _graphicsPaths ? true : false;
		}
		
		private function drawGeometry():void
		{
			var n:int = _graphicsPaths.length;
			for ( var i:int; i < n; ++i )
			{
				graphics.lineStyle( 1, 0x000000 );
				graphics.beginFill( 0xff0000 );
				graphics.drawPath( _graphicsPaths[ i ].commands, _graphicsPaths[ i ].data );
				graphics.endFill();
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}