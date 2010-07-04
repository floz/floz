
/**
* Written by :
* @author Floz
* www.floz.fr || www.minuit4.fr
*/
package fr.minuit4.core.datas.dynamics 
{
	public class DynamicFormats 
	{
		public static const XML:String = ".xml";
		public static const JSON:String = ".json";
		
		private static const _format:Array = [ XML, JSON ];
		
		public static function isFormatAllowed( format:String ):Boolean
		{
			var i:int = _format.length;
			while( --i > -1 )
				if( _format[ i ] == format ) return true;
			
			return false;
		}
	}
}
