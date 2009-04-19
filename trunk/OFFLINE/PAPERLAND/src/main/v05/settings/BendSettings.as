
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05.settings 
{	
	import com.as3dmod.modifiers.Bend;
	import fl.controls.CheckBox;
	import fl.controls.NumericStepper;
	import fl.controls.TextInput;
	import flash.display.Sprite;
	import flash.events.Event;
	import main.v05.Model;
	import main.v05.SettingsController;
	
	public class BendSettings extends Sprite
	{
		public var iName:TextInput;
		public var nForce:NumericStepper;
		public var nOffset:NumericStepper;
		public var nAngle:NumericStepper;
		public var cAxe:CheckBox;
		
		public function BendSettings() 
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
			//nOffset.addEventListener( Event.CHANGE, onChange );
			//nAngle.addEventListener( Event.CHANGE, onChange );
			//cAxe.addEventListener( Event.CHANGE, onChange );
		}
		
		private function onChange(e:Event):void 
		{
			saveChanges();
		}
		
		// PRIVATE
		
		private function saveChanges():void
		{
			//var indexPart:int = Model.currentPart.data
			var part:Object = Model.currentPart//Model.listParts[ indexPart ];
			//var indexAttribute:int = Model.currentAttribute.data;
			var attribute:Object = Model.currentAttribute; //part.attributes[ indexAttribute ];
			
			var bend:Bend = attribute.modifier;
			bend.force = nForce.value;
			bend.offset = nOffset.value;
			bend.angle = nAngle.value;
			bend.switchAxes = cAxe.selected;
			
			attribute.label = iName.text == "" ? attribute.label : iName.text;
			attribute.modifier = bend;
			//Model.listParts[ indexPart ].attributes[ indexAttribute ] = attribute;
			
			dispatchEvent( new Event( SettingsController.SETTINGS_CHANGE ) );
		}
		
		// PUBLIC
		
		public function reset():void
		{
			nForce.value = 0;
			nOffset.value = 0;
			nAngle.value = 0;
			cAxe.selected = false;
		}
		
		public function linkToCurrentAttribute():void
		{
			iName.text = Model.currentAttribute.label;
			
			var bend:Bend = Model.currentAttribute.modifier;
			nForce.value = bend.force;
			nOffset.value = bend.offset;
			nAngle.value = bend.angle;
			cAxe.selected = bend.switchAxes;
		}
		
		// GETTERS & SETTERS
		
		public function get force():Number { return nForce.value; }
		public function get offset():Number { return nOffset.value; }
		public function get angle():Number { return nAngle.value; }
		public function get axe():Boolean { return cAxe.selected;  }
		
	}
	
}