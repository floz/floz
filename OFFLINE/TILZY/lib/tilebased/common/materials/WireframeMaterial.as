
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.common.materials 
{
	import flash.display.GraphicsSolidFill;
	import flash.display.IGraphicsData;
	
	public class WireframeMaterial extends Material
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _color:uint;
		private var _alpha:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function WireframeMaterial( color:uint, alpha:Number, thickness:Number = 1 ) 
		{
			this._color = color;
			this._alpha = alpha;
			
			_graphicsStroke.fill = new GraphicsSolidFill( color, alpha );
			_graphicsStroke.thickness = thickness;
			
			graphicsData = Vector.<IGraphicsData>( [ _graphicsStroke ] );
			graphicsData.fixed = true;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get color():uint { return _graphicsSolidFill.color; }
		
		public function set color(value:uint):void 
		{
			if ( _color == value ) 
				return;
			
			_color = value;
			( _graphicsSolidFill as GraphicsSolidFill ).color = value;
		}
		
		public function get alpha():Number { return _graphicsSolidFill.alpha; }
		
		public function set alpha(value:Number):void 
		{
			if ( _alpha == value ) 
				return;
			
			_alpha = value;
			( _graphicsSolidFill as GraphicsSolidFill ).alpha = value;
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