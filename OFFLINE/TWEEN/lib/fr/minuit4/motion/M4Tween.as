
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.motion 
{
	import flash.utils.Dictionary;
	
	public class M4Tween 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const GROWTH_RATE:int = 0x14;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _tweens:Dictionary = new Dictionary();
		
		private static var _allowInstanciation:Boolean;
		private static var _availableInPool:int;
		private static var _currentTweenInPool:M4Tween;
		
		private var _nextInPool:M4Tween;
		
		private var _target:Object;
		private var _duration:Number;
		private var _params:Object;
		
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
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function initialize( target:Object, duration:Number, params:Object ):void
		{
			this._target = target;
			this._duration = duration;
			this._params = params;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// STATIC
		
		public static function createTween( target:Object, duration:Number, params:Object ):M4Tween
		{
			var tween:M4Tween;
			
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