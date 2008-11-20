
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
		
		private var _main:Main;
		private var player:Player;
		
		private var downloaderWorks:Downloader;
		private var downloaderArchives:Downloader;
		private var downloader:Downloader;
		
		private var over:Boolean;
		private var loading:Loading;
		
		public function Screen() 
		{
			screen = new BitmapData( 640, 360, true, 0x00ffffff );
			addChild( new Bitmap( screen ) );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{			
			_main = getAncestor( this, Main ) as Main;
			_main.addEventListener( Main.READY, onReady );
			
			loading = new Loading();
			loading.x = (screen.width >> 1) - loading.width;
			loading.y = (screen.height >> 1) - loading.height;
			addChild( loading );
			
			player = new Player( 640, 360 );
			addChild( player );
		}
		
		private function onReady(e:Event):void 
		{
			downloaderWorks = new Downloader( _main.works.length );
			downloaderWorks.addEventListener( Event.COMPLETE, onLoadComplete );
			
			downloaderArchives = new Downloader( _main.archives.length );
			downloaderArchives.addEventListener( Event.COMPLETE, onLoadComplete );
			
			downloader = downloaderWorks;
		}
		
		private function onLoadComplete(e:Event):void 
		{
			loading.stop();
			
			show();
		}
		
		// PRIVATE
		
		private function show():void
		{
			var bd:BitmapData = downloader.getImage();			
			if ( bd.width != 640 || bd.height != 360 ) bd = resize( bd );
			
			if ( over ) screen.draw( bd );
		}
		
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
		
		public function change( section:String ):void
		{
			switch( section )
			{
				case Main.WORKS : downloader = downloaderWorks; break;
				case Main.ARCHIVES : downloader = downloaderArchives; break;
			}
		}
		
		public function display( url:String ):void
		{
			over = true;
			
			if ( downloader.checkIfDownloaded( _main.getPathImages() + url ) )
			{
				show();
			}
			else
			{
				downloader.load( url );			
				loading.play();
			}			
		}
		
		public function clear():void
		{
			over = false;
			screen.fillRect( screen.rect, 0x00ffffff );
		}
		
		public function select( url:String ):void
		{
			downloader.stop();
			player.play( url );
		}
		
	}
	
}