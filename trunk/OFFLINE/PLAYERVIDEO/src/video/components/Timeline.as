
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package video.components 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import video.VideoPlayer;
	
	public class Timeline extends Sprite 
	{
		public static const CURSOR_OVER:String = "cursor_over";
		public static const CURSOR_DOWN:String = "cursor_down";
		public static const CURSOR_UP:String = "cursor_up";
		
		private var background:Shape;
		private var loadedBar:Sprite;
		private var playedBar:Sprite;
		private var bar:Sprite;
		private var cursor:MovieClip;
		
		private var xMax:Number;
		
		private var player:VideoPlayer;
		
		private var dragging:Boolean;
		
		private var temp:Number;
		
		public function Timeline( player:VideoPlayer, loadedBar:Sprite = null, playedBar:Sprite = null, bar:Sprite = null, cursor:MovieClip = null, background:Shape = null ) 
		{
			this.player = player;
			this.loadedBar = loadedBar;
			this.playedBar = playedBar;
			this.bar = bar;
			this.cursor = cursor;
			this.background = background;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			cursor.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			cursor.removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			bar.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			bar.removeEventListener( MouseEvent.CLICK, onClick );
			
			player.removeEventListener( VideoPlayer.PLAY, onPlay );
			player.removeEventListener( VideoPlayer.RESUME, onPlay );
			player.removeEventListener( VideoPlayer.PAUSE, onStop );
			player.removeEventListener( VideoPlayer.CLOSE, onStop );
			
			if ( hasEventListener( Event.ENTER_FRAME ) ) removeEventListener( Event.ENTER_FRAME, onFrame );
			if ( stage.hasEventListener( MouseEvent.MOUSE_UP ) ) stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			dispatchEvent( new Event( Timeline.CURSOR_DOWN ) );
			
			player.pause();
			
			dragging = true;
			
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onMouseOver(e:MouseEvent):void 
		{
			dispatchEvent( new Event( Timeline.CURSOR_OVER ) );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			cursor.x = e.localX;
			clickToSecond( e.localX );
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			dispatchEvent( new Event( Timeline.CURSOR_UP ) );
			
			removeEventListener( Event.ENTER_FRAME, onFrame );
			stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			
			dragging = false;
			
			player.resume();
		}
		
		private function onFrame(e:Event):void 
		{
			if ( dragging ) cursor.x = dragToSecond( stage.mouseX - ( this.x + bar.x ) );
			else cursor.x = getCursorPosition();
			
			playedBar.width = cursor.x;
			loadedBar.scaleX = player.bytesPercent;
		}
		
		private function onPlay(e:Event):void 
		{
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onStop(e:Event):void 
		{
			removeEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		// PRIVATE	
		
		private function init():void
		{
			addChild( background );
			bar.addChild( loadedBar );
			bar.addChild( playedBar );
			addChild( bar );
			addChild( cursor );
			
			xMax = ( bar.width - cursor.width );
			playedBar.width = 0;
			
			cursor.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			cursor.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			bar.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			bar.addEventListener( MouseEvent.CLICK, onClick );
			
			player.addEventListener( VideoPlayer.PLAY, onPlay );
			player.addEventListener( VideoPlayer.RESUME, onPlay );
			player.addEventListener( VideoPlayer.PAUSE, onStop );
			player.addEventListener( VideoPlayer.CLOSE, onStop );
		}
		
		// PUBLIC
		
		/**
		 * 
		 * @param	loadedBar
		 * @param	playedBar
		 * @param	bar
		 * @param	cursor
		 * @param	background
		 */
		public function config( loadedBar:Sprite, playedBar:Sprite, bar:Sprite, cursor:MovieClip, background:Shape = null ):void
		{
			this.loadedBar = loadedBar;
			this.playedBar = playedBar;
			this.bar = bar;
			this.cursor = cursor;
			this.background = background;
			
			init();
		}
		
		/**
		 * Permet d'aller à un temps T de la vidéo en prenant comme référentiel la timeline de 
		 * la vidéo.
		 * @param	px	Number	La position x du clic souris
		 * @param	width	Number	La largeur de la timeline
		 */
		public function clickToSecond( mouseX:Number ):void
		{			
			var percent:Number = ( 100 * mouseX ) / bar.width;
			var second:int = ( percent * player.vDuration ) / 100;
			
			player.toSecond( second );
		}
		
		/**
		 * Permet de calculer la position du curseur, et d'aller à un temps T de la vidéo en 
		 * prenant comme référentiel la timeline de la vidéo.
		 * Cette méthode est particulièrement adaptée en cas de 'drag' du curseur.
		 * @param	mouseX	Number	La position x de la souris.
		 * @param	posX	Number	La position x de la timeline.
		 * @param	timelineWidth	Number	
		 * @param	cursorWidth
		 * @return
		 */
		public function dragToSecond( mouseX:Number ):Number
		{
			temp = mouseX - ( cursor.width >> 1 ); // cursor accroche
			
			if ( temp <= bar.x ) temp = bar.x;
			else if ( temp >= bar.x + ( bar.width - cursor.width ) ) temp = bar.x + ( bar.width - cursor.width );
			
			clickToSecond( temp );
			
			return temp;
		}
		
		// Problème : on ne va pas au bout de la timeline.
		/** Récupère la position du curseur en fonction du temps de lecture */
		public function getCursorPosition():Number
		{
			var position:Number = ( player.time * bar.width ) / player.vDuration;
			
			if ( position >= 0 ) return ( position < xMax ) ? position : xMax;
			else return 0;
		}
		
	}
	
}