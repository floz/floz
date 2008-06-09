package floz.utils 
{
	import flash.display.DisplayObjectContainer;
	
	public class UDis 
	{
		
		public static function getChildren( container:DisplayObjectContainer ):Array 
		{
			var a:Array = [];
			
			var i:int = 0;
			var n:int = container.numChildren;
			for ( i; i < n; i++ )
				a.push( container.getChildAt( i ) );
				
			return a;
		}
		
	}
	
}