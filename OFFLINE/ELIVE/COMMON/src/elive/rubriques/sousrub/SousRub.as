
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.rubriques.sousrub
{
	import assets.GScrollbarBackground;
	import assets.GScrollbarSlider;
	import elive.events.NavEvent;
	import elive.ui.sousmenu.SousMenu;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.tools.scrollbars.VScrollbar;
	
	public class SousRub extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _sousMenu:SousMenu;
		protected var _cntContent:Sprite;
		protected var _scrollBar:VScrollbar;
		
		private var _currentSousRub:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SousRub() 
		{			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			_sousMenu.removeEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubriqueHandler );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
			
			_sousMenu.addEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubriqueHandler, false, 0, true );
		}
		
		private function switchSousRubriqueHandler(e:NavEvent):void 
		{
			if ( _currentSousRub == e.navId ) 
				return;
			
			_currentSousRub = e.navId;
			onSwitchSousRub();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_sousMenu = new SousMenu();
			buildSousMenu();
			addChild( _sousMenu );
			
			buildContent();			
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		protected function buildSousMenu():void
		{
			// ABSTRACT, MUST BE OVERRIDED
		}
		
		private function buildContent():void
		{
			_cntContent = new Sprite();
			_cntContent.x = 5;
			_cntContent.y = 42;
			addChild( _cntContent );
			
			var mask:Sprite = new Sprite();
			var g:Graphics = mask.graphics;
			g.beginFill( 0xff00ff );
			g.drawRect( 0, 0, 266, 290 );
			g.endFill();
			addChild( mask );
			
			_scrollBar = new VScrollbar( new GScrollbarBackground(), new GScrollbarSlider() );
			_scrollBar.addEventListener( VScrollbar.DRAG_START, dragStartHandler, false, 0, true );
			_scrollBar.addEventListener( VScrollbar.DRAG_STOP, dragStopHandler, false, 0, true );
			_scrollBar.link( _cntContent, mask );
			_scrollBar.x = 275;
			_scrollBar.y = 37;
			addChild( _scrollBar );
			_scrollBar.enableBlur = true;
		}
		
		private function onSwitchSousRub():void
		{
			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}