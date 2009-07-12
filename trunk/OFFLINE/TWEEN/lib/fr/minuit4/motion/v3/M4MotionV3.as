
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.motion.v3
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class M4MotionV3
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const GROWTH_RATE:int = 20;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _tweensByTarget:Dictionary = new Dictionary( true );
		private static var _initialized:Boolean;
		
		private static var _count:int;
		private static var _pool:Array;
		
		private static var _tweensController:Sprite;
		private static var _engineStarted:Boolean;
		private static var _currentTime:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function M4MotionV3() 
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
			
			_tweensController.addEventListener( Event.ENTER_FRAME, M4MotionV3.render, false, 0, true );
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
			var tween:M4Tween;
			
			var updatingTweens:int;
			var i:int = _pool.length;
			while ( --i > -1 )
			{
				tween = _pool[ i ];
				if ( !tween.isEnabled() ) break;
				
				if ( !tween.update( _currentTime ) )
				{
					release( tween );
					continue;
				}
				++updatingTweens;
			}
			
			if ( !updatingTweens ) stopEngine();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function initialize( numberOfTweens:int ):void
		{
			_tweensController = new Sprite();
			
			_pool = [];
			
			var i:int = numberOfTweens;
			while ( --i > -1 )
				_pool[ i ] = new M4Tween();
			
			_count = numberOfTweens;
			
			_initialized = true;
		}
		
		public static function createTween( target:Object, duration:Number, params:Object ):M4Tween
		{
			if ( duration <= 0 ) duration = 0.001;
			
			if ( !_initialized )
				initialize( GROWTH_RATE );
			
			if ( !_count )
			{
				var i:int = GROWTH_RATE;
				
				while ( --i > -1 )
					_pool.unshift( new M4Tween() );
				
				_count = GROWTH_RATE;
			}
			
			var tween:M4Tween = _pool[ --_count ];
			tween.initialize( target, duration, params );
			_tweensByTarget[ target ] = tween;
			
			startEngine();
			
			return tween;
		}
		
		public static function release( tween:M4Tween ):void
		{
			if ( !( tween.getTarget() in _tweensByTarget ) )
				return;
			
			delete _tweensByTarget[ tween.getTarget() ];
			
			var idx:int = _pool.indexOf( tween );
			_pool.unshift( _pool.splice( idx, 1 )[ 0 ] );
			++_count;
		}
		
		public static function releaseTweensOf( target:Object ):void
		{
			release( _tweensByTarget[ target ] );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}