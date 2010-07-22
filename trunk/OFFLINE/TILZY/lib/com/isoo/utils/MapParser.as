package com.isoo.utils 
{
	import com.isoo.data.TileManager;
	import com.isoo.map.Map;
	import com.isoo.map.Tile;
	import game.object.ObjectManager;
	/**
	 * ...
	 * @author David Ronai
	 */
	public class MapParser
	{		
		public function MapParser() 
		{
			
		}

		public static function parse( xml:XML ):Map
		{
			trace( xml );
			
			if ( xml.map == undefined ) throw new Error("Unknow xml type : " + xml);
			if ( xml.map.@height == undefined ) throw new Error("Unknow map height : " + xml);
			if ( xml.map.@width == undefined ) throw new Error("Unknow map width : " + xml);
			if ( xml.map.TilesFlag == undefined ) throw new Error("Unknow map tiles flag : " + xml);
			if ( xml.map.TilesId == undefined ) throw new Error("Unknow map tiles id : " + xml);
			
			var map:Map = new Map( int(xml.map.@height), int(xml.map.@width) );
			
			var tilesFlag:XML =  xml.map.TilesFlag[0];
			var i:int=0;
			for each( var line:XML in tilesFlag.l ) 
			{
				var s:String = line;
				var tiles:Array = s.split(",");
				
				if ( tiles.length != map.width ) 
					throw new Error("width tile amount is not valid");
				
				for ( var j:int = 0; j < tiles.length; j++)
					map.getTile(j, i).flag = tiles[j];
				
				i++;
			}
			
			var tilesId:XML =  xml.map.TilesId[0];
			i=0;
			for each( line in tilesId.l ) 
			{
				s = line;
				tiles = s.split(",");
				
				if ( tiles.length != map.width ) 
					throw new Error("width tile amount is not valid");
				
				for ( j = 0; j < tiles.length; j++) 
				{
					map.getTile(j, i).id = tiles[j];
				}
				
				i++;
			}
			
			return map;
		}
		
		public static function tilesToLoad( xml:XML ):Array
		{
		
			var tilesId:XML =  xml.map.TilesId[0];
			var alreadyInList:Boolean;
			var tilesNotLoaded:Array = [];
			var i:int = 0;
			var s:String;
			var tiles:Array;
			
			for each( var line:XML in tilesId.l ) 
			{
				s = line;
				tiles = s.split(",");
				
				for ( var j:int = 0; j < tiles.length; j++) 
				{
					if ( TileManager.getImage(tiles[j]) == null ) 
					{
						alreadyInList = false;
						for ( var k:int = 0; k < tilesToLoad.length; k++ ) 
						{
							if ( tilesNotLoaded[k] == tiles[j] )
							{
								alreadyInList = true;
								break;
							}
						}
						if ( !alreadyInList )
							tilesNotLoaded.push( tiles[j] );
					}
				}
				
				i++;
			}
			
			return tilesNotLoaded;
		}
		
		public static function assetsToLoad( xml:XML ):Array
		{
		
			var objects:XML =  xml.assets[0];
			var alreadyInList:Boolean;
			var notLoaded:Array = [];
			
			for each( var object:XML in objects.asset ) 
			{
				if ( !ObjectManager.exist(object.@id) ) 
				{
					alreadyInList = false;
					for ( var k:int = 0; k < notLoaded.length; k++ ) 
					{
						if ( notLoaded[k] == object.@id )
						{
							alreadyInList = true;
							break;
						}
					}
					if ( !alreadyInList )
						notLoaded.push( object.@id );
				}
			}
			
			return notLoaded;
		}
	}
}