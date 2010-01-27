
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
	
	public class IsoRect extends IsoDisplayObject
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _width:Number;
		private var _length:Number;
		private var _height:Number;
		
		private var _graphicsPath:GraphicsPath;
		
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
			_graphicsPath = IsoDrawing.getRectPath( _width, _length, _height );
			return _graphicsPath ? true : false;
		}
		
		private function drawGeometry():void
		{			
			var g:Graphics = this.graphics;
			g.lineStyle( 1, 0x000000 );
			g.beginFill( 0xffff00 );
			g.drawPath( _graphicsPath.commands, _graphicsPath.data );
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}