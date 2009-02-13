
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05.settings
{
	import com.as3dmod.modifiers.Twist;
	import fl.controls.TextInput;
	import fl.controls.NumericStepper;
	import flash.display.Sprite;
	import flash.events.Event;
	import main.v05.Model;
	import main.v05.SettingsController;
	
	public class TwistSettings extends Sprite
	{
		public var iName:TextInput;
		public var nAngle:NumericStepper;
		
		public function TwistSettings() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			reset();
			
			addEventListener( Event.CHANGE, onChange );
			
			//iName.addEventListener( Event.CHANGE, onChange );
			//nAngle.addEventListener( Event.CHANGE, onChange );
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
			
			var twist:Twist = attribute.modifier;
			twist.angle = nAngle.value;
			
			attribute.label = iName.text == "" ? attribute.label : iName.text;
			attribute.modifier = twist;
			//Model.listParts[ indexPart ].attributes[ indexAttribute ] = attribute;
			
			dispatchEvent( new Event( SettingsController.SETTINGS_CHANGE ) );
		}
		
		// PUBLIC
		
		public function reset():void
		{
			nAngle.value = 0;
		}
		
		public function linkToCurrentAttribute():void
		{
			iName.text = Model.currentAttribute.label;
			
			var twist:Twist = Model.currentAttribute.modifier;
			nAngle.value = twist.angle;
		}
		
	}
	
}