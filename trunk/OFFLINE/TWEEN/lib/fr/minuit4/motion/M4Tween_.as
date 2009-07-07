
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
	
	public class M4Tween_
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const GROWTH_RATE:int = 0x14;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _tweens:Dictionary = new Dictionary();
		private static var _runningTweens:/*M4Tween*/Array = [];
		private static var _tweensCount:int;
		
		private static var _allowInstanciation:Boolean;
		private static var _availableInPool:int;
		private static var _currentTweenInPool:M4Tween;
		private static var _engineStarted:Boolean;
		private static var _tweenController:Sprite;
		private static var _currentTime:uint;
		
		private var _nextInPool:M4Tween;
		
		private var _target:Object;
		private var _params:Object;
		private var _tweensInfos:/*M4TweenInfos*/Array = [];
		private var _tweeningProperties:Object;
		private var _reservedParams:Object = { name: 0, delay: 0, easing: 0, onInit: 0, onUpdate: 0, onComplete: 0, onInitParams: 0, onUpdateParams: 0, onCompleteParams: 0 };
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function M4Tween_() 
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
				_runningTweens[ i ].update();
		}
		
		// NOT STATIC
		
		private function initialize( target:Object, duration:Number, params:Object ):void
		{
			this._target = target;
			
			if ( !_tweeningProperties ) _tweeningProperties = { };
			
			var rp:Array = [];
			var fp:Array = [];
			var p:String;
			for ( p in params )
			{
				if ( p in _reservedParams )
					rp.push( { property: p, value: params[ p ] } );
				else
					fp.push( { property: p, value: params[ p ] } );
			}
			
			var ti:M4TweenInfos;
			var value:Number;			
			var j:int;
			var m:int = rp.length;	
			var i:int = fp.length;
			while ( --i > -1 )
			{
				j = m;
				p = fp[ i ].property;
				value = fp[ i ].value;
				
				if ( p in _tweeningProperties )
				{
					ti = _tweeningProperties[ p ];
					ti.startValue = target[ p ];
					ti.endValue = value;
					ti.duration = duration;
				}
				else 
				{
					ti = new M4TweenInfos( p, target[ p ], value, duration );
					_tweeningProperties[ p ] = ti;
				}
				
				while ( --j > -1 )
					ti[ rp[ j ].property ] = rp[ j ].value;
				
				if ( !ti.delay ) ti.delay = 0;
				if ( typeof( ti.easing ) != "function" ) ti.easing = Linear.easeIn;
				ti.startTime = getTimer() + ti.delay;
				ti.endTime = ti.startTime + ti.duration * 1000;
				
				_tweensInfos.push( ti );
			}
		}
		
		private function update():int
		{
			var t:Number; // Specifies the current time, between 0 and duration inclusive. 
			var b:Number; // Specifies the initial value of the animation property. 
			var c:Number; // Specifies the total change in the animation property. 
			var d:Number; // Specifies the duration of the motion. 
			
			var updating:int;
			var value:Number;
			
			var ti:M4TweenInfos;
			var i:int = _tweensInfos.length;
			while ( --i > -1 )
			{
				ti = _tweensInfos[ i ];
				if ( !ti.complete )
				{
					t = _currentTime - ti.startTime;
					b = ti.startValue;
					c = ti.endValue - ti.startValue;
					d = ti.duration * 1000;
					value = ti.easing( t, b, c, d );
					
					_target[ ti.property ] = value;
					
					if ( _currentTime >= ti.endTime ) ti.complete = true;
				}
				else
				{
					_target[ ti.property ] = ti.endValue;
					
					delete _tweeningProperties[ ti.property ];
					_tweensInfos.splice( i, 1 );
				}
			}
			
			return updating;
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
			return "[object M4Tween target=" + _target + "]";
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}