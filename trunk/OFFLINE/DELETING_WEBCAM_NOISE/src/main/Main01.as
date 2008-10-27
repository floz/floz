
/**
 * Written by :
 * @author DefaultUser (Tools -> Custom Arguments...)
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	public class Main01 extends MovieClip 
	{
		private var map:BitmapData;
		private var calculationMap:BitmapData;
		
		private var aPixels:Array = [];
		
		public function Main01() 
		{
			map = new BitmapData( 400, 400, false, 0xffffffff );
			calculationMap = map.clone();
			
			var b:Bitmap = new Bitmap( map );
			addChild( b );
			
			b = new Bitmap( calculationMap );
			b.x = b.width;
			addChild( b );
			
			generate();
			analyse();
		}
		
		// EVENTS
		
		// PRIVATE
		
		private function generate():void
		{
			calculationMap.perlinNoise( 100, 100, 10, getTimer(), true, true, 0, true );
			map.fillRect( map.rect, 0xffffffff );
			map.threshold( calculationMap, map.rect, new Point(), "<", 0x999999, 0xff00ff, 0xFFFFFF, false );
			
			calculationMap.draw( map );
		}
		
		private function analyse():void
		{
			var a:Array;
			var b:Boolean;
			
			var i:int;
			var j:int;
			var n:int = map.width >> 1;
			var m:int = map.height >> 1;
			for ( j; j < m; j++ )
			{
				a = [];
				
				for ( i = 0; i < n; i++ )
				{
					b = map.getPixel( i, j ) ? true : false;
					a.push( b );
				}
				aPixels.push( a );
			}
		}
		
		// PUBLIC
	}
	
}