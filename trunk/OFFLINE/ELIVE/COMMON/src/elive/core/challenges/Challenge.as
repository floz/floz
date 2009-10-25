
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.core.challenges 
{
	import elive.core.comments.Comment;
	import elive.core.users.User;
	
	public class Challenge 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _status:String;
		private var _mediasUrl:Array
		private var _sender:User;
		private var _targets:Array;
		private var _comments:Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var id:int;
		public var title:String;
		public var description:String;
		public var endTime:Number;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Challenge() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function config( id:int, title:String, description:String, endTime:Number ):void
		{
			this.id = id;
			this.title = title;
			this.description = description;
			this.endTime = endTime;
		}
		
		public function setSender( sender:User ):void
		{
			this._sender = sender;
		}
		public function getSender():User { return _sender; }
		
		public function setTargets( targets:Array ):void
		{
			this._targets = targets;
		}
		public function getTargets():Array { return this._targets; }
		
		public function setStatus( status:String ):void
		{
			this._status = status;
		}
		public function getStatus():String { return _status; }
		
		public function setMediasUrls( urls:Array ):void
		{
			this._mediasUrl = urls;
		}
		public function getMediasUrls():Array { return this._mediasUrl; }
		
		public function setComments( value:Array ):void
		{
			this._comments = value;
		}
		public function getComments():Array { return this._comments; }
		
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}