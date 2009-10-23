
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.list 
{
	import assets.GOngletDroit;
	import assets.GOngletGauche;
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
		
		private var _ongletGauche:GOngletGauche;
		private var _ongletDroit:GOngletDroit;
		
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
			_ongletDroit = new GOngletDroit();
			_ongletDroit.buttonMode = true;
			_ongletDroit.mouseChildren = false;
			_ongletDroit.y = -1;
			addChild( _ongletDroit );
			
			EliveUtils.configureText( _ongletDroit.tf, "elives_menu_bt", "GROUPES" );
			
			_selectedOnglet = _ongletGauche = new GOngletGauche();
			_ongletGauche.buttonMode = true;
			_ongletGauche.mouseChildren = false;
			addChild( _ongletGauche );
			
			EliveUtils.configureText( _ongletGauche.tf, "elives_menu_bt", "AMIS" );
			
			switchState();
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function switchState():void
		{
			var navEvent:NavEvent = new NavEvent( NavEvent.SWITCH_SOUS_RUBRIQUE );
			if ( _selectedOnglet == _ongletDroit )
			{
				_ongletDroit.bg.transform.colorTransform = EliveUtils.getColorTransform( 0xffffff );
				_ongletGauche.bg.transform.colorTransform = EliveUtils.getColorTransform( 0xC7C8C9 );
				_ongletDroit.y = 0;
				addChild( _ongletDroit );
				
				_ongletGauche.y = -1;
				
				navEvent.navId = SousRubIds.GROUPES;
			}
			else 
			{
				_ongletDroit.bg.transform.colorTransform = EliveUtils.getColorTransform( 0xC7C8C9 );
				_ongletGauche.bg.transform.colorTransform = EliveUtils.getColorTransform( 0xffffff );
				_ongletGauche.y = 0;
				addChild( _ongletGauche );
				
				_ongletDroit.y = -1;
				
				navEvent.navId = SousRubIds.AMIS;				
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