
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	[SWF( backgroundColor = '0xFF00FF', frameRate = '40', width = '400', height = '400')]
	
	public class DeletingNoise_02 extends Sprite
	{
		private var image:BitmapData;
		
		private var aPixels:Array;
		private var aParticules:Array;
		private var aRects:Array;
		
		public function DeletingNoise_02() 
		{
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.beginFill( 0xffffff );
			g.drawCircle( 0, 0, 40 );
			g.endFill();
			
			image = new BitmapData( stage.stageWidth, stage.stageHeight, false, 0x000000 );
			image.draw( s, new Matrix( 1, 0, 0, 1, stage.stageWidth >> 2, stage.stageHeight >> 2 ) );
			image.draw( s, new Matrix( 1, 0, 0, 1, stage.stageWidth - (stage.stageWidth >> 4) - s.width, stage.stageHeight >> 2 ) );
			image.draw( s, new Matrix( 1, 0, 0, 1, stage.stageWidth >> 2, stage.stageHeight - (stage.stageHeight >> 4) - s.height ) );
			image.draw( s, new Matrix( 1, 0, 0, 1, stage.stageWidth - (stage.stageWidth >> 4) - s.width, stage.stageHeight - (stage.stageHeight >> 4) - s.height ) );
			addChild( new Bitmap( image ) );
			
			s = null;
			
			init();
		}
		
		// EVENTS
		
		// PRIVATE
		
		private function init():void
		{
			aPixels = [];
			var a:Array = [];
			
			var i:int; // y
			var j:int; // x
			var n:int = image.height;
			var m:int = image.width;
			for ( i; i < n; i++ )
			{
				for ( j = 0; j < m; j++ )
				{
					a.push( new Pixel( j, i, image.getPixel32( j, i ) ) );
				}
				aPixels.push( a );
				a = [];
			}
			
			analyse();
			//draw();
		}
		
		private function analyse():void
		{
			aParticules = [];
			
			var p:Pixel;
			
			var i:int; // y
			var j:int; // x
			var n:int = image.height;
			var m:int = image.width;
			for ( i; i < n; i++ )
			{
				for ( j = 0; j < m; j++ )
				{
					p = aPixels[ i ][ j ];
					if ( p.color == 0xffffffff ) aParticules.push( p );
				}
			}
		}
		
		private function draw():void
		{			
			var xmin:int;
			var ymin:int;
			var xmax:int;
			var ymax:int;
			
			var o:Object = { xmin: xmin, ymin: ymin, xmax: xmax, ymax: ymax };
			
			var b:Boolean;
			var p:Pixel;
			var i:int;
			var n:int = aParticules.length;
			for ( i; i < n; i++ )
			{
				p = aParticules[ i ];
				
				if ( !i ) 
				{
					xmin = p.x;
					ymin = p.y;
				}
				else
				{
					xmin = ( p.x < xmin ) ? p.x : xmin;
					ymin = ( p.y < ymin ) ? p.y : ymin;
				}				
				xmax = ( p.x > xmax ) ? p.x : xmax;
				ymax = ( p.y > ymax ) ? p.y : ymax;
			}
			
			//
			
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.beginFill( 0xff00ff );
			g.drawRect( 0, 0, ( xmax - xmin ), ( ymax - ymin ) );
			g.endFill();
			
			image.draw( s, new Matrix( 1, 0, 0, 1, xmin, ymin ) );
		}
		
		// PUBLIC
		
	}
	
}