
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package test_fps 
{
	import aze.motion.eaze;
	import aze.motion.EazeTween;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import fr.minuit4.debug.FPS;
	
	public class MainTestFPS extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _sprites:/*DisplayObject*/Array;
		private var _zone:Sprite;
		
		private var _launched:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainTestFPS() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			initZoneClick();
			initSprites();		
			
			_zone.addEventListener( MouseEvent.CLICK, clickHandler, false, 0, true );
			
			var fps:FPS = new FPS();
			addChild( fps );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function clickHandler(e:MouseEvent):void 
		{
			if ( !_launched )
				performTweens();
			else
				EazeTween.killAllTweens();
			
			_launched = !_launched;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initSprites():void
		{
			_sprites = [];
			
			var n:int = 5000;
			for ( var i:int; i < n; ++i )
				_sprites[ i ] = addChild( getSprite() );
		}
		
		private function getSprite():Sprite
		{
			var s:Sprite = new Sprite();
			var g:Graphics = s.graphics;
			g.beginFill( 0x445522 );
			g.drawRect( 0, 0, 10, 10 );
			g.endFill();
			
			s.mouseEnabled = false;
			
			return s;
		}
		
		private function initZoneClick():void
		{
			_zone = new Sprite();
			var g:Graphics = _zone.graphics;
			g.beginFill( 0x000000 );
			g.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			g.endFill();
			addChild( _zone );
		}
		
		private function performTweens():void
		{
			var i:int = _sprites.length;
			while ( --i > -1 )
				eaze( _sprites[ i ] ).to( .5, { x: Math.random() * stage.stageWidth, y: Math.random() * stage.stageHeight } );
			
			eaze( this ).delay( .6 ).onComplete( performTweens );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}