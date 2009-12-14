package com.bigarobas.display.layer {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	
	public interface ILayer {
		
		function get paddings():Array;
		function set paddings(value:Array):void;
		function get margins():Array;
		function set margins(value:Array):void;

		function redisplay():void;
		function replace():void;
		function resize():void;
		
		
	}
	
	
	
}