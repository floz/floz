
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.navigation 
{
	import assets.icons.GIconAmis;
	import assets.icons.GIconElives;
	import assets.icons.GIconProfil;
	import elive.events.NavEvent;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import fr.minuit4.core.configuration.Config;
	import fr.minuit4.core.configuration.Configuration;
	import fr.minuit4.tools.carrousel.Item;
	
	public class NavContainer extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _navManager:NavManager;
		private var _cnt:Sprite;
		
		private var _itemsById:Object;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function NavContainer() 
		{
			init();			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function switchRubriqueHandler(e:NavEvent):void 
		{
			trace( "2:TODO: NavContainer.switchRubriqueHandler > Changer l'état des boutons du menu." );
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			var navItem:NavItem = e.target as NavItem;
			_navManager.switchRub( navItem.id );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_navManager = NavManager.getInstance();
			_navManager.addEventListener( NavEvent.SWITCH_RUBRIQUE, switchRubriqueHandler );
			
			_itemsById = { };
			
			_cnt = new Sprite();
			_cnt.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true );
			addChild( _cnt );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function createNav():void
		{
			var path:String = Config.getProperty( "pathRub" );
			
			var elivesItem:NavItem = new NavItem( NavIds.ELIVES, "Mes (e)lives", path + "/elives.swf" );
			elivesItem.setSkin( new GIconElives() );
			_cnt.addChild( elivesItem );
			
			var amisItem:NavItem = new NavItem( NavIds.AMIS, "Mes amis", path + "/amis.swf" );
			amisItem.setSkin( new GIconAmis() );
			amisItem.x = 70;
			_cnt.addChild( amisItem );
			
			var profilItem:NavItem = new NavItem( NavIds.PROFIL, "Mon profil", path + "/profil.swf" );
			profilItem.setSkin( new GIconProfil() );
			profilItem.x = 140;
			_cnt.addChild( profilItem );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}