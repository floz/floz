
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package objects.characters 
{
	import caurina.transitions.Tweener;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import main.Const;
	import game.Plateau;
	import objects.items.Bomb;
	
	public class Player extends Character 
	{
		private var timer:Timer;
		
		private var aKeys:Array = [];
		private var vx:int;
		private var vy:int;
		
		private var plateau:Plateau;
		private var aCells:Array = [];
		private var way:int;
		
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
			
			timer = new Timer( 1 );
			timer.addEventListener( TimerEvent.TIMER, onTimer );
		}
		
		private function onDown(e:KeyboardEvent):void 
		{
			switch ( e.keyCode )
			{
				case Const.LEFT : 
				{
					way = Const.LEFT;
					
					if ( aKeys[ 0 ] != Const.LEFT ) 
					{
						aKeys.unshift( way ); 
						launch();
					}
					
					break;
				}
				case Const.UP : 
				{
					way = Const.UP;
					
					if ( aKeys[ 0 ] != Const.UP ) 
					{
						aKeys.unshift( way ); 
						launch();
					}
					
					break;
				}
				case Const.RIGHT :
				{
					way = Const.RIGHT;
					
					if ( aKeys[ 0 ] != Const.RIGHT ) 
					{
						aKeys.unshift( way ); 
						launch();
					}
					
					break;
				}
				case Const.DOWN : 
				{
					way = Const.DOWN;
					
					if ( aKeys[ 0 ] != Const.DOWN ) 
					{
						aKeys.unshift( way ); 
						launch();
					}
					
					break;
				}
				case Const.SPACE :
				{
					var b:Bomb = new Bomb( aCells[ cell.x ][ cell.y ] );
				}
			}
		}
		
		private function onUp(e:KeyboardEvent):void 
		{
			timer.stop();
			timer.reset();
			
			// Reset the value linked to the key up
			
			way = 0;
			var key:int = e.keyCode;
			
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
			
			way = aKeys[ 0 ];
			if ( way ) launch();
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			if ( Tweener.isTweening( this ) ) return;
			if ( timer.currentCount ) timer.delay = speed;
			
			switch ( way )
			{
				case Const.LEFT : 
				{
					if ( aCells[ cell.x - 1 ][ cell.y ].status == Const.FREE )
					{
						vx = ( cell.x - 1 ) * 50;
						cell.x--;
						
						Tweener.addTween( this, { x: vx, time: timer.delay / 1000, transition: "linear" } );
					}					
					
					break;
				}
				case Const.UP :
				{
					if ( aCells[ cell.x ][ cell.y - 1 ].status == Const.FREE )
					{
						vy = ( cell.y - 1 ) * 50 + 50;
						cell.y--;
						
						Tweener.addTween( this, { y: vy, time: ( timer.delay - 10 ) / 1000, transition: "linear" } );
					}
					
					break;
				}
				case Const.RIGHT :
				{
					if ( aCells[ cell.x + 1 ][ cell.y ].status == Const.FREE )
					{
						vx = ( cell.x + 1 ) * 50;
						cell.x++;
						
						Tweener.addTween( this, { x: vx, time: ( timer.delay - 10 ) / 1000, transition: "linear" } ); 
					}
					
					break;
				}
				case Const.DOWN :
				{
					if ( aCells[ cell.x ][ cell.y + 1 ].status == Const.FREE )
					{
						vy = ( cell.y + 1 ) * 50 + 50;
						cell.y++;
						
						Tweener.addTween( this, { y: vy, time: ( timer.delay - 10 ) / 1000, transition: "linear" } );
					}
					
					break;
				}
			}
		}
		
		// PRIVATE	
		
		private function defineActions():void
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onUp );
		}
		
		private function launch():void
		{
			timer.stop();
			timer.reset();
			timer.delay = 1;
			timer.start();
		}
		
		// PUBLIC
		
	}
	
}