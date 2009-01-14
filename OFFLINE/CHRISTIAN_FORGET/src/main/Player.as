
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import caurina.transitions.Tweener;
	import fl.video.FLVPlayback;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Player extends MovieClip 
	{
		public var videoPlayer:FLVPlayback;
		
		private var format:TextFormat;
		private var infos:TextField;
		
		public function Player() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			Tweener.removeTweens( videoPlayer );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			init();
		}
		
		// PRIVATE
		
		private function init():void
		{
			videoPlayer.setSize( 640, 360 );
			videoPlayer.skinAutoHide = true;
			videoPlayer.skinBackgroundAlpha = .9;
			videoPlayer.skinFadeTime = 300;
			videoPlayer.bitrate = 2000;
			
			videoPlayer.bufferTime = .5;
			
			this.visible = false;
			
			var font:Font = new Myriad();
			format = new TextFormat( font.fontName, 12, 0xffffff );
			format.align = TextFormatAlign.CENTER;
			
			infos = new TextField();
			infos.width = 640;
			infos.multiline = true;
			infos.wordWrap = true;
			infos.embedFonts = true;
			infos.antiAliasType = AntiAliasType.ADVANCED;
			infos.autoSize = TextFieldAutoSize.LEFT;
			infos.y = 360 + 5;
			addChild( infos );
		}
		
		private function close():void
		{
			videoPlayer.stop();
			this.visible = false;
		}
		
		// PUBLIC
		
		public function load( url:String, director:String, production:String, postProduction:String ):void
		{
			show();
			videoPlayer.play( url );
			//videoPlayer.seek( 0 );
			
			infos.text = "Director : " + director + "\nProduction : " + production + "\nPostProduction : " + postProduction;
			infos.setTextFormat( format );
			
			dispatchEvent( new Event( Event.INIT, true ) );
		}
		
		public function show():void
		{
			this.alpha = .4;
			videoPlayer.volume = .4;
			this.visible = true;
			Tweener.addTween( this, { alpha: 1, transition: "easeInOutQuad", time: .8 } );
			Tweener.addTween( videoPlayer, { alpha: 1, volume: 1, transition: "easeInOutQuad", time: .8 } );
		}
		
		public function hide():void
		{
			Tweener.addTween( this, { alpha: .6, transition: "easeInOutQuad", time: .4 } );
			Tweener.addTween( videoPlayer, { volume: .4, transition: "easeInOutQuad", time: .4, onComplete: close } );
			//this.visible = false;
		}
		
	}
	
}