
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package objects.items 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import game.Cell;
	import main.Const;
	
	public class Bomb extends EventDispatcher
	{
		public static const EXPLOSION:String = "explosion";
		
		private var cell:Cell;
		private var timer:Timer;
		
		public function Bomb( cell:Cell ) 
		{
			trace ( "bomb planted !" );
			this.cell = cell;
			
			this.cell.status = Const.BOMB;
			
			timer = new Timer( Const.BOMB_DURATION, 1 );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
			timer.start();
		}
		
		// EVENTS
		
		private function onTimerComplete(e:TimerEvent):void 
		{
			explosion();
			
			cell.status = Const.FREE;
			
			timer.removeEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
			timer = null;
		}
		
		// PRIVATE
		
		private function explosion():void
		{
			trace ( "BADABOUM !" );
			
			dispatchEvent( new Event( Bomb.EXPLOSION ) );
		}
		
		// PUBLIC
		
	}
	
}