
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.festivaldumot.applications.fontmodifier 
{
	import flash.display.Sprite;
	
	public class Canvas extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _layer:Layer;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Canvas() 
		{
			_layer = new Layer();
			addChild( _layer );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addWord( word:String ):void
		{
			_layer.addWord( word );		
		}
		
		public function clear():void
		{
			_layer.clear();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}