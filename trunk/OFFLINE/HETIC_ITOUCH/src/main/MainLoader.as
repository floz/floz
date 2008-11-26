
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import fr.minuit4.effects.Loading;
	
	public class MainLoader extends MovieClip
	{
		public var background:MovieClip;
		public var cnt:MovieClip;
		
		private var _loading:Loading;
		private var _request:URLRequest;
		private var _loader:Loader;
		
		private var _site:MovieClip;
		
		public function MainLoader() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_loading = new Loading( 0x7a7a7a, 24, 10 );
			_loading.x = ( stage.stageWidth >> 1 ) - ( _loading.width >> 1 );
			_loading.y = ( stage.stageHeight >> 1 ) - ( _loading.height >> 1 );
			addChild( _loading );
			
			_loading.play();
			
			background.width = stage.stageWidth;
			background.height = stage.stageHeight;
			
			_request = new URLRequest( "main.swf" );
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader.load( _request );
			
			stage.addEventListener( Event.RESIZE, onResize );
		}
		
		// EVENTS
		
		private function onLoadComplete(e:Event):void 
		{
			_loading.stop();
			_loading.kill();
			removeChild( _loading );
			
			_site = e.currentTarget.content as MovieClip;
			_site.x = ( stage.stageWidth >> 1 ) - ( _site.width >> 1 );
			_site.y = ( stage.stageHeight >> 1 ) - ( _site.height >> 1 );
			cnt.addChild( _site );
		}
		
		private function onIOError(e:Event):void 
		{
			trace ( "onIOError : " + _request.url );			
		}
		
		private function onResize(e:Event):void 
		{
			background.width = stage.stageWidth;
			background.height = stage.stageHeight;
			background.x = 
			background.y = 0;
			
			_site.x = ( stage.stageWidth >> 1 ) - ( _site.width >> 1 );
			_site.y = ( stage.stageHeight >> 1 ) - ( _site.height >> 1 );
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}