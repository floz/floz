
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import caurina.transitions.Tweener;
	import fl.video.FLVPlayback;
	import fl.video.VideoEvent;
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
		
		private var flv:String;
		
		private var format:TextFormat;
		private var infos:TextField;
		
		private var currentUrl:String;
		private var loading:Loading;
		
		public function Player( flv:String ) 
		{
			this.flv = flv;
			
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
		
		private function onReady(e:VideoEvent):void 
		{
			videoPlayer.removeEventListener( VideoEvent.READY, onReady );
			
			loading.stop();
			videoPlayer.seek( 0 );
			videoPlayer.play();
		}
		
		// PRIVATE
		
		private function init():void
		{			
			videoPlayer.bufferTime = .5;
			
			loading = new Loading( 0xffffff, 1, 4, 10, .9 );
			loading.x = (parent.width >> 1) - loading.width - 2;
			loading.y = (parent.height >> 1) - loading.height - 2;
			addChild( loading );
			
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
			
			if ( currentUrl == url )
			{
				videoPlayer.seek( 0 );
				videoPlayer.play();
			}
			else
			{
				loading.play();
				
				videoPlayer.addEventListener( VideoEvent.READY, onReady );
				videoPlayer.load( url );
			}
			
			currentUrl = url;
			
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
			Tweener.addTween( videoPlayer, { alpha: 1, volume: .8, transition: "easeInOutQuad", time: .8 } );
		}
		
		public function hide():void
		{
			Tweener.addTween( this, { alpha: .6, transition: "easeInOutQuad", time: .4 } );
			Tweener.addTween( videoPlayer, { volume: .4, transition: "easeInOutQuad", time: .4, onComplete: close } );
		}
		
	}
	
}