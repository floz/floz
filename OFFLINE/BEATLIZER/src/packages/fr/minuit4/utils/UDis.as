package fr.minuit4.utils 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class UDis 
	{
		public static function define(pTarget:Object = null, pX:int = 0, pY:int = 0):void
		{
			if (!pTarget) return;
			pTarget.x = pX;
			pTarget.y = pY;
		}
		
		//public static function bringToFront( child:DisplayObject ):void
		//{
			//var parent:DisplayObjectContainer = child.parent;
			//if ( !parent ) return;
			//
			//parent.setChildIndex( child, int( parent.numChildren - 1 ) );
		//}
	}
	
}