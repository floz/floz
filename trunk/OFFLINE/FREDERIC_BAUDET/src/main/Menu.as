
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
		public static const RUBRIQUE_CHANGE:String = "rubrique_change";
		
		public var zPub:SimpleButton;
		public var zClip:SimpleButton;
		public var zShort:SimpleButton;
		
		private var rubriqueName:String;
		private var currentButton:SimpleButton;
		
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
			
			activateRubrique( Const.PUB, zPub );
			
			this.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch( e.target )
			{
				case zPub: activateRubrique( Const.PUB, zPub ); break;
				case zClip: activateRubrique( Const.CLIP, zClip ); break;
				case zShort: activateRubrique( Const.SHORT, zShort ); break;
			}
		}
		
		// PRIVATE
		
		private function desactivate( button:SimpleButton ):void
		{
			// desactiver button
		}
		
		private function activateRubrique( rubriqueName:String, button:SimpleButton ):void
		{
			if ( currentButton ) desactivate( currentButton );
			
			this.rubriqueName = rubriqueName;
			currentButton = button;
			
			dispatchEvent( new Event( Menu.RUBRIQUE_CHANGE ) );
		}
		
		// PUBLIC
		
		public function getRubriqueName():String { return rubriqueName };
		
	}
	
}