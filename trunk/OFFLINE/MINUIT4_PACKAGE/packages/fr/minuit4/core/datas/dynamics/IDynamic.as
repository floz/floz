
/**
* Written by :
* @author Floz
* www.floz.fr || www.minuit4.fr
*/
package fr.minuit4.core.datas.dynamics 
{

	public interface IDynamic 
	{
		function hasProperty( propertyName:String ):Boolean;
		
		function getData( propertyName:String ):*
	}
}
