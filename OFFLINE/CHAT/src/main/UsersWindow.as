
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import fl.controls.List;
	import fl.data.DataProvider;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class UsersWindow extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var list:List;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function UsersWindow() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function refresh( v:Vector.<Object> ):void
		{
			var dp:DataProvider = new DataProvider();
			var n:int = v.length;
			for ( var i:int; i < n; ++i )
				dp.addItem( { label: v[ i ].pseudo, id: v[ i ].id } );
			
			list.dataProvider = dp;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}