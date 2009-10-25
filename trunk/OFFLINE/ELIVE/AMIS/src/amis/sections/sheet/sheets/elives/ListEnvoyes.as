
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.sheet.sheets.elives 
{
	
	final public class ListEnvoyes extends List
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ListEnvoyes() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function buildSousMenu():void 
		{
			_sousMenu.addItem( "En cours", SousRubIds.EN_COURS, "elives_sousmenu_bt_over_encours" );
			_sousMenu.addItem( "Terminés", SousRubIds.TERMINES, "elives_sousmenu_bt_over_termines" );
			
			_currentSousRub = SousRubIds.EN_COURS;
			
			super.buildSousMenu();
		}
		
		override protected function onSwitchSousRub():void 
		{
			switch( _currentSousRub )
			{
				case SousRubIds.EN_COURS: loadXML( "actions_list_encours.xml" ); break;
				case SousRubIds.TERMINES: loadXML( "actions_list_termines.xml" ); break;
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}