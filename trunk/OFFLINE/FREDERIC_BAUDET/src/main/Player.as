
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
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import gs.easing.Expo;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class Player extends Sprite 
	{
		public var vdo:FLVPlayback;
		public var zDownload:SimpleButton;
		
		private var loading:Loading;
		private var showLoading:Boolean;
		
		private var request:URLRequest;
		
		private var downloadable:Boolean;
		private var url:String;
		private var currentUrl:String;
		
		public function Player() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			TweenLite.killTweensOf( this );
			TweenLite.killTweensOf( vdo );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			this.x = 980 * .5;
			this.y = 560 * .5;
			this.scaleX =
			this.scaleY = 0;
			this.visible = false;
			
			vdo.bufferTime = .5;
			//vdo.seekBarScrubTolerance = 80;
			
			loading = new Loading();
			addChild( loading );
			
			zDownload.visible = false;
			zDownload.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			request = new URLRequest( "http://wystor.free.fr/" + currentUrl );
			try
			{
				navigateToURL( request, "_blank" );
			}
			catch ( er:Error )
			{
				trace ( "navigateToURL error : " + er.message );
			}
		}
		
		private function onReady( e:VideoEvent ):void
		{
			vdo.removeEventListener( VideoEvent.READY, onReady );
			
			vdo.seek( 0 );
			vdo.play();
			
			zDownload.visible = !downloadable ? true : false;
			if( showLoading ) closeWaitMess();
		}
		
		// PRIVATE
		
		private function deleting():void
		{
			vdo.seek( 0 );
			vdo.stop();
			this.visible = false;
		}
		
		private function showWaitMess():void
		{
			showLoading = true;
			
			loading.scaleX =
			loading.scaleY = 1;
		}
		
		private function closeWaitMess():void
		{
			showLoading = false;
			
			TweenLite.to( loading, .2, { scaleX: 0, scaleY: 0, ease: Expo.easeInOut } );
		}
		
		// PUBLIC
		
		public function init( url:String, downloadable:Boolean ):void
		{
			this.downloadable = downloadable; // downloadable = !isLocked();
			
			this.visible = true;
			vdo.volume = 1;
			vdo.seekBarInterval = 33;
			vdo.seekBarScrubTolerance = 1;
			
			if ( currentUrl == url )
			{
				vdo.seek( 0 );
				vdo.play();
				
				zDownload.visible = !downloadable ? true : false;
			}
			else
			{
				zDownload.visible = false;
				showWaitMess();
				
				vdo.addEventListener( VideoEvent.READY, onReady );
				vdo.load( url );
			}
			
			currentUrl = url;			
			
			TweenLite.to( this, .4, { scaleX: 1, scaleY: 1, ease: Expo.easeInOut } );
		}
		
		public function destroy():void
		{
			TweenLite.to( vdo, .4, { volume: 0, ease: Quad.easeOut } );
			TweenLite.to( this, .4, { scaleX: 0, scaleY: 0, ease: Expo.easeInOut, onComplete: deleting } );
		}
		
	}
	
}