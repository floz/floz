
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
	import flash.events.MouseEvent;
	
	public class VignettesManager extends Sprite
	{
		private var downloader:Downloader;
		
		private var infosVignettes:Array;
		
		private var currentVignette:Vignette;
		
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
			
			infosVignettes = [];
			
			addEventListener( MouseEvent.ROLL_OVER, onOver );
			addEventListener( MouseEvent.ROLL_OUT, onOut );
			addEventListener( MouseEvent.CLICK, onClick );
			
			downloader = new Downloader();
			downloader.addEventListener( Downloader.ITEM_LOADED, onItemLoaded );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			currentVignette = Vignette( e.target );
			currentVignette.enlarge();
		}
		
		private function onOut(e:MouseEvent):void 
		{
			currentVignette.normalize();
		}
		
		private function onClick(e:MouseEvent):void 
		{
			
		}
		
		private function onItemLoaded(e:Event):void 
		{
			var o:Object = infosVignettes[ downloader.currentCount - 1 ];
			var v:Vignette = new Vignette( downloader.getLastItem(), o.flv, o.title, o.director, o.sound, randRange( 30, 60 ) );
			v.x = randRange( 50, 930 );
			v.y = randRange( 50, 510 );
			addChild( v );
			
			v.init();
			
			downloader.loadNext();
		}
		
		// PRIVATE
		
		private function randRange( min:Number, max:Number, plus:Number = 0 ):Number
		{
			var n:Number = ( Math.random() * ( max - min ) + min )
			return  n = ( n < 0 ) ? n - plus : n + plus;
		}
		
		// PUBLIC
		
		public function load( infos:Array ):void
		{
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
			var n:int = numChildren;
			for ( i; i < n; i++ ) a.push( getChildAt( i ) );
			for ( i = 0; i < n; i++ ) a[ i ].destroy();			
		}
		
	}
	
}