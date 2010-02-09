﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package maps 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import maps.builders.IMapBuilder;
	import maps.tiles.Tile;
	
	public interface IMap 
	{
		function getTile( x:int, y:int ):Tile;
		
		function addChild( child:DisplayObject ):DisplayObject;
		
		function get mapDatas():Array;
		function set mapDatas( value:Array ):void;
		
		function get tileSize():int;
		function set tileSize( value:int ):void;
		
		function get type():String;
		function set type( value:String ):void;
	}
	
}