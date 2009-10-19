
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
	
	public class Rubrique extends Sprite implements IRubrique
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _sectionsController:SectionsController;
		protected var _standalone:Boolean = false;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Rubrique() 
		{
			_sectionsController = new SectionsController();
			addChild( _sectionsController );
			
			if ( stage )
			{
				_standalone = true;
				Configuration.baseURL = "../../";
				Configuration.pathXML = Configuration.baseURL + "/xmls";
			}
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function navigateTo( sectionId:int, id:int = -1 ):void
		{
			_sectionsController.navigateTo( sectionId, id );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}