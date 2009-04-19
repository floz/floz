
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05.settings
{
	import com.as3dmod.modifiers.Taper;
	import fl.controls.TextInput;
	import fl.controls.NumericStepper;
	import flash.display.Sprite;
	import flash.events.Event;
	import main.v05.Model;
	import main.v05.SettingsController;
	
	public class TaperSettings extends Sprite
	{
		public var iName:TextInput;
		public var nForce:NumericStepper;
		
		public function TaperSettings() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			reset();
			
			addEventListener( Event.CHANGE, onChange );
			
			//iName.addEventListener( Event.CHANGE, onChange );
			//nForce.addEventListener( Event.CHANGE, onChange );
		}
		
		private function onChange(e:Event):void 
		{
			saveChanges();
		}
		
		// PRIVATE
		
		private function saveChanges():void
		{
			//var indexPart:int = Model.currentPart.data
			var part:Object = Model.currentPart;//Model.listParts[ indexPart ];
			//var indexAttribute:int = Model.currentAttribute.data;
			var attribute:Object = Model.currentAttribute;//part.attributes[ indexAttribute ];
			
			var taper:Taper = attribute.modifier;
			taper.force = nForce.value;
			
			attribute.label = iName.text == "" ? attribute.label : iName.text;
			attribute.modifier = taper;
			//Model.listParts[ indexPart ].attributes[ indexAttribute ] = attribute;
			
			dispatchEvent( new Event( SettingsController.SETTINGS_CHANGE ) );
		}
		
		// PUBLIC
		
		public function reset():void
		{
			nForce.value = 0;
		}
		
		public function linkToCurrentAttribute():void
		{
			iName.text = Model.currentAttribute.label;
			
			var taper:Taper = Model.currentAttribute.modifier;
			nForce.value = taper.force;
		}
	}
}