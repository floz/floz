
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05.settings 
{	
	import com.as3dmod.modifiers.Bend;
	import fl.controls.ComboBox;
	import fl.controls.NumericStepper;
	import fl.controls.TextInput;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BendSettings extends Sprite
	{
		public var iName:TextInput;
		public var nForce:NumericStepper;
		public var nOffset:NumericStepper;
		public var nAngle:NumericStepper;
		public var cAxe:ComboBox;
		
		public function BendSettings() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			reset();
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function reset():void
		{
			nForce.value = 0;
			nOffset.value = 0;
			nAngle.value = 0;
			cAxe.selectedIndex = 0;
		}
		
		public function linkTo( item:Object ):void
		{
			iName.text = item.label;
			
			var bend:Bend = item.modifier;
			nForce.value = bend.force;
			nOffset.value = bend.offset;
			nAngle.value = bend.angle;
			cAxe.selectedIndex = bend.switchAxes ? 1 : 0;
		}
		
		// GETTERS & SETTERS
		
		public function get force():Number { return nForce.value; }
		public function get offset():Number { return nOffset.value; }
		public function get angle():Number { return nAngle.value; }
		public function get axe():Number { return cAxe.selectedItem.data; }
		
	}
	
}