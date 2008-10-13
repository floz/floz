package  main
{
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	public class Gradient 
	{
		
		static public function getArray( colors:Array, alphas:Array, ratios:Array ):Array
		{
			var m:Matrix = new Matrix();
			var bmpd:BitmapData = new BitmapData( 256, 1, true, 0 );
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			
			m.createGradientBox( 256, 256 );
			
			g.clear();
			g.beginGradientFill( GradientType.LINEAR, colors, alphas, ratios, m );
			g.drawRect( 0, 0, 256, 256 );
			g.endFill();
			
			bmpd.draw( s, m );
			
			var a:Array = [];
			var c:uint;
			var i:int;
			
			for ( i; i < 256; i++ )
			{
				a.push( c = bmpd.getPixel32( i, 0 ) );
			}
			
			trace ( a );
			return a;
		}
		
	}
	
}