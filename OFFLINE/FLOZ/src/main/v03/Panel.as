
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v03
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
		public static const NOISE:String = "noise";
		public static const PERLIN:String = "perlin";
		public static const BEND:String = "bend";
		public static const FORCE_VALUE_CHANGE:String = "force_value_change";
		public static const OFFSET_VALUE_CHANGE:String = "offset_value_change";
		public static const SEGMENTS_VALUE_CHANGE:String = "segments_value_change";
		public static const AXIS_CHANGE:String = "axis_change";
		
		public var zcForce:Slider;		
		public var zcSegmentsW:Slider;		
		public var zcSegmentsH:Slider;
		public var zcOffset:Slider;
		
		public var zcNoise:RadioButton;
		public var zcPerlin:RadioButton;
		public var zcBend:RadioButton;
		public var zcAxisX:RadioButton;
		public var zcAxisY:RadioButton;
		
		public var txtForce:TextField;
		public var txtSegmentsW:TextField;
		public var txtSegmentsH:TextField;
		public var txtOffset:TextField;
		
		//
		
		private var _radioButtonGroup:RadioButtonGroup;
		private var _axisButtonGroup:RadioButtonGroup;
		
		private var _slider:Slider;
		private var _segmentsW:int;
		private var _segmentsH:int;
		private var _force:Number;
		private var _offset:Number;
		private var _modifier:String = "";
		private var _axis:int;
		
		public function Panel() 
		{
			_radioButtonGroup = new RadioButtonGroup( "ModifierStackType" );
			_radioButtonGroup.addEventListener( Event.CHANGE, onRadioGroupButtonChange );
			
			_axisButtonGroup = new RadioButtonGroup( "Axis" );
			_axisButtonGroup.addEventListener( Event.CHANGE, onAxisChange );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );			
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			_segmentsH = zcSegmentsH.value;
			_segmentsW = zcSegmentsW.value;
			_force = zcForce.value;
			_offset = zcOffset.value;
			_axis = _axisButtonGroup.selection == zcAxisX ? ModConstant.X : ModConstant.Y;
			
			zcForce.addEventListener( Event.CHANGE, onSliderChange );
			zcOffset.addEventListener( Event.CHANGE, onSliderChange );
			zcSegmentsW.addEventListener( Event.CHANGE, onSliderChange );
			zcSegmentsH.addEventListener( Event.CHANGE, onSliderChange );
		}
		
		private function onRadioGroupButtonChange(e:Event):void 
		{
			var b:Boolean;
			switch( e.currentTarget.selection )
			{
				case zcNoise:
					b = _modifier == Panel.NOISE ? true : false;
					_modifier = Panel.NOISE; 
					if ( !b ) modifySlidersValue();
					
					dispatchEvent( new Event( Panel.NOISE ) ); 
					break;
				case zcPerlin:
					b = _modifier == Panel.PERLIN ? true : false;
					_modifier = Panel.PERLIN;
					if ( !b ) modifySlidersValue();
					
					dispatchEvent( new Event( Panel.PERLIN ) );
					break;
				case zcBend: 
					b = _modifier == Panel.BEND ? true : false;
					_modifier = Panel.BEND;
					if ( !b ) modifySlidersValue();
					
					dispatchEvent( new Event( Panel.BEND ) );
					break;
			}
		}
		
		private function onAxisChange(e:Event):void 
		{
			switch( e.currentTarget.selection )
			{
				case zcAxisX: _axis = ModConstant.X; break;
				case zcAxisY: _axis = ModConstant.Y; break;
			}
			dispatchEvent( new Event( Panel.AXIS_CHANGE ) )
		}
		
		private function onSliderChange(e:Event):void 
		{
			_slider = e.currentTarget as Slider;
			switch( _slider )
			{
				case zcForce:
					_force = _slider.value;
					txtForce.text = _force.toString();
					
					dispatchEvent( new Event( Panel.FORCE_VALUE_CHANGE ) );
					break;
				case zcSegmentsH:
					_segmentsH = _slider.value;
					txtSegmentsH.text = _segmentsH.toString();
					
					dispatchEvent( new Event( Panel.SEGMENTS_VALUE_CHANGE ) );
					break;
				case zcSegmentsW:
					_segmentsW = _slider.value;
					txtSegmentsW.text = _segmentsW.toString();
					
					dispatchEvent( new Event( Panel.SEGMENTS_VALUE_CHANGE ) );
					break;
				case zcOffset:
					_offset = _slider.value;
					txtOffset.text = _offset.toString();
					
					dispatchEvent( new Event( Panel.OFFSET_VALUE_CHANGE ) );
					break;
			}
		}
		
		// PRIVATE
		
		private function modifySlidersValue():void
		{
			if ( _modifier == Panel.BEND )
			{
				zcForce.minimum = 0;
				zcForce.maximum = 2;				
				zcForce.snapInterval = .01;
			}
			else
			{
				zcForce.minimum = 0;
				zcForce.maximum = 10;				
				zcForce.snapInterval = .5;
			}
			
			zcForce.value = 0;
			_force = 0;
			txtForce.text = zcForce.value.toString();
		}
		
		// PUBLIC
		
		public function get segmentsW():int { return this._segmentsW; }
		public function get segmentsH():int { return this._segmentsH; }
		public function get force():Number { return this._force; }
		public function get offset():Number { return this._offset; }		
		public function get modifier():String { return this._modifier; }
		public function get axis():int { return this._axis; }
		
	}
	
}