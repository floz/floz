
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
	import video.VideoPlayer03;
	
	public class Timeline extends Sprite 
	{
		protected var background:Shape;
		public var loadedBar:Sprite;
		public var playedBar:Sprite;
		public var bar:Sprite;
		public var cursor:MovieClip;
		
		private var player:VideoPlayer03;
		
		private var activated:Boolean;
		private var dragging:Boolean;
		
		private var temp:Number;
		
		public function Timeline( player:VideoPlayer03, loadedBar:Sprite = null, playedBar:Sprite = null, bar:Sprite = null, cursor:MovieClip = null, background:Shape = null ) 
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
			
			if ( activated )
			{
				cursor.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				bar.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				bar.removeEventListener( MouseEvent.CLICK, onClick );
				
				player.removeEventListener( VideoPlayer03.PLAY, onPlay );
				player.removeEventListener( VideoPlayer03.RESUME, onPlay );
				player.removeEventListener( VideoPlayer03.PAUSE, onStop );
				player.removeEventListener( VideoPlayer03.CLOSE, onStop );
				
				if ( hasEventListener( Event.ENTER_FRAME ) ) removeEventListener( Event.ENTER_FRAME, onFrame );
				if ( stage.hasEventListener( MouseEvent.MOUSE_UP ) ) stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			}
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			player.pause();
			
			dragging = true;
			
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			cursor.x = e.localX;
			clickToSecond( e.localX );
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			removeEventListener( Event.ENTER_FRAME, onFrame );
			stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			
			dragging = false;
			
			player.resume();
		}
		
		private function onFrame(e:Event):void 
		{
			if ( dragging ) cursor.x = dragToSecond( stage.mouseX - ( this.x + bar.x ) );
			else cursor.x = getCursorPosition();
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
			
			if ( activated )
			{
				cursor.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				bar.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				bar.addEventListener( MouseEvent.CLICK, onClick );
				
				player.addEventListener( VideoPlayer03.PLAY, onPlay );
				player.addEventListener( VideoPlayer03.RESUME, onPlay );
				player.addEventListener( VideoPlayer03.PAUSE, onStop );
				player.addEventListener( VideoPlayer03.CLOSE, onStop );
			}
		}
		
		// PUBLIC
		
		/**
		 * 
		 * @param	loadedBar
		 * @param	playedBar
		 * @param	bar
		 * @param	cursor
		 * @param	background
		 * @param	activated
		 */
		public function config( loadedBar:Sprite, playedBar:Sprite, bar:Sprite, cursor:MovieClip, background:Shape = null, activated:Boolean = false ):void
		{
			this.loadedBar = loadedBar;
			this.playedBar = playedBar;
			this.bar = bar;
			this.cursor = cursor;
			this.background = background;
			
			this.activated = activated;
			
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
		
		public function getCursorPosition():Number
		{
			var position:Number = ( player.time * bar.width ) / player.vDuration;  // attention le curseur sort de la timeline a la fin de la vidéo
			return ( position >= 0 ) ? position : 0;
		}
		
	}
	
}