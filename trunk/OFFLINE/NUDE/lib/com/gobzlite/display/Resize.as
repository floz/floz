package com.gobzlite.display 
{
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * 
	 * @author DavidRonai
	 */
	public class Resize 
	{
	
		private static var divs:Array;
		private static var _hasStage:Boolean;
		
		private static var _instance:Resize = new Resize();
		public function Resize() 
		{
			if ( _instance )
				throw new Error("you can't create an instance of Resize");
			
			_hasStage = false;
			divs = new Array();		
		}
		
		/**
		 * Add element to resize list
		 * @param	div
		 */
		public static function add( div:Div ):void
		{
			divs.push( div );
		}
		
		/**
		 * Remove element from resize list
		 * @param	div
		 */
		public static function remove( div:Div ):void
		{
			for ( var i:int = 0; i < divs.length ; i++ )
				if ( divs[i] === div ){
					divs.splice(i, 1);
					return;
				}
		}
		
		public static function stage(stage:Stage):void
		{
			if( stage != null){
				_hasStage = true;
				stage.addEventListener(Event.RESIZE, resizeHandler);
			} else {
				_hasStage = false;
			}
		}
		
		/**
		 * Resize all component
		 */
		public static function now():void
		{
			resizeHandler(null);
		}
		
		/**
		 * Call on stage resize
		 * @param	e
		 */
		static private function resizeHandler(e:Event):void 
		{
			for ( var i:int = 0; i < divs.length ; i++ )
				( divs[i] as Div ).resize();
		}
		
		public static function get instance():Resize { return _instance; }
		
		public static function get hasStage():Boolean { return _hasStage; }
		
	}
	
}