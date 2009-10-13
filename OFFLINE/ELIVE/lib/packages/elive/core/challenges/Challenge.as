
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.core.challenges 
{
	import elive.core.users.User;
	
	public class Challenge 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _title:String;
		private var _description:String;
		private var _startTime:Number;
		private var _endTime:Number;
		private var _status:String;
		private var _mediasUrl:Vector.<String>;
		private var _sender:User;
		private var _targets:Vector.<User>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Challenge() 
		{
			_mediasUrl = new Vector.<String>();
			_targets = new Vector.<User>();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setTitle( value:String ):void 
		{
			_title = value;
		}
		public function getTitle():String { return _title; }
		
		public function setDescription( value:String ):void 
		{
			_description = value;
		}
		public function getDescription():String { return _description; }
		
		public function setStatus( value:String ):void
		{
			_status = value;
		}
		public function getStatus():String { return _status; }
		
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}