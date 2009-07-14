
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import caurina.transitions.Tweener;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import fr.minuit4.motion.easing.Quad;
	import fr.minuit4.motion.M4Tween;
	import fr.minuit4.utils.debug.FPS;
	import gs.TweenLite;
	
	public class Main_M4TweenPool extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const M4V1:String = "m4v1";
		private static const M4M:String = "m4m";
		private static const M4V3:String = "m4v3";
		private static const M4V4:String = "m4v4";
		private static const TWEENLITE:String = "tweenlite";
		private static const TWEENER:String = "tweener";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const _tweenType:String = M4V4;
		private const _spritesCount:int = 1000;
		
		private var _sList:Array;
		private var _timer:Timer;
		private var _timerRunning:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var mov:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main_M4TweenPool() 
		{
			createSprites();
			
			addChild( new FPS() );
			
			_timer = new Timer( 1000 );
			_timer.addEventListener( TimerEvent.TIMER, onTimer );		
			
			var z:Sprite = new Sprite();
			z.useHandCursor =
			z.buttonMode = true;
			var g:Graphics = z.graphics;
			g.beginFill( 0x00, 0 );
			g.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			g.endFill();
			addChild( z );
			z.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onTimer(e:TimerEvent):void 
		{
			var i:int = _spritesCount;
			if ( _tweenType == M4V4 )
			{
				while ( --i > -1 )
					M4Tween.create( _sList[ i ], 1, { x: Math.random() * stage.stageWidth, y: Math.random() * stage.stageHeight, rotation: Math.random() * 380, alpha: Math.random() * .9 + .1, easing: Quad.easeIn } );
			}
			else if ( _tweenType == TWEENER )
			{
				while ( --i > -1 )
					Tweener.addTween( _sList[ i ], { x: Math.random() * stage.stageWidth, y: Math.random() * stage.stageHeight, rotation: Math.random() * 380, alpha: Math.random() * .9 + .1, time: .5, transition: "easeinquad" } );
			}
			else if ( _tweenType == TWEENLITE )
			{
				while ( --i > -1 )
					TweenLite.to( _sList[ i ], 1, { x: Math.random() * stage.stageWidth, y: Math.random() * stage.stageHeight, rotation: Math.random() * 380, alpha: Math.random() * .9 + .1, ease: Quad.easeIn } );
			}
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if ( !_timerRunning )
			{
				_timer.start();
				_timerRunning = true;
			}
			else
			{
				_timer.stop();
				_timerRunning = false;
				var i:int = _spritesCount;
				if ( _tweenType == M4V4 )
				{
					while ( --i > -1 )
						M4Tween.releaseTweenOf( _sList[ i ] );
				}
				else if ( _tweenType == TWEENER )
				{
					
				}
				else if ( _tweenType == TWEENLITE )
				{
					while ( --i > -1 )
						TweenLite.killTweensOf( _sList[ i ] );
				}
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function createSprites():void
		{
			var s:Sprite;
			var g:Graphics;
			
			_sList = [];
			
			var i:int = _spritesCount;
			while ( --i > -1 )
			{
				s = new Sprite();
				g = s.graphics;
				g.beginFill( 0x000000, .5 );
				g.drawRect( 0, 0, 30, 10 );
				g.endFill();
				
				s.x = Math.random() * stage.stageWidth;
				s.y = Math.random() * stage.stageHeight;
				addChild( s );
				
				_sList.push( s );
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}