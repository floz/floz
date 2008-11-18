
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Matrix;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import video.VideoPlayer;
	
	public class Screen extends MovieClip
	{
		private var screen:BitmapData;
		private var bScreen:Bitmap;
		
		private var downloader:Downloader;
		private var _main:Main;
		private var player:VideoPlayer;
		
		public function Screen() 
		{
			screen = new BitmapData( 640, 360, true, 0x00ffffff );
			bScreen = new Bitmap( screen )
			addChild( bScreen );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			downloader = new Downloader();
			downloader.addEventListener( Event.COMPLETE, onLoadComplete );
			
			_main = getAncestor( this, Main ) as Main;
			
			player = new VideoPlayer( 640, 360 );
			addChild( player );
		}
		
		// EVENTS
		
		private function onLoadComplete(e:Event):void 
		{
			var bd:BitmapData = downloader.getImage();			
			if ( bd.width != 640 || bd.height != 360 ) bd = resize( bd );
			
			screen.draw( bd );
		}
		
		// PRIVATE
		
		private function resize( image:BitmapData )
		{
			var m:Matrix = new Matrix( 640 / image.width, 0, 0, 360 / image.height );
			var bd:BitmapData = new BitmapData( 640, 360, true, 0x00ffffff );
			bd.draw( image, m );
			
			return bd;
		}
		
		private function getAncestor( child:DisplayObject, type:* ):*
		{
			var c:DisplayObject = child;
			
			while ( c.parent )
			{
				if ( c.parent is type ) return c.parent;
				c = c.parent;
			}
			
			return null;
		}
		
		// PUBLIC
		
		public function display( url:String ):void
		{
			downloader.load( _main.getPathImages() + url );
			bScreen.alpha = 1;
		}
		
		public function clear():void
		{
			bScreen.alpha = 0;
			screen.fillRect( screen.rect, 0x00ffffff );
		}
		
		public function select( url:String ):void
		{
			
		}
		
	}
	
}