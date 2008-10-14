
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package plateau 
{	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import items.characters.Player;
	
	public class Plateau extends MovieClip 
	{
		private static const P1:Point = new Point( 0, -15 );
		
		public var cnt:MovieClip;
		
		public function Plateau() 
		{
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
			
			initPlateau();
		}
		
		// PRIVATE
		
		private function initPlateau():void
		{
			var c:Cell;
			
			var i:int;
			var j:int;
			var n:int = 10;
			for ( i; i < n; i++ )
			{				
				for ( j; j < n; j++ )
				{
					c = new Cell();
					c.x = c.width * j;
					c.y = c.width * i;
					cnt.addChild( c );
				}
				j = 0;
			}
		}
		
		// PUBLIC
		
		public function addPlayer( player:Player, position:String = null ):void
		{
			switch ( position )
			{
				case null :
				{
					player.x = P1.x;
					player.y = P1.y;
				}
			}			
			
			addChild( player );
		}
		
	}
	
}