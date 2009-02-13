
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05 
{
	import com.as3dmod.modifiers.Bend;
	import com.as3dmod.modifiers.Perlin;
	import com.as3dmod.modifiers.Taper;
	import com.as3dmod.modifiers.Twist;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Main extends MovieClip
	{
		public var partsInfos:PartsInfos;
		public var confirmation:Confirmation;
		public var settingsController:SettingsController;
		public var visualizer:Visualizer;
		
		public function Main() 
		{
			partsInfos.addEventListener( PartsInfos.ADD_CLICK, onAddClick );
			partsInfos.addEventListener( PartsInfos.DELETE_CLICK, onDeleteClick );
			partsInfos.addEventListener( PartsInfos.PART_CHANGE, onPartChange );
			partsInfos.addEventListener( PartsInfos.ATTRIBUTE_SELECT, onAttributeSelect );
			confirmation.addEventListener( Confirmation.CONFIRM, onConfirm );
			settingsController.addEventListener( SettingsController.SETTINGS_CHANGE, onSettingsChange, true );
			settingsController.addEventListener( SettingsController.GLOBAL_SETTINGS_CHANGE, onGlobalSettingsChange, true );
		}
		
		// EVENTS
		
		private function onAddClick(e:Event):void 
		{
			confirmation.openAddPanel();
		}
		
		private function onDeleteClick(e:Event):void 
		{
			confirmation.openDeletePanel();
		}
		
		private function onPartChange(e:Event):void 
		{
			settingsController.hideAll();
			settingsController.updateGlobalSettings();
		}
		
		private function onAttributeSelect(e:Event):void 
		{
			if ( partsInfos.getCurrentAttribute().modifier is Bend ) settingsController.showBendSettings();
			else if ( partsInfos.getCurrentAttribute().modifier is Perlin ) settingsController.showPerlinSettings();
			else if ( partsInfos.getCurrentAttribute().modifier is Taper ) settingsController.showTaperSettings();
			else if ( partsInfos.getCurrentAttribute().modifier is Twist ) settingsController.showTwistSettings();
		}
		
		private function onConfirm(e:Event):void 
		{
			if ( confirmation.currentLabel == "Add" )
				partsInfos.addAttribute( e.currentTarget.selected, e.currentTarget.selectedName );
			else
				partsInfos.deleteCurrentAttribute();
			
			visualizer.refreshCurrentPart();
			settingsController.hideAll();
		}
		
		private function onSettingsChange(e:Event):void 
		{
			partsInfos.refreshListAttributes( true );
			visualizer.refreshCurrentPart();
		}
		
		private function onGlobalSettingsChange(e:Event):void 
		{
			visualizer.rebuildCurrentPart();
			visualizer.refreshAllParts();
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}