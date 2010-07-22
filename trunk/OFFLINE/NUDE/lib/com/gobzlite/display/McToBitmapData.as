package com.gobzlite.display 
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author David Ronai
	 */
	public class McToBitmapData
	{
		
		public function McToBitmapData() 
		{
			throw new Error("You can't create an instance of McToBitmapData, use static method");
		}
		
		/**
		 * copy a movie clip into a vector of bitmapData
		 * @param	mc Your movie clip
		 * @param	ratio Scale the MovieClip
		 * @return	vector of BitmapData from the MovieClip Scaled
		 */
		public static function copy(mc:MovieClip, ratio:Number = 1, force:Boolean = false, width:int = -1 , height:int = -1):Vector.<BitmapData> 
		{
			var i:int;
			var bitmapData:BitmapData;
			
			var totalFrames:int =  mc.totalFrames;
			
			var frames:Vector.<BitmapData> = new Vector.<BitmapData>(totalFrames);
			
			var rect:Rectangle;
			
			mc.gotoAndStop(0);
			
			ratio = Math.abs(ratio);
			
			var matrix:Matrix = new Matrix();
			matrix.scale(ratio, ratio);
		
			var width:int;
			var height:int;
			
			for ( i = 0; i <totalFrames; i++)
			{
				rect = mc.getBounds(mc);
				trace( rect, rect.width, rect.height, rect.x, rect.y );
				
				width = Math.ceil(rect.width* ratio);
				height = Math.ceil( rect.height * ratio );
				trace( width );
				trace( height );
				//matrix.tx = rect.x * ratio;
				//matrix.ty = rect.y * ratio;
				
				bitmapData = new BitmapData(width + 6, height + 6, true, 0x00);
				bitmapData.draw( mc, matrix, null, null, new Rectangle(0, 0, width + 6,height+6));

				frames[i] = bitmapData;
				
				mc.gotoAndPlay(i);
			}
			
			return frames;
		}
		
	}

}