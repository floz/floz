package com.bigarobas.net.loading {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	
	public interface ILoadingObject {
		function start():ILoadingObject;
		function get title():String;
		function get bytes_total():uint;
		function get bytes_loaded():uint;
		function get ratio():Number;
		function get pourcent():int;
		function set onComplete(f:Function):void
	}
	
}