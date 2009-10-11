/*
    Author: Michael Labriola, Digital Primates, Inc.. http://www.digitalprimates.net
    Date:   11/5/2004
	Version 1.0.3

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

[Event("connected")]
[Event("closed")]
[Event("rejected")]
[Event("failed")]

class FCSService extends mx.remoting.Connection
{
	public var addEventListener : Function;
	public var removeEventListener : Function;
	private var dispatchEvent : Function;
	
	var id:String;
	var _attached:Boolean = false;

	public var	className:String = "FCSService";

	public function set attached( value:Boolean ):Void
	{
		_attached = value;
	}

	public function get attached():Boolean
	{
		return _attached;
	}

	public function onStatus(infoObject:Object):Void
	{
		switch (infoObject.code) 
		{
			case "NetConnection.Connect.Success" :
				attached = true;
				dispatchEvent({type:"connected",target:this})
			   break;
			case "NetConnection.Connect.Closed" :
				dispatchEvent({type:"closed",target:this})
			   break;
			case "NetConnection.Connect.Failed" :
				dispatchEvent({type:"failed",target:this})
			   break;
			case "NetConnection.Connect.Rejected" :
				dispatchEvent({type:"rejected",target:this});
			   break;
			default :
			   //statements
			   break;
		}
	}

	//Constructor
	public function FCSService( )
	{		
		mx.events.EventDispatcher.initialize(this);		
	}
}
