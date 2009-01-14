
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
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class SoundManager extends MovieClip
	{
		public var z:SimpleButton;
		
		private var activated:Boolean;
		private var request:URLRequest;
		private var sound:Sound;
		private var soundTransf:SoundTransform;
		private var channel:SoundChannel;
		
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
			
			request = new URLRequest( "assets/fredmusic.mp3" );
			
			sound = new Sound();
			sound.load( request );
			
			soundTransf = new SoundTransform( .35 );
			channel = sound.play( 0, 100, soundTransf );
			
			z.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if ( activated )
			{
				gotoAndPlay( "showOff" );
				pause();
				
				activated = false;
			}
			else 
			{
				gotoAndPlay( "closeOff" );
				resume();
				
				activated = true;
			}
		}
		
		// PRIVATE
		
		private function applyVolume():void
		{
			channel.soundTransform = soundTransf;
		}
		
		// PUBLIC
		
		public function pause():void
		{
			TweenLite.to( soundTransf, .4, { volume: 0, ease: Quad.easeOut, onUpdate: applyVolume } );
		}
		
		public function resume():void
		{
			TweenLite.killTweensOf( soundTransf );
			TweenLite.to( soundTransf, .4, { volume: .35, ease: Quad.easeOut, onUpdate: applyVolume } );
		}
		
		public function isActivated():Boolean { return this.activated; }
		
	}
	
}