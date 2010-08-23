
/**
 * @author Floz
 */
package test_modules 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import fr.minuit4.core.navigation.modules.managers.BasicModuleManager;
	import fr.minuit4.core.navigation.modules.ModuleInfo;
	import fr.minuit4.core.navigation.nav.NavManager;
	import fr.minuit4.display.ui.buttons.M4Button;

	public class TestBasicModuleManager extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _items:/*ModuleInfo*/Array = [ new ModuleInfo( "ITEM1", Module1 ), new ModuleInfo( "ITEM2", Module2 ) ];
		private var _navManager:NavManager;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TestBasicModuleManager() 
		{
			_navManager = new NavManager();
			for each( var m:ModuleInfo in _items )
				_navManager.createNode( m.id );
			
			_navManager.activate( "ITEM1" );
			
			//var moduleManager:BasicModuleManager = new BasicModuleManager( _navManager );
			//moduleManager.addModule( "ITEM1", Module1 );
			//moduleManager.addModule( "ITEM2", Module2 );
			var moduleManager:BasicModuleManager = new BasicModuleManager( _navManager, _items );
			moduleManager.x = 10;
			moduleManager.y = 60;
			addChild( moduleManager );
			
			//_navManager.activate( "ITEM1" );
			
			initMenu();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function clickHandler(e:MouseEvent):void 
		{
			var m4b:M4Button = e.currentTarget as M4Button;
			_navManager.activate( m4b.label );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initMenu():void
		{
			var menu:Sprite = new Sprite();
			menu.x = 10;
			menu.y = 10;
			addChild( menu );
			
			var px:Number = 0;
			var n:int = _items.length;
			for ( var i:int; i < n; ++i )
			{
				var m4b:M4Button = new M4Button( _items[ i ].id );
				m4b.addEventListener( MouseEvent.CLICK, clickHandler, false, 0, true );
				m4b.x = px;
				menu.addChild( m4b );
				
				px += m4b.width + 10;
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}

}