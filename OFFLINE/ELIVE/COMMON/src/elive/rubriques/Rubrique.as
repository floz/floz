﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.rubriques 
{
	import elive.rubriques.sections.SectionsController;
	import flash.display.Sprite;
	import fr.minuit4.core.configuration.Configuration;
	
	public class Rubrique extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _sectionsController:SectionsController;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Rubrique() 
		{
			_sectionsController = new SectionsController();
			addChild( _sectionsController );
			
			if ( !stage )
			{
				Configuration.baseURL = "../../";
			}
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}