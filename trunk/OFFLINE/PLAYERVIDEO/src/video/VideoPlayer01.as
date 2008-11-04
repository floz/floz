
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package video 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class VideoPlayer01 extends Sprite
	{
		private var hide:Boolean;
		
		private var connection:NetConnection;
		private var stream:NetStream;
		private var request:URLRequest;
		private var loader:URLLoader;
		private var vdo:Video;
		
		private var url:String;
		
		public function VideoPlayer01( hide:Boolean = true ) 
		{
			this.hide = hide;
			
			connection = new NetConnection();
			connection.connect( null );
			
			stream = new NetStream( connection );
			stream.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			stream.addEventListener( AsyncErrorEvent.ASYNC_ERROR, onAsyncError );
			stream.client = this;
			
			request = new URLRequest();
			loader = new URLLoader();
			loader.addEventListener( Event.COMPLETE, onLoadComplete );
			loader.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onNetStatus(e:NetStatusEvent):void 
		{
			trace ( e.info.code );
		}
		
		private function onAsyncError(e:AsyncErrorEvent):void 
		{
			trace( "VideoPlayer01.onAsyncError > e : " + e );
			
		}
		
		private function onLoadComplete(e:Event):void 
		{
			//dispatchEvent( new
			play();
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace ( "IOError : " + request.url );
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function onMetaData( o:Object ):void
		{
			for ( var p:Object in o ) trace ( p + " : " + o[ p ] );
			
			vdo.width = o.width;
			vdo.height = o.height;
		}
		
		public function preload( url:String = null ):void
		{
			if ( url ) this.url = url;
			
			request.url = this.url;
			loader.load( request );
		}
		
		public function play():void
		{
			if ( !vdo )
			{
				vdo = new Video();
				vdo.attachNetStream( stream );
				addChild( vdo );
			}
			
			stream.play( this.url );
			stream.seek( 0 );
		}
		
		public function pause():void
		{
			stream.pause();
		}
		
		public function resume():void
		{
			stream.resume();
		}
		
		public function stop():void
		{
			stream.close();
		}
		
		public function goTo( idx:int ):void
		{
			stream.seek( idx );
		}
		
	}
	
}