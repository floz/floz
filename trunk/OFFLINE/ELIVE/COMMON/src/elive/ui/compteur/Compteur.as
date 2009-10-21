
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.ui.compteur 
{
	import assets.GCompteur;
	import elive.utils.EliveUtils;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Compteur extends GCompteur
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _timer:Timer;
		
		private var _currentDate:Date;
		private var _compteurDate:Date;
		
		private var _days:int;
		private var _hours:int;
		private var _mins:int;
		private var _secs:int;
		
		private var _timestamp:Number;
		private var _initiated:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Compteur() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			stopTimer();
			_timer = null;
			
			_currentDate = 
			_compteurDate = null;
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
			
			if ( _initiated && !_timer.hasEventListener( TimerEvent.TIMER ) )
				startTimer();
		}
		
		private function timerHandler(e:TimerEvent):void 
		{
			_currentDate = new Date();
			
			var diff:int = _timestamp - _currentDate.getTime();
			_days = int( diff * .001 / 3600 / 24 );
			_hours = int( diff * .001 / 3600 - 24 * _days );
			_mins = int( diff * .001 / 60 - 1440 * _days - 60 * _hours );
			_secs = int( diff * .001 - 86400 * _days - 3600 * _hours - 60 * _mins );
			
			refreshText();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_timer = new Timer( 1000 );			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function startTimer():void
		{
			_timer.addEventListener( TimerEvent.TIMER, timerHandler, false, 0, true );
			_timer.start();
			
			timerHandler( null );
		}
		
		private function stopTimer():void
		{
			_timer.stop();
			_timer.removeEventListener( TimerEvent.TIMER, timerHandler );
		}
		
		private function refreshText():void
		{
			var text:String = _days <= 9 ? ( "0" + _days ) : _days.toString();
			EliveUtils.configureText( tfD, "compteur", text );
			
			text = _hours <= 9 ? ( "0" + _hours ) : _hours.toString();
			EliveUtils.configureText( tfH, "compteur", text );
			
			text = _mins <= 9 ? ( "0" + _mins ) : _mins.toString();
			if ( _mins == 60 ) text = "00";
			EliveUtils.configureText( tfM, "compteur", text );
			
			text = _secs <= 9 ? ( "0" + _secs ) : _secs.toString();
			if ( _secs == 60 ) text = "00";
			EliveUtils.configureText( tfS, "compteur", text );
			
			if ( _days <= -1 ) 
			{
				stopTimer();
				// TODO: Changement de status du défi
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setEndTime( timestamp:Number ):void
		{
			this._timestamp = timestamp;
			
			if ( stage && !_timer.hasEventListener( TimerEvent.TIMER ) ) 
				startTimer();
			
			_initiated = true;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}