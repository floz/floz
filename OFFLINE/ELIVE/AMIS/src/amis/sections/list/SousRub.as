
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.list
{
	import assets.GScrollbarBackground;
	import assets.GScrollbarSlider;
	import elive.events.NavEvent;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.core.interfaces.IDisposable;
	import fr.minuit4.tools.scrollbars.VScrollbar;
	
	public class SousRub extends Sprite implements IDisposable
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
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
		
		private function dragStartHandler(e:Event):void 
		{
			_dragging = true;
		}
		
		private function dragStopHandler(e:Event):void 
		{
			_dragging = false;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{			
			_cntGlobal = new Sprite();
			_cntGlobal.x = 5;
			_cntGlobal.y = 37;
			addChild( _cntGlobal );
			
			buildContent();
		}
		
		private function buildContent():void
		{
			_cntContent = new Sprite();
			_cntContent.y = 5;
			_cntGlobal.addChild( _cntContent );
			
			var mask:Sprite = new Sprite();
			var g:Graphics = mask.graphics;
			g.beginFill( 0x00ff00 );
			g.drawRect( 0, 0, 266, 310 );
			g.endFill();
			_cntGlobal.addChild( mask );
			
			_scrollBar = new VScrollbar( new GScrollbarBackground(), new GScrollbarSlider() );
			_scrollBar.addEventListener( VScrollbar.DRAG_START, dragStartHandler, false, 0, true );
			_scrollBar.addEventListener( VScrollbar.DRAG_STOP, dragStopHandler, false, 0, true );
			_scrollBar.link( _cntContent, mask );
			_scrollBar.height = 310;
			_scrollBar.x = 275;
			_scrollBar.y = 37;
			addChild( _scrollBar );
			_scrollBar.enableBlur = true;
		}
		
		protected function resetScrollbarSliderPosition():void
		{
			_scrollBar.setPercent( 0 );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function dispose():void
		{			
			_scrollBar.dispose();
			_scrollBar = null;
			
			_cntContent = null;
			_cntGlobal = null;
		}
		
		public function isDragging():Boolean { return this._dragging; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}