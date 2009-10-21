
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  elive.ui.sousmenu  
{
	import elive.events.NavEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.core.interfaces.IDisposable;
	
	public class SousMenu extends Sprite implements IDisposable
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
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
			
			removeEventListener( MouseEvent.MOUSE_OVER, mouseOverHandler );
			removeEventListener( MouseEvent.MOUSE_OUT, mouseOutHandler );
			removeEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
			
			addEventListener( MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true );
			addEventListener( MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true );
			addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true );
		}
		
		private function mouseOverHandler(e:MouseEvent):void 
		{
			var item:SousMenuItem = e.target as SousMenuItem;
			item.over();
		}
		
		private function mouseOutHandler(e:MouseEvent):void 
		{
			var item:SousMenuItem = e.target as SousMenuItem;
			item.out();
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			var item:SousMenuItem = e.target as SousMenuItem;
			var navEvent:NavEvent = new NavEvent( NavEvent.SWITCH_SOUS_RUBRIQUE );
			navEvent.navId = item.sousRubId;
			dispatchEvent( navEvent );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			this.buttonMode = true;
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addItem( title:String, sousRubId:String, overColor:uint ):void
		{
			var item:SousMenuItem = new SousMenuItem( title, sousRubId, overColor );
			item.x = item.width * numChildren + 10 * numChildren;
			addChild( item );
		}
		
		public function dispose():void
		{
			while ( numChildren )
			{
				IDisposable( getChildAt( 0 ) ).dispose();
				removeChildAt( 0 );
			}
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}