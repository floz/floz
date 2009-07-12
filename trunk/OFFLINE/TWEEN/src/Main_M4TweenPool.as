
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
	import fr.minuit4.motion.v4.M4Tween;
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
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var mov:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main_M4TweenPool() 
		{
			createSprites();
			
			addChild( new FPS() );
			
			_timer = new Timer( 500 );
			_timer.addEventListener( TimerEvent.TIMER, onTimer );		
			
			stage.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onTimer(e:TimerEvent):void 
		{
			var i:int = _spritesCount;
			//if ( _tweenType == M4V4 )
			//{
				//while ( --i > -1 )
					//M4Tween.create( _sList[ i ], .5, { x: Math.random() * stage.stageWidth, y: Math.random() * stage.stageHeight, rotation: Math.random() * 380, alpha: Math.random() * .9 + .1, easing: Quad.easeIn } );
			//}
			//else if ( _tweenType == M4V3 )
			//{
				//while ( --i > -1 )
					//M4MotionV3.createTween( _sList[ i ], .5, { x: Math.random() * stage.stageWidth, y: Math.random() * stage.stageHeight, rotation: Math.random() * 380, alpha: Math.random() * .9 + .1, easing: Quad.easeIn } );
			//}
			//else if ( _tweenType == M4V1 )
			//{
				//while ( --i > -1 )
					//M4TweenPool.createTween( _sList[ i ], .5, { x: Math.random() * stage.stageWidth, y: Math.random() * stage.stageHeight, rotation: Math.random() * 380, alpha: Math.random() * .9 + .1, easing: Quad.easeIn } );
			//}
			//else if ( _tweenType == TWEENER )
			//{
				//while ( --i > -1 )
					//Tweener.addTween( _sList[ i ], { x: Math.random() * stage.stageWidth, y: Math.random() * stage.stageHeight, rotation: Math.random() * 380, alpha: Math.random() * .9 + .1, time: .5, transition: "easeinquad" } );
			//}
			//else if ( _tweenType == TWEENLITE )
			//{
				//while ( --i > -1 )
					//TweenLite.to( _sList[ i ], .5, { x: Math.random() * stage.stageWidth, y: Math.random() * stage.stageHeight, rotation: Math.random() * 380, alpha: Math.random() * .9 + .1, ease: Quad.easeIn } );
			//}
			if ( _tweenType == M4V4 )
			{
				while ( --i > -1 )
					M4Tween.create( _sList[ i ], .5, { x: Math.random() * stage.stageWidth, y: Math.random() * stage.stageHeight, rotation: Math.random() * 380, scaleX: Math.random() * 1 + .2, scaleY: Math.random() * 1 + .2, alpha: Math.random() * .9 + .1, easing: Quad.easeIn } );
			}
			else if ( _tweenType == TWEENER )
			{
				while ( --i > -1 )
					Tweener.addTween( _sList[ i ], { x: Math.random() * stage.stageWidth, y: Math.random() * stage.stageHeight, rotation: Math.random() * 380, scaleX: Math.random() * 1 + .2, scaleY: Math.random() * 1 + .2, alpha: Math.random() * .9 + .1, time: .5, transition: "easeinquad" } );
			}
			else if ( _tweenType == TWEENLITE )
			{
				while ( --i > -1 )
					TweenLite.to( _sList[ i ], .5, { x: Math.random() * stage.stageWidth, y: Math.random() * stage.stageHeight, rotation: Math.random() * 380, scaleX: Math.random() * 1 + .2, scaleY: Math.random() * 1 + .2, alpha: Math.random() * .9 + .1, ease: Quad.easeIn } );
			}
		}
		
		private function onClick(e:MouseEvent):void 
		{
			_timer.start();
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
				g.beginFill( Math.random() * 0xffffff );
				g.drawRect( 0, 0, Math.random() * 40 + 10, Math.random() * 20 + 5 );
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