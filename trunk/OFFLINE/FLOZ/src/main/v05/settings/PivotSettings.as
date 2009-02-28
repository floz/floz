
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05.settings 
{
	import com.as3dmod.modifiers.Pivot;
	import fl.controls.NumericStepper;
	import fl.controls.TextInput;
	import flash.display.Sprite;
	import flash.events.Event;
	import main.v05.Model;
	import main.v05.SettingsController;
	
	public class PivotSettings extends Sprite
	{
		public var iName:TextInput;
		public var nX:NumericStepper;
		public var nY:NumericStepper;
		public var nZ:NumericStepper;
		
		public function PivotSettings() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.CHANGE, onChange );
		}
		
		private function onChange(e:Event):void 
		{
			saveChanges();
		}
		
		// PRIVATE
		
		private function saveChanges():void
		{
			var part:Object = Model.currentPart;
			var attribute:Object = Model.currentAttribute;
			
			var pivot:Pivot = attribute.modifier;
			pivot.px = nX.value;
			pivot.py = nY.value;
			pivot.pz = nZ.value;
			
			attribute.label = iName.text == "" ? attribute.label : iName.text;
			attribute.modifier = pivot;
			
			dispatchEvent( new Event( SettingsController.SETTINGS_CHANGE ) );
		}
		
		// PUBLIC
		
		public function reset():void
		{
			nX.value = 0;
			nY.value = 0;
			nZ.value = 0;
		}
		
		public function linkToCurrentAttribute():void
		{
			iName.text = Model.currentAttribute.label;
			
			var pivot:Pivot = Model.currentAttribute.modifier;
			nX.value = pivot.px;
			nY.value = pivot.py;
			nZ.value = pivot.pz;
		}
		
	}
	
}