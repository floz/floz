
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	public class MainLoader extends MovieClip 
	{
		public var cnt:MovieClip;
		public var loadingMsg:MovieClip;
		
		private var request:URLRequest;
		private var loader:Loader;
		private var site:MovieClip;
		
		public function MainLoader() 
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
			
			stage.addEventListener( Event.RESIZE, onResize );
			
			request = new URLRequest( "main.swf" );
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOErrorEvent );
			loader.load( request) ;
		}
		
		private function onResize(e:Event):void 
		{
			site.x = stage.stageWidth * .5 - 980 * .5;
			site.y = stage.stageHeight * .5 - 560 * .5;			
		}
		
		private function onComplete(e:Event):void 
		{
			if ( e.currentTarget.content is MovieClip ) site = e.currentTarget.content;
			
			site.x = stage.stageWidth * .5 - 980 * .5;
			site.y = stage.stageHeight * .5 - 560 * .5;
			addChild( site );
			removeChild( loadingMsg );
		}
		
		private function onIOErrorEvent(e:IOErrorEvent):void 
		{
			trace( "MainLoader.onIOErrorEvent : " + request.url );			
		}
		
		// PRIVATE	
		
		// PUBLIC
		
	}
	
}