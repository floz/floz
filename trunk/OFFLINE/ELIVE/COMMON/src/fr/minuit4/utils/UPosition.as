package fr.minuit4.utils 
{
	public class UPosition 
	{
		public static function define(pTarget:Object = null, pX:int = 0, pY:int = 0):void
		{
			if (!pTarget) return;
			pTarget.x = pX;
			pTarget.y = pY;
		}
	}
	
}