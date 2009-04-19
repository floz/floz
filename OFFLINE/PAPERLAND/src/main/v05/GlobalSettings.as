
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05 
{
	import fl.controls.NumericStepper;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class GlobalSettings extends Sprite
	{
		public var nSegmentsW:NumericStepper;
		public var nSegmentsH:NumericStepper;
		public var nX:NumericStepper;
		public var nY:NumericStepper;
		public var nZ:NumericStepper;
		public var nRX:NumericStepper;
		public var nRY:NumericStepper;
		public var nRZ:NumericStepper;
		public var txtName:TextField;
		
		public function GlobalSettings() 
		{
			addEventListener( Event.CHANGE, onChange );
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			reset();
		}
		
		private function onChange(e:Event):void 
		{
			saveChanges();
		}
		
		// PRIVATE
		
		private function saveChanges():void
		{
			Model.currentPart.segmentsW = nSegmentsW.value;
			Model.currentPart.segmentsH = nSegmentsH.value;
			Model.currentPart.x = nX.value;
			Model.currentPart.y = nY.value;
			Model.currentPart.z = nZ.value;
			Model.currentPart.rx = nRX.value;
			Model.currentPart.ry = nRY.value;
			Model.currentPart.rz = nRZ.value;
			
			dispatchEvent( new Event( SettingsController.GLOBAL_SETTINGS_CHANGE ) );
		}
		
		private function reset():void
		{
			nSegmentsW.value = Model.segmentsW;
			nSegmentsH.value = Model.segmentsW;
			nX.value =
			nY.value =
			nZ.value =
			nRX.value =
			nRY.value =
			nRZ.value = 0;
		}
		
		// PUBLIC
		
		public function linkToCurrentPart():void
		{
			txtName.text = Model.currentPart.label
			nSegmentsW.value = Model.currentPart.segmentsW;
			nSegmentsH.value = Model.currentPart.segmentsH;
			nX.value = Model.currentPart.x;
			nY.value = Model.currentPart.y;
			nZ.value = Model.currentPart.z;
			nRX.value = Model.currentPart.rx;
			nRY.value = Model.currentPart.ry;
			nRZ.value = Model.currentPart.rz;
		}
		
	}
	
}