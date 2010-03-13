
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.common.materials 
{
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	
	public class WireColorMaterial extends ColorMaterial
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _wireColor:uint;
		private var _wireAlpha:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function WireColorMaterial( color:uint = 0xff00ff, alpha:Number = 1, wireColor:uint = 0xff0000, wireAlpha:Number = 1, thickness:Number = 1 ) 
		{
			super( color, alpha );
			
			_wireColor = wireColor;
			_wireAlpha = wireAlpha;
			
			_graphicsStroke.fill = new GraphicsSolidFill( _wireColor, _wireAlpha );
			_graphicsStroke.thickness = 1;			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get wireColor():uint { return _wireColor; }
		
		public function set wireColor(value:uint):void 
		{
			if ( _wireColor == value ) 
				return;
			
			_wireColor = value;
			( _graphicsStroke.fill as GraphicsSolidFill ).color = value;
		}
		
		public function get wireAlpha():Number { return _wireAlpha; }
		
		public function set wireAlpha(value:Number):void 
		{
			if ( _wireAlpha == value ) 
				return;
			
			_wireAlpha = value;
			( _graphicsStroke.fill as GraphicsSolidFill ).alpha = value;
		}
		
		public function get thickness():Number { return _graphicsStroke.thickness; }
		
		public function set thickness( value:Number ):void
		{
			if ( _graphicsStroke.thickness == value )
				return;
			
			_graphicsStroke.thickness = value;
		}
		
	}
	
}