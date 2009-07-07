
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import fr.minuit4.motion.easing.Quad;
	import fr.minuit4.motion.M4TweenPool;
	import fr.minuit4.utils.debug.FPS;
	import gs.TweenLite;
	
	public class Main_M4TweenPool extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const M4:String = "m4";
		private static const TWEENLITE:String = "tweenlite";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const _tweenType:String = TWEENLITE;
		private const _spritesCount:int = 1000;
		
		private var _sList:Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var mov:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main_M4TweenPool() 
		{
			createSprites();	
			
			addChild( new FPS() );			
			stage.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onClick(e:MouseEvent):void 
		{
			var i:int = _spritesCount;
			if ( _tweenType == M4 )
			{
				while ( --i > -1 )
					M4TweenPool.createTween( _sList[ i ], .5, { x: Math.random() * stage.stageWidth, y: Math.random() * stage.stageHeight, alpha: Math.random() * .9 + .1, easing: Quad.easeIn } );
			}
			else if ( _tweenType == TWEENLITE )
			{
				while ( --i > -1 )
					TweenLite.to( _sList[ i ], .5, { x: Math.random() * stage.stageWidth, y: Math.random() * stage.stageHeight, alpha: Math.random() * .9 + .1, ease: Quad.easeIn } );
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
				g.beginFill( Math.random() * 0xffffff );
				g.drawCircle( 0, 0, Math.random() * 15 + 5 );
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