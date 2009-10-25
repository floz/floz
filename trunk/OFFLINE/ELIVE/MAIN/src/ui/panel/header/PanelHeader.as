
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package ui.panel.header
{
	import assets.GLogo;
	import assets.GNuage1;
	import assets.GNuage2;
	import assets.GNuage3;
	import assets.GNuages4;
	import aze.motion.Eaze;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class PanelHeader extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _cntBack:Sprite;
		private var _cntLogo:Sprite;
		private var _cntFront:Sprite;
		
		private var _cloud1:Cloud;
		private var _cloud2:Cloud;
		private var _cloud3:Cloud;
		private var _cloud4:Cloud;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var initialized:Boolean;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function PanelHeader() 
		{
			init();
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			createBack();
			createLogo();
			createFront();		
			
			_cntLogo.alpha = 0;
		}
		
		private function createBack():void
		{
			_cntBack = new Sprite();
			addChild( _cntBack );
			
			_cloud1 = new Cloud( new GNuage3(), 0xF7F3DB );
			_cloud1.alpha = .65;
			_cntBack.addChild( _cloud1 );
			
			_cloud2 = new Cloud( new GNuages4(), 0xffffff );
			_cloud2.alpha = .4;
			_cloud2.x = 175;
			_cloud2.y = 40;
			_cntBack.addChild( _cloud2 );
			
			_cloud3 = new Cloud( new GNuage1() );
			_cloud3.x = 100;
			_cloud3.y = -10;
			_cloud3.alpha = .15;
			_cntBack.addChild( _cloud3 );
		}
		
		private function createLogo():void
		{
			_cntLogo = new Sprite();
			_cntLogo.addChild( new GLogo() );
			addChild( _cntLogo );
			
			_cntLogo.x = 262 - 226;
			_cntLogo.blendMode = BlendMode.MULTIPLY;
		}
		
		private function createFront():void
		{
			_cntFront = new Sprite();
			addChild( _cntFront );
			
			_cloud4 = new Cloud( new GNuage2() );
			_cloud4.x = 55;
			_cloud4.y = 30;
			_cloud4.alpha = .25;
			_cntFront.addChild( _cloud4 );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function play():void
		{
			_cntLogo.alpha = 1;
			MovieClip( _cntLogo.getChildAt( 0 ) ).gotoAndPlay( 0 );
			initialized = true;
		}
		
		public function makeAppear():void
		{
			if( initialized ) Eaze.to( _cntLogo, .5, { alpha: 1 } );
			
			Eaze.from( _cloud1, .5, { y: -50 } );
			Eaze.from( _cloud2, .5, { y: -50 } );
			Eaze.from( _cloud3, .5, { y: -50 } );
			Eaze.from( _cloud4, .5, { y: -50 } );
		}
		
		public function makeDisappear():void
		{
			Eaze.to( _cntLogo, .5, { alpha: 0 } );
			
			Eaze.to( _cloud1, .5, { y: -50 } ).chainApply( _cloud1, { y: 0 } );
			Eaze.to( _cloud2, .5, { y: -50 } ).chainApply( _cloud2, { y: 40 } );
			Eaze.to( _cloud3, .5, { y: -50 } ).chainApply( _cloud3, { y: -10 } );
			Eaze.to( _cloud4, .5, { y: -50 } ).chainApply( _cloud4, { y: 30 } );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}