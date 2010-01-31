
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.display 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	public class Dummy extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _width:Number;
		private var _height:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Dummy( width:Number, height:Number ) 
		{
			this._width = width;
			this._height = height;
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			var g:Graphics = this.graphics;
			g.clear();
			g.lineStyle( 1, 0x000000 );
			g.beginFill( 0xff00ff );
			g.drawRect( 0, 0, _width * .25, _height * .25 );
			g.endFill();
			
			g.lineStyle( 1, 0x000000 );
			g.beginFill( 0x000000 );
			g.drawRect( _width * .25, 0, _width * .25, _height * .25 );
			g.drawRect( 0, _height * .25, _width * .25, _height * .25 );
			g.endFill();
			
			g.lineStyle( 1, 0x000000 );
			g.beginFill( 0xff00ff );
			g.drawRect( _width * .25, _height * .25, _width * .25, _height * .25 );
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}