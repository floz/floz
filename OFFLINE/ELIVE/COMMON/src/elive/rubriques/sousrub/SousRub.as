
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
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.core.interfaces.IDisposable;
	import fr.minuit4.tools.scrollbars.VScrollbar;
	
	public class SousRub extends Sprite implements IDisposable
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _sousMenu:SousMenu;
		protected var _cntContent:Sprite;
		private var _cntGlobal:Sprite;
		private var _scrollBar:VScrollbar;
		
		protected var _currentSousRub:String;
		
		private var _dragging:Boolean;
		
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
			
			onSwitchSousRub();
			
			_sousMenu.addEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubriqueHandler, false, 0, true );
		}
		
		private function switchSousRubriqueHandler(e:NavEvent):void 
		{
			if ( _currentSousRub == e.navId ) 
				return;
			
			resetScrollbarSliderPosition();
			_currentSousRub = e.navId;
			onSwitchSousRub();
		}
		
		private function dragStartHandler(e:Event):void 
		{
			_sousMenu.deactivate();
			_dragging = true;
		}
		
		private function dragStopHandler(e:Event):void 
		{
			_sousMenu.activate();
			_dragging = false;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_sousMenu = new SousMenu();
			buildSousMenu();
			addChild( _sousMenu );
			 
			_cntGlobal = new Sprite();
			_cntGlobal.x = 5;
			_cntGlobal.y = 37;
			addChild( _cntGlobal );
			
			buildContent();			
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		protected function buildSousMenu():void
		{
			// ABSTRACT, MUST BE OVERRIDED
			
			_sousMenu.buildSeparatorBars();
			_sousMenu.x = 288 * .5 - _sousMenu.width * .5;
		}
		
		private function buildContent():void
		{
			_cntContent = new Sprite();
			_cntContent.y = 5;
			_cntGlobal.addChild( _cntContent );
			
			var mask:Sprite = new Sprite();
			var g:Graphics = mask.graphics;
			g.beginFill( 0xff00ff );
			g.drawRect( 0, 0, 266, 290 );
			g.endFill();
			_cntGlobal.addChild( mask );
			
			_scrollBar = new VScrollbar( new GScrollbarBackground(), new GScrollbarSlider() );
			_scrollBar.addEventListener( VScrollbar.DRAG_START, dragStartHandler, false, 0, true );
			_scrollBar.addEventListener( VScrollbar.DRAG_STOP, dragStopHandler, false, 0, true );
			_scrollBar.link( _cntContent, mask );
			_scrollBar.x = 275;
			_scrollBar.y = 37;
			addChild( _scrollBar );
			_scrollBar.enableBlur = true;
		}
		
		protected function onSwitchSousRub():void
		{
			// ABSTRACT METHOD, MUST BE OVERRIDED
		}
		
		protected function resetScrollbarSliderPosition():void
		{
			_scrollBar.setPercent( 0 );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function dispose():void
		{
			_sousMenu.dispose();
			_sousMenu = null;
			
			_scrollBar.dispose();
			_scrollBar = null;
			
			_cntContent = null;
			_cntGlobal = null;
			
			if ( hasEventListener( Event.ADDED_TO_STAGE ) ) removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}
		
		public function isDragging():Boolean { return this._dragging; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}