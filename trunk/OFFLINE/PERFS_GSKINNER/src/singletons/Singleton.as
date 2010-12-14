
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package singletons 
{
	
	public class Singleton
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _allowInstanciation:Boolean = false;
		private static var _instance:Singleton;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Singleton() 
		{
			if( _allowInstanciation )
			{
				
			}
			else throw new Error( "This class is a Singleton and cannot be instanciated. Please, use the 'getInstance' method instead" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():Singleton
		{
			if( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new Singleton();
				} _allowInstanciation = false;
			}
			return _instance;
		}
		
		public function test():void { }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}