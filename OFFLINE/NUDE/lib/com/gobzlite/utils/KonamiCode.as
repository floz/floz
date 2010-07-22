package  com.gobzlite.utils
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * KonamiCode
	 * 
	 * -------------------
	 * + usage
	 * -------------------
	 * 
	 * KonamiCode.add( stage, callback );
	 * 
 	 * @usage KonamiCode.add( stage, callback );
	 */
	public class KonamiCode extends EventDispatcher
	{
		private static var currentTouch:uint = 0;
		private static var callback:Function;
		private static var pushTouch:Array = [
			Keyboard.UP, 
			Keyboard.UP,
			Keyboard.DOWN,
			Keyboard.DOWN,
			Keyboard.LEFT,
			Keyboard.RIGHT,
			Keyboard.LEFT,
			Keyboard.RIGHT,
			"A".charCodeAt(0),
			"B".charCodeAt(0),
			Keyboard.ENTER
		];
		
		public function KonamiCode() 
		{
			throw(new Error("KonamiCode can't be instanciated\n Use 'KonamiCode.add( stage, callback)'"));
		}
		
		/**
		 * Add konami code handler on stage
		 * 
		 * @param	stage Main Stage
		 * @param	callback callback function call when konamicode is finish
		 * @usage KonamiCode.add( stage, callback );
		 */
		public static function add( stage:Stage, callback:Function):void 
		{
			if ( stage == null || callback == null )
				return;
			KonamiCode.callback = callback;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
		}
		
		/**
		 * Check if key is in konami code sequence
		 */
		private static function keyHandler(e:KeyboardEvent):void 
		{
			if ( pushTouch[currentTouch] == e.keyCode )
			{
				currentTouch++;
				if ( currentTouch == pushTouch.length )
				{
					callback();
					currentTouch = 0;
				}
			} 
			else 
			{
				currentTouch = 0;
			}
		}
	}
}