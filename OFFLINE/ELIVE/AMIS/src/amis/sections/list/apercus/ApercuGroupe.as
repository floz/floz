
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.list.apercus 
{
	import elive.core.groups.Group;
	import elive.utils.EliveUtils;
	
	public class ApercuGroupe extends Apercu
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _group:Group;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ApercuGroupe( group:Group ) 
		{
			this._group = group;
			super();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function init():void 
		{
			super.init();
			
			tf.x = 5;
			
			var text:String = _group.name + "\nNombre (e)livers : " + _group.getMembers().length;
			EliveUtils.configureText( tf, "amis_list_apercu_content", text );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function getId():int { return _group.id; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}