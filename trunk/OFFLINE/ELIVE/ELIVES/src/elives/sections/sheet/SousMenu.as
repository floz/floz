/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elives.sections.list 
{
	import elive.events.NavEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class SousMenu extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SousMenu() 
		{
			this.buttonMode = true;
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStage, false, 0, true );
			
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
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addItem( name:String, sousRubId:String ):void
		{
			var item:SousMenuItem = new SousMenuItem( name, sousRubId );
			item.x = item.width * numChildren + 10 * numChildren;
			addChild( item );
		}
		
		public function reset():void
		{
			while ( numChildren ) removeChildAt( 0 );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}