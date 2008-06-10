package interfaceSite.rubriques 
{
	import five3D.display.Sprite3D;
	import flash.events.Event;
	import interfaceSite.Feuille;
	
	public class Introduction extends Sprite3D
	{
		
		public function Introduction() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			create();
		}
		
		// PRIVATE
		
		private function create():void
		{
			var background:Feuille = new Feuille( 700, 400, 0x000000 );
			addChild( background );
		}
		
	}
	
}