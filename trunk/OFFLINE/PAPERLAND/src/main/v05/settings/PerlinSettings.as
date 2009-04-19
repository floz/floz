
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05.settings
{
	import com.as3dmod.modifiers.Perlin;
	import fl.controls.TextInput;
	import fl.controls.NumericStepper;
	import flash.display.Sprite;
	import flash.events.Event;
	import main.v05.Model;
	import main.v05.SettingsController;
	
	public class PerlinSettings extends Sprite
	{
		public var iName:TextInput;
		public var nForce:NumericStepper;
		
		public function PerlinSettings() 
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
			
			var perlin:Perlin = attribute.modifier;
			perlin.force = nForce.value;
			
			attribute.label = iName.text == "" ? attribute.label : iName.text;
			attribute.modifier = perlin;
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
			
			var perlin:Perlin = Model.currentAttribute.modifier;
			nForce.value = perlin.force;
		}
		
	}
	
}