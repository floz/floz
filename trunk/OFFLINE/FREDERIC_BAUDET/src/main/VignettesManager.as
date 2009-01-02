
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import com.carlcalderon.arthropod.Debug;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class VignettesManager extends Sprite
	{
		private var downloader:Downloader;
		
		public function VignettesManager() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			downloader = new Downloader();
			downloader.addEventListener( Downloader.ITEM_LOADED, onItemLoaded );
		}
		
		private function onItemLoaded(e:Event):void 
		{
			Debug.bitmap( new Bitmap( downloader.getLastItem() ) );
			
			downloader.loadNext();
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function load( infos:Array ):void
		{
			var a:Array;
			
			var n:int = infos.length;
			for ( var i:int; i < n; i++ ) a.push( infos[ i ].img );
			
			trace( a );
		}
		
		public function clean():void
		{
			while ( this.numChildren ) removeChildAt( 0 );
		}
		
	}
	
}