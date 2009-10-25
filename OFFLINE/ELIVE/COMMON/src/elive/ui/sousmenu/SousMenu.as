
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  elive.ui.sousmenu  
{
	import assets.GSeparationBar;
	import elive.events.NavEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.core.interfaces.IDisposable;
	
	public class SousMenu extends Sprite implements IDisposable
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _cntItems:Sprite;
		private var _cntBars:Sprite;
		
		private var _selectedItem:SousMenuItem;
		
		private var _activated:Boolean;
		private var _deactivate:Boolean;
		private var _disableActivatedState:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SousMenu() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			_cntItems.removeEventListener( MouseEvent.MOUSE_OVER, mouseOverHandler );
			_cntItems.removeEventListener( MouseEvent.MOUSE_OUT, mouseOutHandler );
			_cntItems.removeEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
			
			_activated = false;
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
			
			if ( !_disableActivatedState )
			{
				var item:SousMenuItem;
				var i:int, n:int = _cntItems.numChildren;
				for ( ; i < n; ++i )
				{
					item = SousMenuItem( _cntItems.getChildAt( i ) );
					item.bg.alpha = 0;
				}
				_selectedItem = SousMenuItem( _cntItems.getChildAt( 0 ) );
				_selectedItem.over();
			}
			
			if( !_deactivate ) _activated = true;
			
			_cntItems.addEventListener( MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true );
			_cntItems.addEventListener( MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true );
			_cntItems.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true );
		}
		
		private function mouseOverHandler(e:MouseEvent):void 
		{
			if ( !_activated ) return;
			
			var item:SousMenuItem = e.target as SousMenuItem;
			if ( item == _selectedItem ) return;
			item.over();
		}
		
		private function mouseOutHandler(e:MouseEvent):void 
		{
			if ( !_activated ) return;
			
			var item:SousMenuItem = e.target as SousMenuItem;
			if ( item == _selectedItem ) return;
			item.out();
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			if ( !_activated ) return;
			
			var item:SousMenuItem = e.target as SousMenuItem;
			if ( item == _selectedItem ) return;
			if( _selectedItem ) _selectedItem.out();
			_selectedItem = item;
			
			var navEvent:NavEvent = new NavEvent( NavEvent.SWITCH_SOUS_RUBRIQUE );
			navEvent.navId = item.sousRubId;
			dispatchEvent( navEvent );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_cntItems = new Sprite();
			_cntItems.buttonMode = true;
			addChild( _cntItems );
			
			_cntBars = new Sprite();
			_cntBars.y = 8;
			addChild( _cntBars );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addItem( title:String, sousRubId:String, overClass:String ):void
		{
			var item:SousMenuItem = new SousMenuItem( title, sousRubId, overClass );
			item.x = int( item.width * _cntItems.numChildren + 10 * _cntItems.numChildren );
			_cntItems.addChild( item );
		}
		
		public function buildSeparatorBars():void
		{
			while ( _cntBars.numChildren ) _cntBars.removeChildAt( 0 );
			
			var n:int = _cntItems.numChildren - 1;
			if ( n <= 0 ) return;
			
			var separatorBar:GSeparationBar;
			var item:SousMenuItem;
			var px:Number = 0, itemWidth:Number = _cntItems.getChildAt( 0 ).width;
			for ( var i:int; i < n; ++i )
			{
				item = _cntItems.getChildAt( i ) as SousMenuItem;
				separatorBar = new GSeparationBar();
				separatorBar.x = int( item.width + item.x + 5 );
				_cntBars.addChild( separatorBar );
			}
		}
		
		public function activate():void
		{
			_activated = true;
			_deactivate = false;
		}
		
		public function deactivate():void
		{
			_activated = false;
			_deactivate = true;
		}
		
		public function disableActivatedState():void
		{
			if ( _disableActivatedState ) return;
			_disableActivatedState = true;
			
			if ( !_cntItems.numChildren ) return;
			
			var item:SousMenuItem = _cntItems.getChildAt( 0 ) as SousMenuItem;
			item.out();
		}
		
		public function dispose():void
		{
			_cntItems = null;
			_cntBars = null;
			_selectedItem = null;
			
			if( hasEventListener( Event.ADDED_TO_STAGE ) ) removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}