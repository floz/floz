
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package floz.game.core 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class GameEngine 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _instance:GameEngine;
		private static var _allowInstanciation:Boolean;
		
		private static var _stage:Stage;
		private static var _parserHolder:Sprite;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function GameEngine() 
		{
			if ( !_allowInstanciation ) throw new Error( "This is a Singleton class, use the getInstance() method instead." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():GameEngine
		{
			if ( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new GameEngine();
				} _allowInstanciation = false;
			}
			return _instance;
		}
		
		public static function initialize( stage:Stage ):void
		{
			_stage = stage;
			_parserHolder = new Sprite();
			_parserHolder.x = _parserHolder.y = -9999;
			_stage.addChildAt( _parserHolder, 0 );
		}
		
		public static function addParsedObject( parsedObject ):void
		{
			_parserHolder.addChild( parsedObject );
		}
		
		public static function disposeParsedObject( parsedObject ):void
		{
			_parserHolder.removeChild( parsedObject );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public static function get stage():Stage { return _stage; }
		
	}
	
}