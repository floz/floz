/*
 PureMVC AS3 Demo - Flex Employee Admin 
 Copyright (c) 2007-08 Clifford Hall <clifford.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.employeeadmin.controller
{
	import mx.controls.Alert;

	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class AddRoleResultCommand extends SimpleCommand implements ICommand
	{
		override public function execute( notification:INotification ):void
		{
			var result:Boolean = notification.getBody() as Boolean;
			if ( result == false ) {
				Alert.show ('Role already exists for this user!','Add User Role');
			}
		}
		
	}
}