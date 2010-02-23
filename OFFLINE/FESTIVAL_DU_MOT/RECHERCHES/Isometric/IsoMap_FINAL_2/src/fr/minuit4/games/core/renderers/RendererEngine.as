
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.core.renderers
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	public class RendererEngine extends ARenderer
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _allowInstanciation:Boolean;
		private static var _instance:RendererEngine;
		
		private const MAX_LOOPS:int = 5;
		
		private var _ticker:Shape = new Shape();
		
		private var _frameRate:Number = -1;
		private var _renderTime:Number;
		
		private var _running:Boolean;
		
		private var _currentTime:Number;
		private var _deltaTime:Number;
		private var _accumulator:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Permet de gérer la MainLoop dans un jeu.
		 */
		public function RendererEngine() 
		{
			if ( !_allowInstanciation ) throw new Error( "Instanciation impossible." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function enterFrameHandler(e:Event):void 
		{
			_deltaTime = getTimer() - _currentTime;
			_currentTime += _deltaTime;
			
			_accumulator += _deltaTime;
			var loops:int;
			while ( _accumulator >= _renderTime && loops < MAX_LOOPS )
			{
				++loops;
				
				_accumulator -= _renderTime;
				render( _renderTime );
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():RendererEngine
		{
			if ( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new RendererEngine();
				} _allowInstanciation = false;
			}
			return _instance;
		}
		
		/**
		 * Configure le moteur de rendu en indiquant à combien de frames il doit tourner.
		 * @param	frameRate	Number	Indique à combien de frame l'application doit s'actualisée.
		 */
		public function setup( frameRate:Number = 25 ):void
		{
			_frameRate = frameRate;
			_renderTime = 1000 / _frameRate;
		}
		
		/**
		 * Démarre le moteur de rendu.
		 * A chaque tick, le moteur updatera toutes les instances de IRenderable enregistrés par la méthode "register".
		 */
		public function start():void
		{
			if ( _frameRate <= 0 ) throw new Error( "Le frameRate doit être supérieur à 0." );
			
			if ( isRunning() )
				return;
			
			_accumulator = 0;
			_currentTime = getTimer();
			_ticker.addEventListener( Event.ENTER_FRAME, enterFrameHandler );
			_running = true;
		}
		
		/**
		 * Stoppe le moteur de rendu.
		 */
		public function stop():void
		{
			if ( !isRunning() )
				return;
			
			_ticker.removeEventListener( Event.ENTER_FRAME, enterFrameHandler );
			_running = false;
		}
		
		/**
		 * Permet de savoir si le moteur est actuellement en marche ou non.
		 * @return Boolean
		 */
		public function isRunning():Boolean { return _running; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}