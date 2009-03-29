
/**
* Written by :
* @author : Floz - Florian Zumbrunn
* www.floz.fr || www.minuit-4.fr
* 
* Version log :
* 
* 28.08.08		1.0		Floz		+ Première version
*/
package fr.minuit4.effects 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class DisparitionTextEffect extends EventDispatcher
	{
		private var str:String;
		private var field:TextField;
		private var time:int;
		private var timer:Timer;
		private var _totalLenght:int;
		
		private var tempString:String;
		
		public function DisparitionTextEffect( str:String, field:TextField, time:int ):void 
		{
			if ( !str.length || !field ) return;
			
			this.str = str;
			this.field = field;
			this.time = time;
			
			field.text = str;
			_totalLenght = str.length;
			
			timer = new Timer( time / str.length, str.length );
			timer.addEventListener( TimerEvent.TIMER, onTimer );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
			timer.start();
			
			//
			
			dispatchEvent( new Event( Event.INIT ) );
		}
			
		// EVENTS
		
		private function onTimer(e:TimerEvent):void 
		{
			if ( !field || !field.parent ) remove();
			
			tempString = str.substring( 0, _totalLenght - e.currentTarget.currentCount );
			field.text = tempString;
			
			//
			
			dispatchEvent( new ProgressEvent( ProgressEvent.PROGRESS ) );
		}
		
		private function onTimerComplete(e:TimerEvent):void 
		{
			field.text = "";
			
			timer.removeEventListener( TimerEvent.TIMER, onTimer );
			timer.removeEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
			timer = null;
			
			str = null;
			
			//
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		// PRIVATE
		
		private function remove():void
		{
			timer.removeEventListener( TimerEvent.TIMER, onTimer );
			timer.removeEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
			timer = null;
			
			str = null;
			
			//
			
			dispatchEvent( new Event( Event.DEACTIVATE ) );
		}
		
		// PUBLIC
		
		/**
		 * Applique un effet d'apparition du texte au fur et à mesure.
		 * @param	str	String	Texte qui apparaîtra à la fin de l'effet.
		 * @param	field	TextField	Champs texte sur lequel l'effet va être appliqué.
		 * @param	time	int	Durée de l'effet.
		 */
		public static function apply( str:String, field:TextField, time:int = 1000 ):DisparitionTextEffect
		{
			return new DisparitionTextEffect( str, field, time );
		}
	}
	
}