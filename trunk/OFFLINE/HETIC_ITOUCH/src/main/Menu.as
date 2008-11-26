
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Menu extends MovieClip
	{
		public static const SELECTED:String = "selected";
		
		public var zIndex:SimpleButton;
		public var zApplications:SimpleButton;
		public var zCaracteristiques:SimpleButton;
		public var zVideo:SimpleButton;
		public var zSon:SimpleButton;
		
		private var _event:Event;
		
		public var rubriqueName:String;
		
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
			
			_event = new Event( Menu.SELECTED );
			
			zIndex.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			zApplications.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			zCaracteristiques.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			zVideo.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			zSon.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
		}
		
		private function onDown(e:MouseEvent):void 
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, onUp );
		}
		
		private function onUp(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, onUp );
			
			switch( e.target )
			{
				case zIndex : rubriqueName = "Index"; break;
				case zApplications : rubriqueName = "Applications"; break;
				case zCaracteristiques : rubriqueName = "Caractéristiques"; break;
				case zVideo : rubriqueName = "Vidéo"; break;
				case zSon : rubriqueName = "Son"; break;
			}
			
			dispatchEvent( _event );
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}