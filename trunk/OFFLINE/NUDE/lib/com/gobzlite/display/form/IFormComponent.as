package com.gobzlite.display.form 
{
	
	/**
	 * ...
	 * @author DavidRonai
	 */
	public interface IFormComponent 
	{
		function get value():String;
		function require(value:Boolean):IFormComponent;
		function isValid():Boolean;
	}
	
}