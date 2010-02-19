
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.materials 
{
	import flash.display.CapsStyle;
	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	
	public class Material 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _graphicsStroke:GraphicsStroke = new GraphicsStroke( 0, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER );
		protected var _graphicsSolidFill:GraphicsSolidFill = new GraphicsSolidFill();
		protected var _graphicsEndFill:GraphicsEndFill = new GraphicsEndFill();
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var graphicsData:Vector.<IGraphicsData>;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Material() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}