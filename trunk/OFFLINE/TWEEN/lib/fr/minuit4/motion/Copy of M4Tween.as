
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
	import flash.utils.getTimer;
	import fr.minuit4.motion.easing.Linear;
	
	public class M4Tween__ 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const GROWTH_RATE:int = 0x14;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _tweens:Dictionary = new Dictionary();
		private static var _runningTweens:Array = [];
		private static var _tweensCount:int;
		
		private static var _allowInstanciation:Boolean;
		private static var _availableInPool:int;
		private static var _currentTweenInPool:M4Tween;
		private static var _engineStarted:Boolean;
		private static var _tweenController:Sprite;
		private static var _currentTime:uint;
		
		private var _nextInPool:M4Tween;
		
		private var _target:Object;
		private var _duration:Number;
		private var _params:Object;
		private var _tweeningParams:Array;
		private var _reservedParams:Object = { name: 0, delay: 0, easing: 0, onInit: 0, onProgress: 0, onComplete: 0 }
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function M4Tween__() 
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
			_currentTime = getTimer();
			updateAllTweens();
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
		
		private static function updateAllTweens():void
		{
			var tween:M4Tween;
			
			var i:int = _runningTweens.length;
			while ( --i > -1 )
			{
				tween = _runningTweens[ i ];
				if ( tween._reservedParams.active && !tween._reservedParams.complete )
				{
					tween.update( _currentTime );
				}
				else if ( _currentTime >= tween._reservedParams.startTime )
				{
					tween._reservedParams.active = true;
					tween.update( _currentTime );
				}
			}
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
			for ( p in this._params )
			{
				if ( p in _reservedParams )
					_reservedParams[ p ] = this._params[ p ];
				else
					_tweeningParams.push( p );
			}
		}
		
		private function checkParams( newParams:Object ):Object
		{
			if ( !newParams.easing ) newParams.easing = Linear.easeIn;
			if ( !newParams.delay ) newParams.delay = 0;
			
			newParams.name = "M4Tween_" + M4Tween._tweensCount;
			
			return newParams;
		}
		
		private function update( time:uint ):void
		{
			var t:Number; // Specifies the current time, between 0 and duration inclusive. 
			var b:Number; // Specifies the initial value of the animation property. 
			var c:Number; // Specifies the total change in the animation property. 
			var d:Number; // Specifies the duration of the motion. 
			
			var i:int = _tweeningParams.length;
			while ( --i > -1 )
			{
				if ( !complete )
				{
					t = _currentTime;
					b = ;
					c = ;
					d = ;
					_target[ _tweeningParams[ i ] ] = _reservedParams.easing( );
				}
				else
				{
					
				}
			}
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
			
			_runningTweens.push( tween );
			M4Tween.startEngine();
			
			++_tweensCount;
			
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
		
		public function name():String { return this._reservedParams.name; }
		
		public function toString():String
		{
			return "[object M4Tween target=" + _target + " duration=" + _duration + "]";
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}