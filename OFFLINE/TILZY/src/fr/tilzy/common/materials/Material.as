﻿
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
	
	public class Material 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _graphicsStroke:GraphicsStroke = new GraphicsStroke();
		protected var _graphicsSolidFill:GraphicsSolidFill = new GraphicsSolidFill();
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var graphicsData:Vector.<IGraphicsData>;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Material() 
		{
			// ABSTRACT
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}