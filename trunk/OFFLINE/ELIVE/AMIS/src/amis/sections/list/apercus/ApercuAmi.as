
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.list.apercus 
{
	import assets.GApercuAvatar;
	import assets.GAvatar1;
	import elive.core.users.User;
	import elive.utils.EliveUtils;
	
	public class ApercuAmi extends Apercu
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _user:User;
		private var _avatarHolder:GApercuAvatar;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ApercuAmi( user:User ) 
		{
			this._user = user;
			super();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function init():void 
		{
			super.init();
			
			_avatarHolder = new GApercuAvatar();
			_avatarHolder.x = 5;
			_avatarHolder.y = 2;
			_avatarHolder.cnt.addChild( new GAvatar1() );
			addChild( _avatarHolder );
			
			var text:String = _user.name + "\n" + _user.points;
			EliveUtils.configureText( tf, "amis_list_apercu_content", text );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function getId():int { return _user.id; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}