
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.materials 
{
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	
	public class ColorMaterial extends Material
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ColorMaterial( color:uint = 0xff00ff, alpha:Number = 1 ) 
		{
			_graphicsSolidFill.color = color;
			_graphicsSolidFill.alpha = alpha;
			
			graphicsData = Vector.<IGraphicsData>( [ _graphicsSolidFill, _graphicsStroke ] );
			graphicsData.fixed = true;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get color():uint { return _graphicsSolidFill.color; }
		
		public function set color(value:uint):void 
		{
			if ( _graphicsSolidFill.color == value ) 
				return;
			
			_graphicsSolidFill.color = value;
		}
		
		public function get alpha():Number { return _graphicsSolidFill.alpha; }
		
		public function set alpha(value:Number):void 
		{
			if ( _graphicsSolidFill.alpha == value ) 
				return;
			
			_graphicsSolidFill.alpha = value;
		}
		
	}
	
}