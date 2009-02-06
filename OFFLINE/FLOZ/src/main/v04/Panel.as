
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v04 
{
	import com.as3dmod.util.ModConstant;
	import fl.controls.RadioButton;
	import fl.controls.RadioButtonGroup;
	import fl.controls.Slider;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class Panel extends MovieClip
	{
		public static const OFFSET_CHANGE:String = "offset_change";
		public static const FORCE_CHANGE:String = "force_change";
		public static const AXE_CHANGE:String = "axe_change";
		public static const ROTATION_CHANGE:String = "rotation_change";
		public static const SEGMENTS_CHANGE:String = "segments_change";
		
		public var axeHeadX:RadioButton;
		public var axeHeadY:RadioButton;
		public var axeChestX:RadioButton;
		public var axeChestY:RadioButton;
		public var axeLeftArmX:RadioButton;
		public var axeLeftArmY:RadioButton;
		public var axeRightArmX:RadioButton;
		public var axeRightArmY:RadioButton;
		public var axeLeftLegX:RadioButton;
		public var axeLeftLegY:RadioButton;
		public var axeRightLegX:RadioButton;
		public var axeRightLegY:RadioButton;
		
		public var sForceHead:Slider;
		public var sForceChest:Slider;
		public var sForceLeftArm:Slider;
		public var sForceRightArm:Slider;
		public var sForceLeftLeg:Slider;
		public var sForceRightLeg:Slider;
		
		public var txtForceHead:TextField;
		public var txtForceChest:TextField;
		public var txtForceLeftArm:TextField;
		public var txtForceRightArm:TextField;
		public var txtForceLeftLeg:TextField;
		public var txtForceRightLeg:TextField;
		
		public var sOffsetHead:Slider;
		public var sOffsetChest:Slider;
		public var sOffsetLeftArm:Slider;
		public var sOffsetRightArm:Slider;
		public var sOffsetLeftLeg:Slider;
		public var sOffsetRightLeg:Slider;
		
		public var txtOffsetHead:TextField;
		public var txtOffsetChest:TextField;
		public var txtOffsetLeftArm:TextField;
		public var txtOffsetRightArm:TextField;
		public var txtOffsetLeftLeg:TextField;
		public var txtOffsetRightLeg:TextField;
		
		public var sRotationY:Slider;
		public var sRotationX:Slider;
		public var sRotationZ:Slider;
		public var txtRotationY:TextField;
		public var txtRotationX:TextField;
		public var txtRotationZ:TextField;
		
		public var sSegmentsW:Slider;
		public var sSegmentsH:Slider;
		public var txtSegmentsW:TextField;
		public var txtSegmentsH:TextField;
		
		private var axeHead:RadioButtonGroup;
		private var axeChest:RadioButtonGroup;
		private var axeLeftArm:RadioButtonGroup;
		private var axeRightArm:RadioButtonGroup;
		private var axeLeftLeg:RadioButtonGroup;
		private var axeRightLeg:RadioButtonGroup;
		
		public function Panel() 
		{
			axeHead = new RadioButtonGroup( "axeHead" );
			axeHead.addEventListener( Event.CHANGE, onAxeChange );
			axeChest = new RadioButtonGroup( "axeChest" );
			axeChest.addEventListener( Event.CHANGE, onAxeChange );
			axeLeftArm = new RadioButtonGroup( "axeLeftArm" );
			axeLeftArm.addEventListener( Event.CHANGE, onAxeChange );
			axeRightArm = new RadioButtonGroup( "axeRightArm" );
			axeRightArm.addEventListener( Event.CHANGE, onAxeChange );
			axeLeftLeg = new RadioButtonGroup( "axeLeftLeg" );
			axeLeftLeg.addEventListener( Event.CHANGE, onAxeChange );
			axeRightLeg = new RadioButtonGroup( "axeRightLeg" );
			axeRightLeg.addEventListener( Event.CHANGE, onAxeChange );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAxeChange(e:Event):void 
		{
			switch ( e.currentTarget )
			{
				case axeHead:
					Model.axeHead = ( axeHead.selection == axeHeadX ) ? ModConstant.X : ModConstant.Y;
					break;
				case axeChest:
					Model.axeChest = ( axeChest.selection == axeChestX ) ? ModConstant.X : ModConstant.Y;
					break;
				case axeLeftArm:
					Model.axeLeftArm = ( axeLeftArm.selection == axeLeftArmX ) ? ModConstant.X : ModConstant.Y;
					break;
				case axeRightArm:
					Model.axeRightArm = ( axeRightArm.selection == axeRightArmX ) ? ModConstant.X : ModConstant.Y;
					break;
				case axeLeftLeg:
					Model.axeLeftLeg = ( axeLeftLeg.selection == axeLeftLegX ) ? ModConstant.X : ModConstant.Y;
					break;
				case axeRightLeg:
					Model.axeRightLeg = ( axeRightLeg.selection == axeRightLegX ) ? ModConstant.X : ModConstant.Y;
					break;
			}
			
			dispatchEvent( new Event( Panel.AXE_CHANGE ) );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			Model.segmentsW = sSegmentsW.value;
			Model.segmentsH = sSegmentsH.value;
			
			sOffsetChest.addEventListener( Event.CHANGE, onOffsetChange );
			sOffsetHead.addEventListener( Event.CHANGE, onOffsetChange );
			sOffsetLeftArm.addEventListener( Event.CHANGE, onOffsetChange );
			sOffsetLeftLeg.addEventListener( Event.CHANGE, onOffsetChange );
			sOffsetRightArm.addEventListener( Event.CHANGE, onOffsetChange );
			sOffsetRightLeg.addEventListener( Event.CHANGE, onOffsetChange );
			
			sForceChest.addEventListener( Event.CHANGE, onForceChange );
			sForceHead.addEventListener( Event.CHANGE, onForceChange );
			sForceLeftArm.addEventListener( Event.CHANGE, onForceChange );
			sForceLeftLeg.addEventListener( Event.CHANGE, onForceChange );
			sForceRightArm.addEventListener( Event.CHANGE, onForceChange );
			sForceRightLeg.addEventListener( Event.CHANGE, onForceChange );
			
			sRotationY.addEventListener( Event.CHANGE, onRotationChange );
			sRotationX.addEventListener( Event.CHANGE, onRotationChange );
			sRotationZ.addEventListener( Event.CHANGE, onRotationChange );
			sSegmentsW.addEventListener( Event.CHANGE, onSegmentsChange );
			sSegmentsH.addEventListener( Event.CHANGE, onSegmentsChange );
		}
		
		private function onOffsetChange(e:Event):void 
		{
			switch( e.currentTarget )
			{
				case sOffsetChest:
					Model.offsetChest = sOffsetChest.value;
					break;
				case sOffsetHead:
					Model.offsetHead = sOffsetHead.value;
					break;
				case sOffsetLeftArm:
					Model.offsetLeftArm = sOffsetLeftArm.value;
					break;
				case sOffsetLeftLeg:
					Model.offsetLeftLeg = sOffsetLeftLeg.value;
					break;
				case sOffsetRightArm:
					Model.offsetRightArm = sOffsetRightArm.value;
					break;
				case sOffsetRightLeg:
					Model.offsetRightLeg = sOffsetRightLeg.value;
					break;
			}
			fillOffsetText();
			
			dispatchEvent( new Event( Panel.OFFSET_CHANGE ) );
		}
		
		private function onForceChange(e:Event):void 
		{
			switch( e.currentTarget )
			{
				case sForceChest:
					Model.forceChest = sForceChest.value;
					break;
				case sForceHead:
					Model.forceHead = sForceHead.value;
					break;
				case sForceLeftArm:
					Model.forceLeftArm = sForceLeftArm.value
					break;
				case sForceLeftLeg:
					Model.forceLeftLeg = sForceLeftLeg.value;
					break;
				case sForceRightArm:
					Model.forceRightArm = sForceRightArm.value;
					break;
				case sForceRightLeg:
					Model.forceRightLeg = sForceRightLeg.value;
					break;
			}
			fillForceText();
			
			dispatchEvent( new Event( Panel.FORCE_CHANGE ) );
		}
		
		private function onRotationChange(e:Event):void 
		{
			Model.rotationY = sRotationY.value;
			Model.rotationX = sRotationX.value;
			Model.rotationZ = sRotationZ.value;
			txtRotationY.text = Model.rotationY.toString();
			txtRotationX.text = Model.rotationX.toString();
			txtRotationZ.text = Model.rotationZ.toString();
			dispatchEvent( new Event( Panel.ROTATION_CHANGE ) );
		}
		
		private function onSegmentsChange(e:Event):void 
		{
			switch( e.currentTarget )
			{
				case sSegmentsW: Model.segmentsW = sSegmentsW.value; txtSegmentsW.text = Model.segmentsW.toString(); break;
				case sSegmentsH: Model.segmentsH = sSegmentsH.value; txtSegmentsH.text = Model.segmentsH.toString(); break;
			}
			dispatchEvent( new Event( Panel.SEGMENTS_CHANGE ) );
		}
		
		// PRIVATE
		
		private function fillForceText():void
		{
			txtForceChest.text = Model.forceChest.toString();
			txtForceHead.text = Model.forceHead.toString();
			txtForceLeftArm.text = Model.forceLeftArm.toString();
			txtForceLeftLeg.text = Model.forceLeftLeg.toString();
			txtForceRightArm.text = Model.forceRightArm.toString();
			txtForceRightLeg.text = Model.forceRightLeg.toString();
		}
		
		private function fillOffsetText():void
		{
			txtOffsetChest.text = Model.offsetChest.toString();
			txtOffsetHead.text = Model.offsetHead.toString();
			txtOffsetLeftArm.text = Model.offsetLeftArm.toString();
			txtOffsetLeftLeg.text = Model.offsetLeftLeg.toString();
			txtOffsetRightArm.text = Model.offsetRightArm.toString();
			txtOffsetRightLeg.text = Model.offsetRightLeg.toString();
		}
		
		// PUBLIC
		
	}
	
}