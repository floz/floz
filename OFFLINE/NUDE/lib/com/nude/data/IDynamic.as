package com.nude.data 
{
	import com.nude.data.parsers.IParser;
	
	public interface IDynamic 
	{
		function setParser( parser:IParser ):void;
		
		function parseDatas():void;
	}
	
}