
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
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class PanelHeader extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _cntBack:Sprite;
		private var _cntLogo:Sprite;
		private var _cntFront:Sprite;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
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
		}
		
		private function createBack():void
		{
			_cntBack = new Sprite();
			addChild( _cntBack );
			
			var cloud1:Cloud = new Cloud( new GNuage3(), 0xF7F3DB );
			cloud1.alpha = .65;
			_cntBack.addChild( cloud1 );
			
			var cloud2:Cloud = new Cloud( new GNuages4(), 0xffffff );
			cloud2.alpha = .4;
			cloud2.x = 175;
			cloud2.y = 40;
			_cntBack.addChild( cloud2 );
			
			var cloud3:Cloud = new Cloud( new GNuage1() );
			cloud3.x = 100;
			cloud3.y = -10;
			cloud3.alpha = .15;
			_cntBack.addChild( cloud3 );
		}
		
		private function createLogo():void
		{
			_cntLogo = new Sprite();
			_cntLogo.addChild( new GLogo() );
			addChild( _cntLogo );
			
			_cntLogo.x = 262 - _cntLogo.width;
			_cntLogo.blendMode = BlendMode.MULTIPLY;
		}
		
		private function createFront():void
		{
			_cntFront = new Sprite();
			addChild( _cntFront );
			
			var cloud1:Cloud = new Cloud( new GNuage2() );
			cloud1.x = 55;
			cloud1.y = 30;
			cloud1.alpha = .25;
			_cntFront.addChild( cloud1 );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}