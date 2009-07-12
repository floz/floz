
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.motion.v2
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class M4Motion 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const GROWTH_RATE:int = 15;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _tweensByTarget:Dictionary = new Dictionary( true );
		private static var _initialized:Boolean;
		
		private static var _availableInPool:int;
		private static var _currentTween:M4Tween;
		private static var _firstTween:M4Tween;
		private static var _lastTween:M4Tween;
		
		private static var _tweensController:Sprite;
		private static var _engineStarted:Boolean;
		private static var _currentTime:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function M4Motion() 
		{
			throw new Error( "This class cannot be instanciated, use the createTween method instead." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private static function render( e:Event ):void
		{
			_currentTime = getTimer();
			updateAllTweens();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private static function startEngine():void
		{			
			if ( _engineStarted ) return;
			
			_tweensController.addEventListener( Event.ENTER_FRAME, M4Motion.render, false, 0, true );
			_engineStarted = true;
		}
		
		private static function stopEngine():void
		{
			if ( !_engineStarted ) return;
			
			_tweensController.removeEventListener( Event.ENTER_FRAME, render );
			_engineStarted = false;
		}
		
		private static function updateAllTweens():void
		{
			var tmpTween:M4Tween;
			
			var updatingTweens:int;
			var tween:M4Tween = _firstTween;
			while ( tween && tween.isEnabled() )
			{
				tmpTween = tween.next;
				if ( !tween.update( _currentTime ) )
				{
					tween = tmpTween;
					continue;
				}
				tween = tmpTween;
				++updatingTweens;
			}
			
			if ( !updatingTweens ) stopEngine();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function initialize( numberOfTweens:int ):void
		{
			_tweensController = new Sprite();
			
			var tween:M4Tween = new M4Tween();
			_lastTween = tween;
			
			var i:int = numberOfTweens;
			while ( --i > -1 )
			{
				tween.next = _currentTween;
				_currentTween = tween;
				if ( i > 0 ) tween = tween.prev = new M4Tween();
			}
			_firstTween = _currentTween;
			
			_availableInPool = numberOfTweens;			
			_initialized = true;
		}
		
		public static function createTween( target:Object, duration:Number, params:Object ):M4Tween
		{
			if ( duration < 0 )
				throw new RangeError( "The duration must be positive." );
			
			if ( !_initialized )
				initialize( GROWTH_RATE );
			
			var tween:M4Tween;
			if ( target in _tweensByTarget ) // à jarter ?
			{
				tween = _tweensByTarget[ target ];
				tween.initialize( target, duration, params );
				
				startEngine();
				
				return tween;
			}
			
			if ( !_availableInPool )
			{
				var oldLastTween:M4Tween = _lastTween;
				tween = new M4Tween();
				_lastTween = tween;
				
				var i:int = GROWTH_RATE;
				while ( --i > -1 )
				{
					tween.next = _currentTween;
					_currentTween = tween;
					if ( i > 0 ) tween = tween.prev = new M4Tween();
				}
				tween.prev = oldLastTween;
				oldLastTween.next = tween;
				
				_availableInPool = GROWTH_RATE;
			}
			
			tween = _currentTween;
			_currentTween = tween.next;
			--_availableInPool;
			
			tween.initialize( target, duration, params );
			_tweensByTarget[ target ] = tween;
			
			startEngine();
			
			return tween;
		}
		
		public static function disposeTween( tween:M4Tween ):void
		{
			if ( !( tween.getTarget() in _tweensByTarget ) )
				return;
			
			if ( tween == _lastTween )
			{
				_currentTween = _lastTween;				
				++_availableInPool;
				
				return;
			}
			else if ( tween == _firstTween )
			{
				var newFirst:M4Tween = _firstTween.next;
				newFirst.prev = null;
				
				_firstTween = newFirst;
			}
			else
			{
				tween.prev.next = tween.next;
				tween.next.prev = tween.prev;
			}
			
			delete _tweensByTarget[ tween.getTarget() ];
			tween.dispose();
			
			_lastTween.next = tween;
			tween.prev = _lastTween;
			_lastTween = tween;
			
			if ( !_currentTween ) 
				_currentTween = _lastTween;
			
			++_availableInPool;
		}
		
		public static function disposeTweensOf( target:Object ):void
		{
			disposeTween( _tweensByTarget[ target ] );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}