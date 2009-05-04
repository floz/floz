
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package effects 
{
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.ColorPicker;
	import fl.controls.Slider;
	import fl.events.ColorPickerEvent;
	import fl.events.SliderEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class Panel extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var sBaseX:Slider;
		public var sBaseY:Slider;
		public var sNumOctaves:Slider;
		public var sRandomSeed:Slider;
		public var cbStich:CheckBox;
		public var cbFractalNoise:CheckBox;
		public var cbGrayScale:CheckBox;
		public var cpThreshold:ColorPicker;
		public var cpColor:ColorPicker;
		public var cpMask:ColorPicker;
		public var tBaseX:TextField
		public var tBaseY:TextField
		public var tNumOctaves:TextField
		public var tRandomSeed:TextField
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Panel() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );			
			
			sBaseX.addEventListener( SliderEvent.CHANGE, onSliderChange );
			sBaseY.addEventListener( SliderEvent.CHANGE, onSliderChange );
			sNumOctaves.addEventListener( SliderEvent.CHANGE, onSliderChange );
			sRandomSeed.addEventListener( SliderEvent.CHANGE, onSliderChange );
			
			cbStich.addEventListener( Event.CHANGE, onCheckBoxChange );
			cbFractalNoise.addEventListener( Event.CHANGE, onCheckBoxChange );
			cbGrayScale.addEventListener( Event.CHANGE, onCheckBoxChange );
			
			cpThreshold.addEventListener( ColorPickerEvent.CHANGE, onColorPickerChange );
			cpColor.addEventListener( ColorPickerEvent.CHANGE, onColorPickerChange );
			cpMask.addEventListener( ColorPickerEvent.CHANGE, onColorPickerChange );
		}
		
		private function onSliderChange(e:SliderEvent):void 
		{
			setSlidersValues();			
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		
		private function onCheckBoxChange(e:Event):void 
		{
			setCheckBoxValues();			
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		
		private function onColorPickerChange(e:ColorPickerEvent):void 
		{
			setColorPickersValues();			
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			setSlidersValues();
			setCheckBoxValues();
			setColorPickersValues();
		}
		
		private function setSlidersValues():void
		{
			Config.baseX = sBaseX.value;
			Config.baseY = sBaseY.value;
			Config.numOctaves = sNumOctaves.value;
			Config.randomSeed = sRandomSeed.value;
			
			tBaseX.text = ( sBaseX.value ).toString();
			tBaseY.text = ( sBaseY.value ).toString();
			tNumOctaves.text = ( sNumOctaves.value ).toString();
			tRandomSeed.text = ( sRandomSeed.value ).toString();
		}
		
		public function setCheckBoxValues():void
		{
			Config.stitch = cbStich.selected;
			Config.fractalNoise = cbFractalNoise.selected;
			Config.grayScale = cbGrayScale.selected;
		}
		
		public function setColorPickersValues():void
		{
			Config.threshold = cpThreshold.selectedColor == 0 ? 0x999999 : cpThreshold.selectedColor;
			Config.color = cpColor.selectedColor == 0 ? 0xff00ff : cpColor.selectedColor;
			Config.mask = cpMask.selectedColor == 0 ? 0xffffff : cpMask.selectedColor;	
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}