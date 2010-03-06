
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.phorm.debug 
{
	import assets.debug.AssetDebugButton;
	import flash.text.TextFieldAutoSize;
	
	public class DebugButton extends AssetDebugButton
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _label:String;
		private var _width:Number;
		private var _height:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DebugButton( label:String, width:Number = 100, height:Number = 20 ) 
		{
			this.label = label;
			this.width = width;
			this.height = height;
			
			tf.mouseEnabled = false;
			
			this.useHandCursor =
			this.buttonMode = true;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get label():String { return _label; }
		
		public function set label(value:String):void 
		{
			tf.text = value;
			tf.autoSize = TextFieldAutoSize.CENTER;
		}
		
		override public function get width():Number { return _width; }
		
		override public function set width(value:Number):void 
		{
			bt.width =
			bg.width =
			tf.width = value;
		}
		
		override public function get height():Number { return _height; }
		
		override public function set height(value:Number):void 
		{
			bt.height = 
			bg.height =
			tf.height = value;
		}
		
	}
	
}