/*
    Author: Michael Labriola, Digital Primates, Inc.. http://www.digitalprimates.net
    Date:   11/5/2004
	Version 1.0.5

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
[Event("failed")]
[Event("sync")]
[Event("status")]

import mx.utils.Delegate; 


dynamic class SharedRemote extends Object
{
	var id:String;
	var name:String;
	private var _service:FCSService;
	private var _persistent:Boolean = false;
	public var ro:SharedObject;

	var synchronized:Boolean = false;
	var connected:Boolean = false;

	public var className:String = "SharedRemote";

	public var addEventListener : Function;
	public var removeEventListener : Function;
	private var dispatchEvent : Function;

	public function set persistent( value:Boolean ):Void
	{
		_persistent = value;
	}

	public function get persistent():Boolean
	{
		return _persistent;
	}

	public function set service( value:FCSService ):Void
	{
		_service = value;
		if ( service.attached == true )
		{
			//Service is already connected
			//We can just init, there is a possible race condition here
			initialize( service );
		}
		else
		{
			//service has not yet connected.
			//we need to wait until it has to init our object completely
			service.addEventListener("connected", Delegate.create(this, onFCSConnected ));
		}
	}

	public function get service():FCSService
	{
		return _service;
	}

	public function get data():Object
	{
		return ro.data;
	}

	function connect(myConnection:NetConnection):Boolean
	{
		var success:Boolean;

		success = ro.connect(myConnection);
		
		if ( success )
		{
			dispatchEvent({type:"connected",target:this});
		}
		else
			dispatchEvent({type:"failed",target:this});
			
		return success;
	}

	function onStatus(infoObject:Object):Void
	{
		dispatchEvent({type:"status",target:this,info:infoObject});
	}

	function onSync(objArray:Array):Void
	{
		synchronized = true;
		dispatchEvent({type:"sync",target:this,actions:objArray,data:data});
	}

	function remoteMethodBroadcaster()
	{
		ro[methodName] = function()
		{
			this.dispatchEvent( {type:methodName, target:this, args:arguments} );
		};

		//We create an event dispatcher that will dispatch an event with the remote method name and send arguments along as a param
		//this function can be called externally, however, it is generally called from within setupRemoteMethodBroadcasters()
		//the idea is to subclass SharedRemote and setup your broadcasters in the subclass
	}

	function registerRemoteMethod( remoteMethodName:String, localMethodName:String )
	{
		//this function is designed to register a specific method from within a subclass of SharedRemote to a remote object
		ro[remoteMethodName] = mx.utils.Delegate.create( this, this[localMethodName] );
	}

	function addRemoteMethodBroadcaster( remoteMethodName:String )
	{
		ro[remoteMethodName] = function ()
		{
			this.owner.dispatchEvent( {type:remoteMethodName, target:this.owner, args:arguments} );
		};

		//We create an event dispatcher that will dispatch an event with the remote method name and send arguments along as a param
		//this function can be called externally, however, it is generally called from within setupRemoteMethods()
		//the idea is to subclass SharedRemote and setup your broadcasters in the subclass
	}

	function removeRemoteMethodBroadcaster( remoteMethodName:String )
	{
		delete ro[remoteMethodName];
		//delete the event dispatcher associated with a given method		
	}

	public function __resolve(methodName:String):Function
	{
		//Just because we can't sublcass the SharedObject doesn't mean we can't treat our new object as though it were a subclass
		//It just means we need to do a lot more work first
		
		//In this case, if the function trying to be accessed does not exit in this object, we are going to check
		//the remote object.  If it exists there, we will call it, else we will return undefined

		if ( ( !connected ) || ( ro[methodName] == undefined ) || ( typeof(ro[methodName]) != "function" ) )
		{
			//If we are not connected, the method does not exist, or it is not a function, return undefined
			return undefined;
		}

		var f:Function = function () 
		{ 
			return ( this.ro[methodName].apply(this.ro, arguments) ); 
		};

		// create a new object method and assign it the reference
		this[methodName] = f;

		// return the reference to the function
		return f;
	}

	private function onFCSConnected( event:Object )
	{
		//set our service to the FCS service that just called a connect
		service = event.target;
	}

	private function setupRemoteMethods()
	{
	}

	private function initialize( service:FCSService )
	{
		var success:Boolean;

		ro = SharedObject.getRemote(name,service.uri, persistent );
		ro.onSync = Delegate.create(this, onSync);
		ro.onStatus = Delegate.create(this, onStatus);
		Object(ro).owner = this;

		success = ro.connect( service );

		if ( success )
		{
			connected = true;
			setupRemoteMethods();
			dispatchEvent({type:"connected",target:this});
		}
		else
			dispatchEvent({type:"failed",target:this});
	}

	public function SharedRemote( )
	{		
		mx.events.EventDispatcher.initialize(this);	
	}
}
