
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Main extends MovieClip
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			var f:Fonts = new Fonts();
			f.addEventListener( Event.COMPLETE, onComplete );
			f.load( "fonts.swf" );
		}
		
		private function onComplete(e:Event):void 
		{
			var tf:TextFormat = new TextFormat( Fonts( e.currentTarget ).getItemLoaded().futura.fontName );
			tf.size = 36;
			var t:TextField = new TextField();
			t.text = "TOTOTOOTOTOTO tototo lolla";
			t.setTextFormat( tf );
			
			addChild( t );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}