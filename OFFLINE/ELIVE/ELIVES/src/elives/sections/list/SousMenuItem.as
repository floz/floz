/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elives.sections.list 
{
	import assets.GBtSousMenu;
	import elive.utils.EliveUtils;
	import fr.minuit4.motion.M4Tween;
	
	public class SousMenuItem extends GBtSousMenu
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var title:String;
		public var sousRubId:String;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SousMenuItem( title:String, sousRubId:String ) 
		{
			this.name = name;
			this.sousRubId = sousRubId;
			
			EliveUtils.configureText( tf, "elives_sousmenu_bt", title );
			
			bg.alpha = 0;
			
			this.mouseChildren = false;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function over():void
		{
			bg.alpha = .6;
			M4Tween.to( bg, .25, { alpha: 1 } );
		}
		
		public function out():void
		{
			bg.alpha = .4;
			M4Tween.to( bg, .25, { alpha: 0 } );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}