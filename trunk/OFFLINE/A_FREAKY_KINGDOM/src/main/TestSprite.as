
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import floz.game.core.GameEngine;
	import floz.game.graphics.GameSprite;
	import gs.easing.Linear;
	import gs.TweenLite;
	
	public class TestSprite extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _gameSprite:GameSprite;
		private var _liaf:MovieClip;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
	
		public var btFirstPosition:Button;
		public var btSecondPosition:Button;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TestSprite() 
		{
			GameEngine.initialize( stage );
			
			_gameSprite = new GameSprite( stage.frameRate );
			_gameSprite.addEventListener( GameSprite.READY, onSpriteReady );
			_gameSprite.addAnimation( new liaf_marche(), 0 );
			addChild( _gameSprite );
			
			//_liaf = new Liaf();
			//_liaf.scaleX = -1;
			//addChild( _liaf );
			
			stage.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onClick(e:MouseEvent):void 
		{
			goTo( e.stageX, e.stageY );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function goTo( px:Number, py:Number ):void
		{			
			_liaf.gotoAndPlay( "walk" );
			_liaf.scaleX = ( px > _liaf.x ) ? -1 : 1;
			
			var dist:Number = ( px - _liaf.x );
			dist *= dist < 0 ? -1 : 1;
			var duration:Number = dist * .01 * .5;
			TweenLite.to( _liaf, duration, { x: px, y: py - _liaf.height * .5, ease: Linear.easeIn, onComplete: function():void { _liaf.gotoAndPlay( "stand" ); } } )
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}