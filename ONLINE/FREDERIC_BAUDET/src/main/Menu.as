
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
		
		public var pub:MovieClip;
		public var clip:MovieClip;
		public var short:MovieClip;
		public var links:MovieClip;
		
		private var rubriqueName:String;
		private var currentButton:MovieClip;
		
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
			
			activateRubrique( Const.PUB, pub );
			
			addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch( e.target )
			{
				case pub.bt: activateRubrique( Const.PUB, pub ); break;
				case clip.bt: activateRubrique( Const.CLIP, clip ); break;
				case short.bt: activateRubrique( Const.SHORT, short ); break;
				case links.bt: activateRubrique( Const.LINKS, links ); break;
			}
		}
		
		// PRIVATE
		
		private function desactivate():void
		{
			currentButton.bt.enabled = true;
			currentButton.bt.useHandCursor = true;
			currentButton.mc.gotoAndStop( "deselect" );
		}
		
		private function activateRubrique( rubriqueName:String, button:MovieClip ):void
		{
			if ( button == currentButton ) return;
			if ( currentButton ) desactivate();
			
			this.rubriqueName = rubriqueName;
			currentButton = button;			
			currentButton.bt.enabled = false;
			currentButton.bt.useHandCursor = false;
			currentButton.mc.gotoAndStop( "select" );
			
			dispatchEvent( new Event( Menu.RUBRIQUE_CHANGE ) );
		}
		
		// PUBLIC
		
		public function getRubriqueName():String { return rubriqueName };
		
	}
	
}