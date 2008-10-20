
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
	import objects.characters.Player;
	import main.Const;
	
	public class Plateau extends MovieClip 
	{
		private static const P1:Point = new Point( 50, 100 );
		
		public var aCells:Array = [];
		public var cnt:MovieClip;
		
		/** Contient des tableaux de cellules. Chaque tableau contient une ligne de cellules */
		
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
		
		protected function initPlateau():void
		{
			var c:Cell;
			var a:Array;
			
			var status:String;
			
			var i:int; // y
			var j:int; // x
			var n:int = 11;
			for ( i; i < n; i++ )
			{
				a = [];
				
				for ( j; j < n; j++ )
				{
					status = ( !( j % 2 ) && !( i % 2 ) ) ? Const.BLOCKED : Const.FREE;
					if ( ( i == 0 ) || ( i == n - 1 ) || ( j == 0 ) || ( j == n - 1 ) ) status = Const.BLOCKED;
					
					c = new Cell( 50, status );
					c.x = c.width * j;
					c.y = c.width * i;
					cnt.addChild( c );
					
					a.push( c );
				}
				j = 0;
				
				aCells.push( a );
			}
			
			this.x = stage.stageWidth - this.width >> 1;
			this.y = stage.stageHeight - this.height  >> 1 ;
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
					
					player.cell.x = player.cell.y = 1;
				}
			}			
			
			addChild( player );
		}
		
	}
	
}