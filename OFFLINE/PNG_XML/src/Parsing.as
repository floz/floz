
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.BitmapData;
	import flash.events.WeakFunctionClosure;
	
	public class Parsing 
	{
		
		public static function parsePng( png:BitmapData ):Array
		{
			if ( png.width == 0 && png.height == 0 ) return null;
			
			var a:Array;
			var pngParsed:Array = [];			
			
			var w:int = png.width;
			var h:int = png.height;
			var j:int;
			for ( var i:int; i < w; ++i )
			{
				a = [];
				for ( j = 0; j < h; ++j )
					a.push( png.getPixel32( i, j ) );
				
				pngParsed.push( a );
			}
			
			return pngParsed;
		}
		
		public static function createPng( a/*Array*/:Array ):BitmapData
		{
			if ( !a.length ) return null;
			
			var w:int = a.length;
			var h:int = a[ 0 ].length;
			
			var png:BitmapData = new BitmapData( w, h, true, 0x00 );
			
			var j:int;
			for ( var i:int; i < w; ++i )
			{
				for ( j = 0; j < h; ++j )
					png.setPixel32( w, j, a[ i ][ j ] );
			}
			
			return png;
		}
		
		public static function readImgParsed( a/*Array*/:Array ):String
		{
			if ( !a.length ) return "";
			
			var s:String = "";			
			var w:int = a.length;
			var h:int = a[ 0 ].length;
			
			var j:int;
			for ( var i:int; i < w; ++i )
			{
				s = s.concat( "[" );
				for ( j = 0; j < h; ++j )
				{
					s = s.concat( int( a[ i ][ j ] ).toString() );
					s = ( j != int( h - 1 ) ) ? s.concat( "," ) : s;
				}
				
				s = s.concat( "]" );
				
				if ( i != int( w - 1 ) ) s = s.concat( "," );
			}
			
			return s;
		}
		
	}
	
}