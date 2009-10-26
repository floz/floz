
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.sheet.sheets.elives 
{
	
	final public class ListRecus extends List
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ListRecus() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function buildSousMenu():void 
		{
			_sousMenu.addItem( "En cours", SousRubIds.EN_COURS, "elives_sousmenu_bt_over_encours" );
			_sousMenu.addItem( "En attente", SousRubIds.EN_ATTENTE, "elives_sousmenu_bt_over_enattente" );
			_sousMenu.addItem( "Terminés", SousRubIds.TERMINES, "elives_sousmenu_bt_over_termines" );
			_sousMenu.setBackgroundAlpha( .3 );
			
			_currentSousRub = SousRubIds.EN_COURS;
			
			super.buildSousMenu();
		}
		
		override protected function onSwitchSousRub():void 
		{
			switch( _currentSousRub )
			{
				case SousRubIds.EN_COURS: loadXML( "actions_list_encours_2.xml" ); break;
				case SousRubIds.EN_ATTENTE: loadXML( "actions_list_attente_2.xml" ); break;
				case SousRubIds.TERMINES: loadXML( "actions_list_termines_2.xml" ); break;
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}