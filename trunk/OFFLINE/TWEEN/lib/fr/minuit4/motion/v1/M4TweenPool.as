
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.motion.v1
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class M4TweenPool 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const GROWTH_RATE:int = 0x14;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _tweensByTarget:Dictionary = new Dictionary( true );
		private static var _runningTweens:/*M4Tweens*/Array = [];
		
		private static var _firstTween:M4Tween;
		private static var _availableInPool:int;
		private static var _currentTweenInPool:M4Tween;
		private static var _tweenController:Sprite;
		private static var _engineStarted:Boolean;
		private static var _currentTime:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static var allowInstantiation:Boolean;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function M4TweenPool() 
		{
			throw new Error( "This class cannot be instanciated, use the createTween method instead" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private static function render( e:Event ):void
		{
			_currentTime = getTimer();
			updateAllTween();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private static function startEngine():void
		{
			if ( !_tweenController )
				_tweenController = new Sprite();
			
			if ( _engineStarted ) return;
			
			_tweenController.addEventListener( Event.ENTER_FRAME, M4TweenPool.render, false, 0, true );
			_engineStarted = true;
		}
		
		private static function stopEngine():void
		{
			if ( !_engineStarted ) return;
			
			_tweenController.removeEventListener( Event.ENTER_FRAME, M4TweenPool.render );
			_engineStarted = false;
		}
		
		private static function updateAllTween():void
		{
			var tween:M4Tween;
			
			var updatingTweens:int;
			var i:int = _runningTweens.length;
			while ( --i > -1 )
			{
				if ( !_runningTweens[ i ].update( _currentTime ) ) 
				{
					disposeTween( _runningTweens[ i ] );
					_runningTweens.splice( i, 1 );
					continue;
				}
				++updatingTweens;
			}
			
			if ( !updatingTweens ) stopEngine();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function createTween( target:Object, duration:Number, params:Object ):M4Tween
		{
			if ( duration < 0 )
				throw new RangeError( "The duration must be positive." );
			
			var tween:M4Tween;
			if ( target in _tweensByTarget )
			{
				tween = _tweensByTarget[ target ];
				tween.initialize( target, duration, params );
				
				if ( _runningTweens.indexOf( tween ) == -1 )
					_runningTweens.push( tween );
				
				startEngine();
				
				return tween;
			}
			else
			{
				if ( !_availableInPool )
				{
					var i:int = GROWTH_RATE;
					while ( --i > -1 )
					{
						allowInstantiation = true; {
							tween = new M4Tween();
						} allowInstantiation = false;
						
						tween.nextInPool = _currentTweenInPool;
						_currentTweenInPool = tween;
					}
					
					_availableInPool += GROWTH_RATE;
				}
				
				tween = _currentTweenInPool;
				_currentTweenInPool = tween.nextInPool;
				--_availableInPool;
				
				tween.initialize( target, duration, params );
				_tweensByTarget[ target ] = tween;
			}
			
			_runningTweens.push( tween );
			startEngine();
			
			return tween;
		}
		
		public static function disposeTween( tween:M4Tween ):void
		{
			if ( !( tween.getTarget() in _tweensByTarget ) )
				return;
			
			delete _tweensByTarget[ tween.getTarget() ];			
			tween.dispose();
			
			tween.nextInPool = _currentTweenInPool;
			_currentTweenInPool = tween;
			
			++_availableInPool;
		}
		
		public static function disposeTweensOf( target:Object ):void
		{
			disposeTween( _tweensByTarget[ target ] );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}