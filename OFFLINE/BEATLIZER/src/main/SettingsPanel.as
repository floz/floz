
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import gs.easing.Quad;
	import gs.TweenLite;
	import fl.controls.Slider;
	import fl.controls.CheckBox;
	
	public class SettingsPanel extends MovieClip
	{
		
		// - CONST -----------------------------------------------------------------------
		
		public static const VALUE_CHANGE:String = "value_change";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _px:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var bg:MovieClip;
		public var scaleSlider:Slider;
		public var saturationSlider:Slider;
		public var rotationSlider:Slider;		
		public var reverseBox:CheckBox;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SettingsPanel() 
		{
			_px = this.x;
			this.x = 250;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			reverseBox.label = "Miroir";
			
			scaleSlider.addEventListener( Event.CHANGE, onChange );
			saturationSlider.addEventListener( Event.CHANGE, onChange );
			rotationSlider.addEventListener( Event.CHANGE, onChange );
			reverseBox.addEventListener( Event.CHANGE, onChange );
			
			Model.scale = scaleSlider.value;
			Model.saturationValue = saturationSlider.value;
			Model.mirrorRatio = reverseBox.selected ? -1 : 1;
		}
		
		private function onChange(e:Event):void 
		{
			switch( e.currentTarget )
			{
				case scaleSlider: Model.scale = e.currentTarget.value; break;
				case saturationSlider: Model.saturationValue = e.currentTarget.value; break;
				case rotationSlider: Model.rotation = e.currentTarget.value; break;
				case reverseBox: Model.mirrorRatio = e.currentTarget.selected ? -1 : 1; break;
			}
			
			dispatchEvent( new Event( SettingsPanel.VALUE_CHANGE ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function init():void
		{
			TweenLite.to( this, .4, { x: _px, ease: Quad.easeOut } );
		}
		
		public function resetSaturation():void
		{
			saturationSlider.value = 1 / 3;
			Model.saturationValue = 1 / 3;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}