
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package items.characters 
{
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import main.Const;
	import plateau.Plateau;
	
	public class Player extends Character 
	{
		private var aKeys:Array = [];
		private var vx:int;
		private var vy:int;
		
		private var plateau:Plateau;
		private var aCells:Array = [];
		
		public function Player() 
		{			
			this.graphics.beginFill( 0x0000FF );
			this.graphics.drawRect( 0, -100, 50, 100 );
			this.graphics.endFill();
			
			this.graphics.beginFill( 0xFF0000 );
			this.graphics.drawCircle( 0, 0, 5 );
			this.graphics.endFill();
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			plateau = this.parent as Plateau;
			aCells = plateau.aCells;
			
			defineActions();
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onDown(e:KeyboardEvent):void 
		{
			switch ( e.keyCode )
			{
				case Const.LEFT : 
				{
					vx = -5;
					vy = 0;
					
					if ( aKeys[ 0 ] != Const.LEFT ) aKeys.unshift( Const.LEFT );
					
					break;
				}
				case Const.UP : 
				{
					vx = 0;
					vy = -5;
					
					if ( aKeys[ 0 ] != Const.UP ) aKeys.unshift( Const.UP );
					
					break;
				}
				case Const.RIGHT :
				{
					vx = 5;
					vy = 0;
					
					if ( aKeys[ 0 ] != Const.RIGHT ) aKeys.unshift( Const.RIGHT );
					
					break;
				}
				case Const.DOWN : 
				{
					vx = 0;
					vy = 5;
					
					if ( aKeys[ 0 ] != Const.DOWN ) aKeys.unshift( Const.DOWN );
					
					break;
				}
			}
		}
		
		private function onUp(e:KeyboardEvent):void 
		{
			// Reset the value linked to the key up
			
			var key:int;
			
			switch ( e.keyCode )
			{
				case Const.LEFT : 
				{
					vx = 0;
					key = Const.LEFT;
					break;
				}
				case Const.UP : 
				{
					vy = 0;
					key = Const.UP;
					break;
				}
				case Const.RIGHT :
				{
					vx = 0;
					key = Const.RIGHT;
					break;
				}
				case Const.DOWN : 
				{
					vy = 0;
					key = Const.DOWN;
					break;
				}
			}
			
			// Check and refresh the keys pushed by the player
			
			var i:int;
			var n:int = aKeys.length;
			for ( i; i < n; i++ )
			{
				if ( aKeys[ i ] == key )
				{
					if ( i == 0 ) aKeys.shift();
					else if ( i == ( n - 1 ) ) aKeys.pop();
					else aKeys.splice( i, 1 );
				}
			}
			
			// Sets the value of the player walk
			
			key = aKeys[ 0 ];
			
			switch ( key )
			{
				case Const.LEFT : vx = -5; break;
				case Const.UP : vy = -5; break;
				case Const.RIGHT : vx = 5; break;
				case Const.DOWN : vy = 5; break;
			}
		}
		
		private function onFrame(e:Event):void 
		{
			//cell.x = int( ( this.x - 1 ) / 50 );
			//cell.y = int( ( this.y - 1 ) / 50 );
			//trace( "( this.y ) : " + ( this.y ) );
			trace( "cell : " + cell );
			
			if ( vx < 0 )
			{
				cell.x = int( ( this.x + 45 ) / 50 );
				cell.y = int( ( this.y  - 5 ) / 50 );
				if ( aCells[ int( cell.x - 1 ) ][ cell.y ].status == Const.FREE  ) this.x += vx;
			}
			else
			{
				cell.x = int( ( this.x ) / 50 );
				cell.y = int( ( this.y - 5) / 50 );
				if ( aCells[ int( cell.x + 1 ) ][ cell.y ].status == Const.FREE ) this.x += vx;
			}
			
			//
			
			if ( vy < 0 )
			{
				cell.x = int( ( this.x ) / 50 );
				cell.y = int( ( this.y - 5 ) / 50 );
				if ( aCells[ cell.x ][ int( cell.y - 1 ) ].status == Const.FREE ) this.y += vy;
			}
			else
			{
				cell.x = int( ( this.x ) / 50 );
				cell.y = int( ( this.y -50) / 50 );
				if ( aCells[ cell.x ][ int( cell.y + 1 ) ].status == Const.FREE ) this.y += vy;
			}
		}
		
		// PRIVATE	
		
		private function defineActions():void
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onUp );
		}
		
		// PUBLIC
		
	}
	
}