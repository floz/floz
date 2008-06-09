package interfaceSite 
{
	import caurina.transitions.Tweener;
	
	import five3D.display.Sprite3D;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import main.Main;
	
	public class Menu extends Sprite3D
	{
		private var bgColor:uint;
		
		private var background :Sprite3D;
		private var lines:Sprite3D;
		private var main:Main;
		
		public function Menu( bgColor:uint ) 
		{
			this.bgColor = bgColor;
			
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
			
			main = getAncestor( this, Main ) as Main;
			
			create();
		}
		
		// PRIVATE
		
		private function create():void
		{
			for each ( var item:String in main.rubriques )
			{
				
			}
		}
		
		private function getAncestor( child:DisplayObject, type:* ):DisplayObject
		{
			var c:DisplayObject = child;
			
			while ( c.parent )
			{
				if ( c.parent is type ) return c.parent;
				c = c.parent;
			}
			
			return null;
		}
		
		// PUBLIC
		
		public function onOver():void
		{
			Tweener.addTween();
		}
		
	}
	
}