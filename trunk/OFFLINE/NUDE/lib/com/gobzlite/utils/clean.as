package com.gobzlite.utils 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.system.System;
	
	/**
	 * Clean from memory a displayObjectContainer and all his children
	 * 
	 * @param	target	object to clean
	 * @param	forceGarbage	true to call the garbage collector at the end, else false
	 */
	public function clean( target:DisplayObjectContainer, forceGarbage:Boolean=true ):void
	{
		var d:DisplayObject;
		
		while ( target.numChildren > 0 )
		{
			d = target.removeChildAt( 0 );
			if ( d is Bitmap )
			{
				Bitmap( d ).bitmapData.dispose();
			}
			else if ( d is DisplayObjectContainer )
			{
				clean( d as DisplayObjectContainer, false );
			}
		}
		
		d = null;
		
		if ( forceGarbage )
			System.gc();			
	}
}