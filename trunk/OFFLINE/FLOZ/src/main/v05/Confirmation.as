
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05 
{
	import fl.controls.Button;
	import fl.controls.RadioButton;
	import fl.controls.RadioButtonGroup;
	import fl.controls.TextInput;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Confirmation extends MovieClip
	{
		public static const CONFIRM:String = "confirm";
		public static const CANCEL:String = "cancel";
		
		public var rBend:RadioButton;
		public var rPerlin:RadioButton;
		public var rPivot:RadioButton;
		public var rTwist:RadioButton;
		public var zConfirm:Button;
		public var zCancel:Button;
		public var iName:TextInput;
		
		
		private var modifiers:RadioButtonGroup;
		private var input:TextInput;
		
		private var _selected:String;
		private var _selectedName:String;
		
		public function Confirmation() 
		{
			modifiers = new RadioButtonGroup( "Modifiers" );
			addEventListener( Event.ADDED_TO_STAGE, onAddeToStage );
		}
		
		// EVENTS
		
		private function onAddeToStage(e:Event):void 
		{
			this.visible = false;
			
			modifiers.selection = rBend;
			input = iName;
			
			modifiers.addEventListener( Event.CHANGE, onChange );
			zConfirm.addEventListener( MouseEvent.CLICK, onMouseClick );
			zCancel.addEventListener( MouseEvent.CLICK, onMouseClick );
		}
		
		private function onChange(e:Event):void 
		{
			iName.text = e.currentTarget.selection.label;
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case zConfirm: 
					if ( currentLabel == "Add" )
					{
						_selected = modifiers.selection.label;
						_selectedName = iName.text == "" ? modifiers.selection.label : iName.text;						
					}
					dispatchEvent( new Event( Confirmation.CONFIRM ) ); 
					break;
				case zCancel: dispatchEvent( new Event( Confirmation.CANCEL ) ); break;
			}
			this.visible = false;
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function openAddPanel():void
		{
			gotoAndPlay( "Add" );
			
			modifiers.selection = rBend;
			iName = input;
			iName.text = modifiers.selection.label;
			
			this.visible = true;
		}
		
		public function openDeletePanel():void
		{
			gotoAndPlay( "Delete" );
			
			this.visible = true;
		}
		
		// GETTERS & SETTERS
		
		public function get selected():String { return this._selected; }
		public function get selectedName():String { return this._selectedName; }
		
	}
	
}