
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
	
	public class Main01 extends MovieClip 
	{
		
		public function Main01() 
		{
			var map:BitmapData = new BitmapData( 400, 400, false, 0xffffffff );
			var calculationMap:BitmapData = map.clone();
			
			var b:Bitmap = new Bitmap( map );
			addChild( b );
			
			b = new Bitmap( calculationMap );
			b.x = b.width;
			addChild( b );			
		}
		
		// EVENTS
		
		// PRIVATE
		
		// PUBLIC
	}
	
}