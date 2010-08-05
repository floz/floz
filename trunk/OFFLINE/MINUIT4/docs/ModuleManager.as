
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package core.modules 
{
	import core.nav.NavEvent;
	import core.nav.NavManager;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	public class ModuleManager extends Module
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _modulesClasses:Dictionary = new Dictionary();
		
		private var _navManager:NavManager;
		
		private var _cnt:Sprite;
		private var _currentModule:Module;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ModuleManager( navManager:NavManager, modules:/*ModuleInfo*/Array = null ) 
		{
			_navManager = navManager;
			_navManager.addEventListener( NavEvent.NAV_CHANGE, navChangeHandler, false, 0, true );
			
			initContent();
			
			if( modules )
				addModules( modules );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function navChangeHandler(e:NavEvent):void 
		{
			onNavChange();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initContent():void
		{
			_cnt = new Sprite();
			addChild( _cnt );
		}
		
		private function onNavChange():void
		{
			if ( _navManager.frozen )
				return;
			
			_navManager.frozen = true;
			
			if ( _currentModule )
			{
				var d:Number = _currentModule.hide();
				setTimeout( showNewModule, d * 1000 );
			}
			else showNewModule();
		}
		
		private function showNewModule( delay:Number = 0 ):Number
		{
			if ( _currentModule )
			{
				_currentModule.dispose();
				_cnt.removeChild( _currentModule );
				_currentModule = null;
			}
			
			if ( _modulesClasses[ _navManager.currentId ] )
				_currentModule = new _modulesClasses[ _navManager.currentId ];
			else
				return 0;
			
			_currentModule.data = _data.module.( @id == _navManager.currentId )[ 0 ];
			_cnt.addChild( _currentModule );
			
			var d:Number = _currentModule.show( delay );
			setTimeout( onModuleShow, d * 1000 );
			
			return d;
		}
		
		private function onModuleShow():void
		{
			_navManager.unfreeze();
			_currentModule.execute();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addModule( module:ModuleInfo ):void
		{
			_modulesClasses[ module.id ] = module.c;
		}
		
		public function addModules( modules:/*ModuleInfo*/Array ):void
		{
			var n:int = modules.length;
			for ( var i:int; i < n; ++i )
				addModule( modules[ i ] );
		}
		
		public function update():void
		{
			onNavChange();
		}
		
		override public function show( delay:Number = 0 ):Number
		{
			var d:Number = showNewModule( delay );
			return d;
		}
		
		override public function hide( delay:Number = 0 ):Number
		{
			if ( _currentModule )
			{
				_navManager.frozen = true;
				
				var d:Number = _currentModule.hide( delay );
				return d;
			}
			return 0;
		}
		
		override public function dispose():void 
		{
			_navManager.removeEventListener( NavEvent.NAV_CHANGE, navChangeHandler );
			_navManager = null;
			
			_modulesClasses = null;
			
			while ( _cnt.numChildren ) _cnt.removeChildAt( 0 );
			_cnt = null;
			
			if ( _currentModule )
				_currentModule.dispose();
			_currentModule = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}