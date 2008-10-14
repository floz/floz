
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
		
		/** Contient des tableaux de cellules. Chaque tableau contient une ligne de cellules */
		private var aCells:Array = [];
		
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
			
			var a:Array = [];
			var status:String = Const.FREE;
			var b1:Boolean;
			var b2:Boolean;
			
			var i:int;
			var j:int;
			var n:int = 10;
			for ( i; i < n; i++ )
			{
				a = [];
				for ( j; j < n; j++ )
				{
					if ( i == 0 )					
					{
						
					}
					else if ( i == n - 1 )
					{
						
					}
					else 
					{
						if ( a[ 0 ] )
							b1 = ( a[ j - 1 ].status == Const.FREE || a[ j - 1 ].status == Const.DESTROYABLE ) ? true : false;
						
						b2 = ( aCells[ i - 1 ][ j ].status == Const.FREE || aCells[ i - 1 ][ j ].status == Const.DESTROYABLE ) ? true : false;
						
						if ( b1 && b2 ) status = Const.STATUS[ int( Math.random ) * 3 ];
						else status = Const.STATUS[ int( Math.random ) * 2 ];
						trace ( b1 && b2 );
						
					}
					
					c = new Cell( 50, status );
					c.x = c.width * j;
					c.y = c.width * i;
					cnt.addChild( c );
					
					a.push( c );
				}
				aCells.push( a );
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