/**
 | N U D E
 | The low dependent flash oriented framework
 |
 | Copyright © 2009		> MIT license 					> http://www.opensource.org/licenses/mit-license.php
 | Florian Zumbrunn		> florian.zumbrunn@gmail.com	> http://www.floz.fr
 | Arnaud Nicolas		> arno06@gmail.com				> 
 | Rashid Ghassempouri	> rashid.ghassempouri@gmail.com	> http://www.bigarobas.com
 */
 
package com.nude.ui {
	
	/**
	* 	What a Component should be ^^
	* 	@langversion ActionScript 3.0
	*/
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFormat;

	public class Component extends Sprite {
		
		public static const DEFAULT_CALLBACK:Function = function():void { };
		public static const DEFAULT_BACKGROUND_COLOR:uint = 0xCCCCCC;
		public static const DEFAULT_FOREGROUND_COLOR:uint = 0x000000;
		public static const DEFAULT_SIZE:Number = 100;
		public static const DEFAULT_TEXTFORMAT:TextFormat = new TextFormat("_sans", 12, DEFAULT_FOREGROUND_COLOR, null, null, null, null, null, "justify", null, null, null, null);
		
		protected var _id:String = "";
		protected var _width:Number;
		protected var _height:Number;
		
		public function Component() {

		}
		
		public function redraw():void {
			addEventListener(Event.ENTER_FRAME, onRedraw, false, 0, true);
		}
		
		private function onRedraw(e:Event):void {
			removeEventListener(Event.ENTER_FRAME, onRedraw);
			draw();
		}
		
		protected function draw():void {

		}
		
		public function get id():String { return _id; }
		
		public function set id(value:String):void {
			_id = value;
		}
		
		
	}

}