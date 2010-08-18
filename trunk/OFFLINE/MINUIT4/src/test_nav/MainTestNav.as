
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package test_nav 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import fr.minuit4.core.navigation.nav.events.NavEvent;
	import fr.minuit4.core.navigation.nav.NavManager;
	import fr.minuit4.core.navigation.nav.NavNode;
	import fr.minuit4.display.ui.buttons.M4Button;
	
	public class MainTestNav extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _navManager:NavManager;
		
		private var _item1:M4Button;
		private var _item2:M4Button;
		private var _item3:M4Button;
		private var _prev:M4Button;
		private var _next:M4Button;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainTestNav() 
		{
			_navManager = new NavManager();
			_navManager.addNode( "item1" );
			_navManager.addNode( "item2" );
			_navManager.addNode( "item3" );
			_navManager.addEventListener( NavEvent.NAV_CHANGE, navChangeHandler, false, 0, true );
			
			_item1 = new M4Button( "ITEM 1 " );
			_item1.x = 10;
			addChild( _item1 );
			
			_item2 = new M4Button( "ITEM 2" );
			_item2.x = int( _item1.x + _item1.width + 10 );
			addChild( _item2 );
			
			_item3 = new M4Button( "ITEM 3" );
			_item3.x = int( _item2.x + _item2.width + 10 );
			addChild( _item3 );
			
			_next = new M4Button( "NEXT" );
			_next.x = int( stage.stageWidth - _next.width - 10 );
			addChild( _next );
			
			_prev = new M4Button( "PREV" );
			_prev.x = int( _next.x - _prev.width - 10 );
			addChild( _prev );
			
			_item1.addEventListener( MouseEvent.CLICK, clickHandler, false, 0, true );
			_item2.addEventListener( MouseEvent.CLICK, clickHandler, false, 0, true );
			_item3.addEventListener( MouseEvent.CLICK, clickHandler, false, 0, true );
			_prev.addEventListener( MouseEvent.CLICK, clickHandler, false, 0, true );
			_next.addEventListener( MouseEvent.CLICK, clickHandler, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function navChangeHandler(e:NavEvent):void 
		{
			trace( "NavChange : " + _navManager.currentNode.id );
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case _item1: _navManager.activate( "item1" ); break;
				case _item2: _navManager.activate( "item2" ); break;
				case _item3: _navManager.activate( "item3" ); break;
				case _prev: _navManager.prev(); break;
				case _next: _navManager.next(); break;
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}