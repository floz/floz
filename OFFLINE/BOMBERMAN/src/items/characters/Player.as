
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
	
	public class Player extends Character 
	{
		private var aKeys:Array = [];
		private var vx:int;
		private var vy:int;
		
		public function Player() 
		{			
			this.graphics.beginFill( 0x0000FF );
			this.graphics.drawRect( 0, 0, 50, 65 );
			this.graphics.endFill();
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
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
			
			//var i:int;
			//var n:int = aKeys.length;
			//for ( i; i < n; i++ )
				//if ( aKeys[ i ] = key ) 
		}
		
		private function onFrame(e:Event):void 
		{
			trace ( aKeys );
			this.x += vx;
			this.y += vy;
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