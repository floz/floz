
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
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class VignettesManager extends Sprite
	{
		private var bubbles:Bubbles;
		private var cnt:Sprite;
		private var downloader:Downloader;
		
		private var infosVignettes:Array;
		
		private var currentVignette:Vignette;
		//private var dispToSwap:Sprite;
		
		// Default var
		
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
			
			bubbles = new Bubbles();
			addChild( bubbles );
			
			cnt = new Sprite();
			cnt.addEventListener( Vignette.VIGNETTE_OVER, onVignetteOver );
			cnt.addEventListener( Vignette.VIGNETTE_OUT, onVignetteOut );
			cnt.addEventListener( Vignette.VIGNETTE_TO_FRONT, onVignetteToFront );
			cnt.addEventListener( Vignette.VIGNETTE_TO_BACK, onVignetteToBack );
			addChild( cnt );
			
			infosVignettes = [];
			
			downloader = new Downloader();
			downloader.addEventListener( Downloader.ITEM_LOADED, onItemLoaded );
		}
		
		private function onVignetteOver(e:Event):void 
		{
			currentVignette = e.target as Vignette;
			
			currentVignette.addEventListener( MouseEvent.MOUSE_MOVE, onMove );
			bubbles.bubble( currentVignette.x, currentVignette.y );
		}
		
		private function onMove(e:MouseEvent):void 
		{
			bubbles.xVel = int( e.localX / 5 );
			bubbles.yVel = int( e.localY / 5 );
		}
		
		private function onVignetteOut(e:Event):void 
		{
			if ( currentVignette ) currentVignette.removeEventListener( MouseEvent.MOUSE_MOVE, onMove );
			if ( bubbles.isRunning() ) bubbles.killBubbles();
		}
		
		private function onVignetteToFront(e:Event):void { cnt.setChildIndex( e.target as Sprite, cnt.numChildren - 1 ); }
		
		private function onVignetteToBack(e:Event):void { cnt.setChildIndex( e.target as Sprite, e.target.getIndex() ); }
		
		private function onItemLoaded(e:Event):void 
		{
			var o:Object = infosVignettes[ downloader.currentCount - 1 ];
			var v:Vignette = new Vignette( downloader.getLastItem(), o.flv, o.title, o.director, o.sound, randRange( 40, 90 ) );
			v.x = Const.POSITIONS[ downloader.currentCount - 1 ].x + 60;
			v.y = Const.POSITIONS[ downloader.currentCount - 1 ].y + 50;
			
			v.name = "Vignette" + downloader.currentCount.toString();
			cnt.addChild( v );
			cnt.setChildIndex( v, downloader.currentCount - 1 );
			v.setIndex( downloader.currentCount - 1 );
			v.init();			
			
			downloader.loadNext();
		}
		
		// PRIVATE
		
		private function randRange( min:Number, max:Number ):Number
		{
			var n:Number = ( Math.random() * ( max - min ) + min )
			return n;
		}
		
		private function getRadians( degres:Number ):Number
		{
			return ( Math.PI * degres ) / 180;	
		}
		
		// PUBLIC
		
		public function load( infos:Array ):void
		{
			currentVignette = null;
			
			var a:Array = [];
			infosVignettes = infos;
			
			downloader.clear();
			clear();
			
			var n:int = infos.length;
			for ( var i:int; i < n; i++ ) a.push( infos[ i ].img );
			
			downloader.addURLs( a );
			downloader.loadNext();
		}
		
		public function clear():void
		{
			var a:Array = [];
			
			var i:int;
			var n:int = cnt.numChildren;
			for ( i; i < n; i++ ) a.push( cnt.getChildAt( i ) );
			for ( i = 0; i < n; i++ ) a[ i ].destroy();			
		}
	}
	
}