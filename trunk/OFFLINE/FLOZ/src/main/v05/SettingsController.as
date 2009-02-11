
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import main.v05.settings.BendSettings;
	import main.v05.settings.PerlinSettings;
	import main.v05.settings.TaperSettings;
	import main.v05.settings.TwistSettings;
	
	public class SettingsController extends Sprite
	{
		public static const SETTINGS_CHANGE:String = "settings_change";
		
		public var bendSettings:BendSettings;
		public var perlinSettings:PerlinSettings;
		public var taperSettings:TaperSettings;
		public var twistSettings:TwistSettings;
		
		private var _hide:Boolean;
		
		public function SettingsController() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			hideAll();
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function hideAll():void
		{
			var n:int = numChildren;
			for ( var i:int; i < n; i++ )
				getChildAt( i ).visible = false;
		}
		
		public function showBendSettings():void 
		{ 
			hideAll(); 
			bendSettings.linkToCurrentAttribute();
			bendSettings.visible = true; 
		}
		
		public function showPerlinSettings():void 
		{ 
			hideAll(); 
			perlinSettings.linkToCurrentAttribute();
			perlinSettings.visible = true; 
		}
		
		public function showTaperSettings():void
		{
			hideAll();
			taperSettings.linkToCurrentAttribute();
			taperSettings.visible = true;
		}
		
		public function showTwistSettings():void 
		{
			hideAll(); 
			twistSettings.linkToCurrentAttribute();
			twistSettings.visible = true;
		}
		
	}
	
}