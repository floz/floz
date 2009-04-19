
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
	import main.v05.settings.PivotSettings;
	import main.v05.settings.TwistSettings;
	
	public class SettingsController extends Sprite
	{
		public static const SETTINGS_CHANGE:String = "settings_change";
		public static const GLOBAL_SETTINGS_CHANGE:String = "global_settings_change";
		
		public var bendSettings:BendSettings;
		public var perlinSettings:PerlinSettings;
		public var pivotSettings:PivotSettings;
		public var twistSettings:TwistSettings;
		public var globalSettings:GlobalSettings;
		
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
			
			if ( Model.currentPart ) globalSettings.visible = true;
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
		
		public function showPivotSettings():void
		{
			hideAll();
			pivotSettings.linkToCurrentAttribute();
			pivotSettings.visible = true;
		}
		
		public function showTwistSettings():void 
		{
			hideAll(); 
			twistSettings.linkToCurrentAttribute();
			twistSettings.visible = true;
		}
		
		public function updateGlobalSettings():void
		{
			globalSettings.linkToCurrentPart();
		}
		
	}
	
}