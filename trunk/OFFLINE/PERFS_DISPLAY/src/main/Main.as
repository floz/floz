
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.tools.perfs.FPS;
	//import fr.minuit4.tools.FPS;
	//import havas.tools.FPS;
	
	public class Main extends MovieClip
	{
		private var fps:FPS;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			fps = new FPS()
			fps.x = fps.y = 5;
			addChild( fps );
			
			stage.addEventListener( MouseEvent.CLICK, onClick );
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onClick(e:MouseEvent):void 
		{
			if ( hasEventListener( Event.ENTER_FRAME ) ) removeEventListener( Event.ENTER_FRAME, onFrame );
			else addEventListener( Event.ENTER_FRAME, onFrame );
			//if ( fps.isRunning() ) fps.pause();
			//else fps.play();
		}
		
		private function onFrame(e:Event):void 
		{
			addChild( new Bitmap( new BitmapData( 200, 200, true, 0x00 ) ) );
		}
		
		
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		// - END CLASS -------------------------------------------------------------------
		
	}
	
}