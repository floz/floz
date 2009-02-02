
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import fl.controls.RadioButton;
	import fl.controls.RadioButtonGroup;
	import fl.controls.Slider;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class Panel extends MovieClip 
	{
		public static const NOISE:String = "noise";
		public static const PERLIN:String = "perlin";
		public static const FORCE_VALUE_CHANGE:String = "force_value_change";
		public static const SEGMENTS_VALUE_CHANGE:String = "segments_value_change";
		
		public var zcForce:Slider;		
		public var zcSegmentsW:Slider;		
		public var zcSegmentsH:Slider;
		
		public var zcNoise:RadioButton;
		public var zcPerlin:RadioButton;
		
		public var txtForce:TextField;
		public var txtSegmentsW:TextField;
		public var txtSegmentsH:TextField;
		
		//
		
		private var _radioButtonGroup:RadioButtonGroup;
		
		private var _slider:Slider;
		private var _segmentsW:int;
		private var _segmentsH:int;
		private var _force:int;
		
		public function Panel() 
		{
			_radioButtonGroup = new RadioButtonGroup( "ModifierStackType" );
			_radioButtonGroup.addEventListener( Event.CHANGE, onRadioGroupButtonChange );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			_segmentsH = zcSegmentsH.value;
			_segmentsW = zcSegmentsW.value;
			_force = zcForce.value;			
			
			zcForce.addEventListener( Event.CHANGE, onSliderChange );
			zcSegmentsW.addEventListener( Event.CHANGE, onSliderChange );
			zcSegmentsH.addEventListener( Event.CHANGE, onSliderChange );
		}
		
		// EVENTS
		
		private function onRadioGroupButtonChange(e:Event):void 
		{
			switch( e.currentTarget.selection )
			{
				case zcNoise: dispatchEvent( new Event( Panel.NOISE ) ); break;
				case zcPerlin: dispatchEvent( new Event( Panel.PERLIN ) ); break;
			}
		}
		
		private function onSliderChange(e:Event):void 
		{
			_slider = e.currentTarget as Slider;
			switch( _slider )
			{
				case zcForce:
					_force = e.currentTarget.value;
					txtForce.text = _force.toString();
					
					dispatchEvent( new Event( Panel.FORCE_VALUE_CHANGE ) );
					break;
				case zcSegmentsH:
					_segmentsH = e.currentTarget.value;
					txtSegmentsH.text = _segmentsH.toString();
					
					dispatchEvent( new Event( Panel.SEGMENTS_VALUE_CHANGE ) );
					break;
				case zcSegmentsW:
					_segmentsW = e.currentTarget.value;
					txtSegmentsW.text = _segmentsW.toString();
					
					dispatchEvent( new Event( Panel.SEGMENTS_VALUE_CHANGE ) );
					break;
			}
		}
		
		// PRIVATE	
		
		// PUBLIC
		
		public function get segmentsW():int { return this._segmentsW; }
		public function get segmentsH():int { return this._segmentsH; }
		public function get force():int { return this._force; }
		
	}
	
}