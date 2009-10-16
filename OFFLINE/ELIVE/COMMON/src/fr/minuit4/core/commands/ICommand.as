
/**
* Written by :
* @author Floz
* www.floz.fr || www.minuit4.fr
*/
package fr.minuit4.core.commands 
{
	import flash.events.IEventDispatcher;

	public interface ICommand extends IEventDispatcher
	{
		function execute():void;
	}
}
