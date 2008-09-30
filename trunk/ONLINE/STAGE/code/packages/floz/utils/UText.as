package floz.utils 
{	
	public class UText 
	{
		static public function replace(t:String):String
		{
			var i:int = t.search( /[àâèéêëêÉÈËÂÁ]/g );
			if ( i >= 0 )
			{
				t = t.replace( /[èéëê]/g, "e").replace( /[ÉÈËÊ]/g, "E" );
				t = t.replace( /[àâ]/g, "a").replace( /[ÂÁ]/g, "A" );
			}
			i = 0;
			
			i = t.search( /[ôöîïùüÖÔÏÎÛÙ]/g );
			if ( i >= 0 )
			{
				t = t.replace( /[ôö]/g, "o").replace( /[ÖÔ]/g, "O" );
				t = t.replace( /[îï]/g, "i").replace( /[ÏÎ]/g, "I" );
				t = t.replace( /[ùü]/g, "u").replace( /[ÛÙ]/g, "U" );
			}
			
			return t;
		}
		
		static public function searchEffect(t:String):void
		{
			
		}
	}
	
}