
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
	import video.VideoPlayer03;
	
	public class Timeline extends Sprite 
	{
		protected var background:Shape;
		public var loadedBar:Sprite;
		public var playedBar:Sprite;
		public var bar:Sprite;
		public var cursor:MovieClip;
		
		private var player:VideoPlayer03;
		
		private var temp:Number;
		
		public function Timeline( player:VideoPlayer03 = null ) 
		{
			trace( "Timeline.Timeline > player : " + player );
			this.player = player;
			
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
		
		// PRIVATE	
		
		private function init():void
		{
			addChild( background );
			bar.addChild( loadedBar );
			bar.addChild( playedBar );
			addChild( bar );
			addChild( cursor );
		}
		
		// PUBLIC
		
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
		public function clickToSecond( mouseX:Number ):void //////////////////////////////////////////////////////////////////// TIMELINE
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
		public function dragToSecond( mouseX:Number ):Number ///////////////////////////////////////////////////////////////// TIMELINE
		{
			temp = ( mouseX - 50 ) - ( cursor.width + ( cursor.width >> 1 ) );
			
			if ( temp <= bar.x ) temp = bar.x;
			else if ( temp >= bar.x + ( bar.width - cursor.width ) ) temp = bar.x + ( bar.width - cursor.width );
			
			clickToSecond( temp );
			return temp;
			return 0;
		}
		
		
		
	}
	
}