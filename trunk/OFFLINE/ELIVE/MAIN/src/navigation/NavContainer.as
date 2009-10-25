
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package navigation
{
	import assets.GBackgroundMenu;
	import assets.icons.GIconAmis;
	import assets.icons.GIconElives;
	import assets.icons.GIconProfil;
	import aze.motion.Eaze;
	import elive.events.NavEvent;
	import elive.navigation.NavIds;
	import elive.navigation.NavManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import fr.minuit4.core.configuration.Config;
	import fr.minuit4.core.configuration.Configuration;
	import fr.minuit4.tools.carrousel.Item;
	
	public class NavContainer extends GBackgroundMenu
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _navManager:NavManager;
		private var _cnt:Sprite;
		
		private var _itemsById:Object;
		
		private var _selectedItem:NavItem;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function NavContainer() 
		{
			init();			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			Eaze.from( this, .25, { scaleX: .6, scaleY: .6, alpha: 0 } );
		}
		
		private function switchRubriqueHandler(e:NavEvent):void 
		{
			if ( _selectedItem )
				_selectedItem.deselect();
			
			_selectedItem = _itemsById[ e.navId ];
			if ( !_selectedItem ) return;
			
			_selectedItem.select();
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			var navItem:NavItem = e.target as NavItem;
			_navManager.switchRub( navItem.id );
		}
		
		private function mouseOverHandler(e:MouseEvent):void 
		{
			var navItem:NavItem = e.target as NavItem;
			if ( navItem == _selectedItem ) return;
			
			navItem.over();
		}
		
		private function mouseOutHandler(e:MouseEvent):void 
		{
			var navItem:NavItem = e.target as NavItem;
			if ( navItem == _selectedItem ) return;
			
			navItem.out();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_navManager = NavManager.getInstance();
			_navManager.addEventListener( NavEvent.SWITCH_RUBRIQUE, switchRubriqueHandler );
			
			_itemsById = { };
			
			_cnt = new Sprite();
			_cnt.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true );
			_cnt.addEventListener( MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true );
			_cnt.addEventListener( MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true );
			addChild( _cnt );
			
			_cnt.buttonMode = true;
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function createNav():void
		{
			var path:String = Config.getProperty( "pathRub" );
			
			var elivesItem:NavItem = new NavItem( NavIds.ELIVES, "Mes (e)lives", path + "/elives.swf" );
			elivesItem.setSkin( new GIconElives() );
			elivesItem.x = -40;
			elivesItem.y = 10;
			_cnt.addChild( elivesItem );
			
			var amisItem:NavItem = new NavItem( NavIds.AMIS, "Mes amis", path + "/amis.swf" );
			amisItem.setSkin( new GIconAmis() );
			amisItem.x = - 40;
			amisItem.y = - 50;
			_cnt.addChild( amisItem );
			
			var profilItem:NavItem = new NavItem( NavIds.PROFIL, "Mon profil", path + "/profil.swf" );
			profilItem.setSkin( new GIconProfil() );
			profilItem.x = 20;
			profilItem.y = -20;
			_cnt.addChild( profilItem );
			
			_itemsById[ NavIds.ELIVES ] = elivesItem;
			_itemsById[ NavIds.AMIS ] = amisItem;
			_itemsById[ NavIds.PROFIL ] = profilItem;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}