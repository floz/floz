
package floz.helpers 
{
	import flash.events.EventDispatcher;
	
	public class Dispatcher 
	{
		protected var dispatcher:EventDispatcher;
		
		public function Dispatcher () 
		{
			dispatcher = new EventDispatcher;
		}
		
		// PUBLIC
		
		public function addEventListener ( 	type:String,
											listener:Function,
											useCapture:Boolean = false,
											priority:int = 0,
											useWeakReference:Boolean = false ):void
		{
			dispatcher.addEventListener( type, listener, useCapture, priority, useCapture );
		}
		
		public function removeEventListener ( type:String,
											  listener:Function,
											  useCapture:Boolean = false ):void
		{
			dispatcher.removeEventListener( type, listener, useCapture );
		}
	}
}




