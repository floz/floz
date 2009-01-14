
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	public class SoundManager extends MovieClip
	{
		public var z:SimpleButton;
		
		private var activated:Boolean;
		private var sound:Sound;
		
		public function SoundManager() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			activated = true;
			stop();
			
			this.alpha = .5;
			z.enabled = false;
			
			sound = new Sound();
			sound.load(  new URLRequest( "assets/fredmusic.mp3" ) );
			sound.play();
			
			z.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if ( activated )
			{
				gotoAndPlay( "showOff" );
				activated = false;
			}
			else 
			{
				gotoAndPlay( "closeOff" );
				activated = true;
			}
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}