
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.sheet.sheets.elives 
{
	import assets.GOngletDroit;
	import assets.GOngletDroiteSmall;
	import assets.GOngletGauche;
	import assets.GOngletGaucheSmall;
	import elive.events.NavEvent;
	import elive.utils.EliveUtils;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.core.interfaces.IDisposable;
	
	public class Menu extends Sprite implements IDisposable
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _ongletGauche:GOngletGaucheSmall;
		private var _ongletDroit:GOngletDroiteSmall;
		
		private var _selectedOnglet:Sprite;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Le menu du haut (les deux onglets nuageux).
		 */
		public function Menu() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			_ongletGauche.removeEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
			_ongletDroit.removeEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
			
			_ongletGauche.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true );
			_ongletDroit.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true );
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			if ( e.currentTarget == _selectedOnglet )
				return;
			
			_selectedOnglet = e.currentTarget as Sprite;
			switchState();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{			
			_ongletDroit = new GOngletDroiteSmall();
			_ongletDroit.buttonMode = true;
			_ongletDroit.mouseChildren = false;
			addChild( _ongletDroit );
			
			EliveUtils.configureText( _ongletDroit.tf, "elives_menu_bt", "ENVOYÉS" );
			
			_selectedOnglet = _ongletGauche = new GOngletGaucheSmall();
			_ongletGauche.buttonMode = true;
			_ongletGauche.mouseChildren = false;
			addChild( _ongletGauche );
			
			EliveUtils.configureText( _ongletGauche.tf, "elives_menu_bt", "REÇUS" );
			
			switchState();
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function switchState():void
		{
			var navEvent:NavEvent = new NavEvent( NavEvent.SWITCH_SOUS_RUBRIQUE );
			if ( _selectedOnglet == _ongletDroit )
			{
				_ongletDroit.bg.transform.colorTransform = EliveUtils.getColorTransform( 0x70C5CD );
				_ongletGauche.bg.transform.colorTransform = EliveUtils.getColorTransform( 0xB3B3B3 );
				_ongletDroit.y = 0;
				addChild( _ongletDroit );				
				
				navEvent.navId = SousRubIds.ENVOYES;
			}
			else 
			{
				_ongletDroit.bg.transform.colorTransform = EliveUtils.getColorTransform( 0xB3B3B3 );
				_ongletGauche.bg.transform.colorTransform = EliveUtils.getColorTransform( 0x70C5CD );
				_ongletGauche.y = 0;
				addChild( _ongletGauche );
				
				navEvent.navId = SousRubIds.RECUS;
			}
			dispatchEvent( navEvent );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function dispose():void
		{
			_ongletDroit = null;
			_ongletGauche = null;
			_selectedOnglet = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}