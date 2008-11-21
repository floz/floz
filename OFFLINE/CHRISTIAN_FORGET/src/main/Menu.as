
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Menu extends MovieClip 
	{
		
		public function Menu() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}		
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			var cnt:Sprite = new Sprite ();
			addChild( cnt );
			
			var works:Tab = new Tab( Main.WORKS );
			cnt.addChild( works );
			
			var archives:Tab = new Tab( Main.ARCHIVES );
			archives.x = works.width + 5;
			cnt.addChild( archives );
			
			var contact:Tab = new Tab( Main.CONTACT );
			contact.x = works.width + archives.width + 10;
			cnt.addChild( contact );
			
			cnt.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			cnt.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			cnt.addEventListener( MouseEvent.MOUSE_OUT, onOut );
		}
		
		private function onDown(e:MouseEvent):void 
		{
			e.target.down();
			stage.addEventListener( MouseEvent.MOUSE_UP, onUp );
		}
		
		private function onUp(e:MouseEvent):void 
		{
			if ( e.target is Tab ) e.target.up();
		}
		
		private function onOver(e:Event):void 
		{
			e.target.over();
		}
		
		private function onOut(e:Event):void 
		{
			e.target.out();
		}
		
		// PRIVATE	
		
		// PUBLIC
		
	}
	
}