package com.bigarobas.templates.website {
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public interface IWebPage {
		function close():void
		function open():void
		function set address(vAddress:String):void
		function get address():String
		function addPage(vPage:IWebPage):IWebPage
		function removePage(vPage:IWebPage):IWebPage
	}

}