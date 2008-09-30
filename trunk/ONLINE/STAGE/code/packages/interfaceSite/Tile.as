package interfaceSite 
{
	import five3D.display.Sprite3D;
	import flash.events.Event;
	
	public class Tile extends Sprite3D
	{
		private var color:uint;
		
		public function Tile( color:uint ) 
		{
			this.color = color;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage )
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
			this.graphics3D.beginFill( color, 1 );
			this.graphics3D.drawRect( 0, 0, 100, 100 );
			this.graphics3D.endFill();
			
			this.alpha = 0;
			
			this.rotationX = Math.random() * 360;
			this.rotationY = Math.random() * 360;
			this.rotationZ = Math.random() * 360;
		}
		
	}
	
}