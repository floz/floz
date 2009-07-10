
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
	
	public class M4Motion 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const GROWTH_RATE:int = 0x14;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _tweensByTarget:Dictionary = new Dictionary( true );
		
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
			if ( !_tweensController )
				_tweensController = new Sprite();
			
			if ( _engineStarted ) return;
			
			_tweensController.addEventListener( Event.ENTER_FRAME, M4Tween.render, false, 0, true );
			_engineStarted = true;
		}
		
		private static function stopEngine():void
		{
			if ( !_engineStarted ) return;
			
			_tweensController.removeEventListener( Event.ENTER_FRAME, render );
			_engineStarted = false;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function createTween( target:Object, duration:Number, params:Object ):M4Tween
		{
			
		}
		
		public static function disposeTween( tween:M4Tween ):void
		{
			if ( !( tween.getTarget() in _tweensByTarget ) )
				return;
			
			delete _tweensByTarget[ tween.getTarget() ];
		}
		
		public static function disposeTweensOf( target:Object ):void
		{
			disposeTween( _tweensByTarget[ target ] );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}