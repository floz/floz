/*
    Author: Michael Labriola, Digital Primates, Inc.. http://www.digitalprimates.net
    Date:   11/5/2004

	NO WARRANTY 
	This material  is furnished  by Digital Primates, Inc. on  an 
	"as is" basis.  Digital Primates, Inc. makes no warranties of any 
	kind,  either  expressed or implied as to any matter including, 
	but  not  limited  to,  warranty  of  fitness  for a particular 
	purpose  or  merchantability,  exclusivity  or results obtained 
	from  use  of the material. Digital Primates, Inc. does not make  
	any  warranty  of  any  kind with respect to freedom from 
	patent, trademark, or copyright infringement. 
*/

dynamic class HorseRemoteObject extends SharedRemote
{
	private function displayAlertBox( message:String )
	{
		mx.core.Application.alert( message );
	}

	private function setupRemoteMethods()
	{
		super.setupRemoteMethods();
		registerRemoteMethod( "showAlert", "displayAlertBox" );
	}
}
