
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	import fr.minuit4.controllers.MenuCtrl;
	
	public class Main extends MovieClip
	{
		public var menu:MovieClip;
		private var menuCtrl:MenuCtrl;
		
		public function Main() 
		{
			menuCtrl = new MenuCtrl( MenuCtrl.VERTICAL_TOP_TO_BOTTOM, true, true, false );
			menuCtrl.linkToMenu( menu );
			menuCtrl.addEventListener( MenuCtrl.SECTION_SELECTED, onSectionSelected );
			menuCtrl.addEventListener( MenuCtrl.SECTION_OVER, onSectionOver );
			menuCtrl.addEventListener( MenuCtrl.SECTION_OUT, onSectionOut );
			menuCtrl.activate();
			var s:InteractiveObject;
		}
		
		// EVENTS
		
		private function onSectionSelected(e:Event):void 
		{
			trace( "selected" );
			trace( menuCtrl.getSectionID( menuCtrl.oldSection ) );
			trace( menuCtrl.getSectionID( menuCtrl.currentSection ) );
		}
		
		private function onSectionOver(e:Event):void 
		{
			trace( "over" );
			trace ( menuCtrl.getSectionID( menuCtrl.overSection ) );
		}
		
		private function onSectionOut(e:Event):void 
		{
			trace( "out" );
			
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}