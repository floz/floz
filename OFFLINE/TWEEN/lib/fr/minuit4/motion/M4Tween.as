
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.motion 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import fr.minuit4.motion.easing.Linear;
	
	public class M4Tween 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const GROWTH_RATE:int = 0x14;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _tweens:Dictionary = new Dictionary();
		private static var _runningTweens:Array = [];
		
		private static var _allowInstanciation:Boolean;
		private static var _availableInPool:int;
		private static var _currentTweenInPool:M4Tween;
		private static var _engineStarted:Boolean;
		private static var _tweenController:Sprite;
		
		private var _nextInPool:M4Tween;
		
		private var _target:Object;
		private var _duration:Number;
		private var _params:Object;
		private var _tweeningParams:Array;
		private var _reservedParams:Object = { onInit: 1, onProgress: 1, onComplete: 1 }
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function M4Tween() 
		{
			if ( _allowInstanciation )
			{
				// 
			}
			else throw new Error( "This class cannot be instanciated, use the createTween method instead" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private static function onFrame(e:Event):void 
		{
			//trace( _runningTweens.length );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// STATIC
		
		private static function startEngine():void
		{
			if( !_tweenController )
				_tweenController = new Sprite();
			
			if ( _tweenController.hasEventListener( Event.ENTER_FRAME ) )
				return;
			
			_tweenController.addEventListener( Event.ENTER_FRAME, M4Tween.onFrame, false, 0, true );			
			_engineStarted = true;
		}
		
		private static function stopEngine():void
		{
			if ( !_tweenController.hasEventListener( Event.ENTER_FRAME ) )
				return;
			
			_tweenController.removeEventListener( Event.ENTER_FRAME, M4Tween.onFrame );
			_engineStarted = false;
		}
		
		// NOT STATIC
		
		private function initialize( target:Object, duration:Number, params:Object ):void
		{
			this._target = target;
			this._duration = duration;
			
			var newParams:Object
			if ( target in _tweens )
			{
				newParams = this._params;
				
				var p:String;				
				for ( p in newParams )
					newParams[ p ] = params[ p ];
			}
			else newParams = params;			
			
			newParams = checkParams( newParams );			
			this._params = newParams;
			
			_tweeningParams = [];
			trace( "---------" );
			for ( p in this._params )
			{
				if ( p in _reservedParams )
				{
					trace( "réservé : " + p );
				}
				else
				{
					_tweeningParams.push( p );
					trace( "autorisé : " + p );
				}
			}
		}
		
		private function checkParams( newParams:Object ):Object
		{
			if ( !newParams.easing ) newParams.easing = Linear.easeIn;
			
			return newParams;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// STATIC
		
		public static function createTween( target:Object, duration:Number, params:Object ):M4Tween
		{
			if ( duration < 0 ) 
				throw new RangeError( "The duration must have a positive value." );
			
			var tween:M4Tween;
			
			if ( target in _tweens )
			{
				tween = _tweens[ target ];
				tween.initialize( target, duration, params );
			}
			else
			{
				if ( !_availableInPool )
				{
					var i:int = GROWTH_RATE;
					while ( --i > -1 )
					{
						_allowInstanciation = true; {
							tween = new M4Tween();
						} _allowInstanciation = false;
						
						tween._nextInPool = _currentTweenInPool;
						_currentTweenInPool = tween;
					}
					
					_availableInPool += GROWTH_RATE;
				}
				
				tween = _currentTweenInPool;
				_currentTweenInPool = tween._nextInPool;
				--_availableInPool;
				
				tween.initialize( target, duration, params );
				_tweens[ target ] = tween;
			}
			
			M4Tween.startEngine();
			
			return tween;
		}
		
		public static function disposeTween( tween:M4Tween ):void
		{
			delete _tweens[ tween._target ];
			
			tween._nextInPool = _currentTweenInPool;
			_currentTweenInPool = tween;
			
			++_availableInPool;
		}
		
		public static function disposeTweenOf( target:Object ):void
		{
			disposeTween( _tweens[ target ] );
		}
		
		// NOT STATIC
		
		public function toString():String
		{
			return "[object M4Tween target=" + _target + " duration=" + _duration + "]";
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}