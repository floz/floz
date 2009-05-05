
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.system.Security;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import fr.minuit4.utils.debug.FPS;
	import main.home.HomeCtrl;
	import main.menu.Menu;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _background:Background;
		private var _homeCtrl:HomeCtrl;
		
		private var _title:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var logo:Sprite;
		public var title:Title;
		public var menu:Menu;
		public var cntMain:Sprite;
		public var cntBackground:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			Security.allowDomain( "floz.fr" );
			Security.allowInsecureDomain( "floz.fr" );
			
			Config.path_swf = path_swf;
			Config.path_xml = path_xml;
			
			logo.visible = false;
			
			var preloader:Preloader = new Preloader();
			preloader.addEventListener( Event.COMPLETE, init );
			preloader.init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function init(e:Event):void 
		{
			Config.cntMain = cntMain;
			
			_background = new Background();
			cntBackground.addChild( _background );
			
			logo.visible = true;
			menu.init();			
			initSWFAddress();
			
			_homeCtrl = new HomeCtrl();
			
			stage.addEventListener( Event.RESIZE, onResize );
			onResize( null );
			
			if ( Config.DEBUG )
			{
				var fps:FPS = new FPS();
				fps.x = 170;
				addChild( fps );
			}
		}
		
		private function onSWFAdressMenuItemSelect(e:ContextMenuEvent):void 
		{
			SWFAddress.setValue( e.currentTarget.caption.substr( 0, 1 ).toUpperCase() + e.currentTarget.caption.substr( 1 ).toLowerCase() );
		}
		
		private function onSWFAdressChange(e:SWFAddressEvent):void 
		{
			var currentValue:String = e.value.substr( 1 ).toLowerCase();
			currentValue = currentValue == "" ? Config.HOME : currentValue;
			if ( currentValue == Config.currentSection || !isRubrique( currentValue ) )
			{
				if ( !isRubrique( currentValue ) && Config.currentSection != Config.HOME )
					SWFAddress.setValue( Config.HOME.substr( 0, 1 ).toUpperCase() + Config.HOME.substr( 1 ).toLowerCase() );
				
				return;
			}
			
			Config.oldSection = Config.currentSection;
			Config.currentSection = currentValue;		
			switchRubrique();
			
			_title = "Floz - Flash Developer";
			
			var n:int = e.pathNames.length;
			if ( n > 0 ) _title += " - ";
			for ( var i:int; i < n; ++i )
			{
				_title += e.pathNames[ i ].substr( 0, 1 ).toUpperCase() + e.pathNames[ i ].substr( 1 ).toLowerCase();
				if ( i < int( n - 1 ) ) _title += " - ";
			}
			SWFAddress.setTitle( _title );
		}
		
		private function onResize(e:Event):void 
		{
			var px:Number = stage.stageWidth * .5 - 980 * .5;
			var py:Number = stage.stageHeight * .5 - 560 * .5;
			
			cntMain.x = px + 8;
			cntMain.y = py + 120;
			
			title.x = px + 970;
			title.y = py + 58;
			
			menu.x = px + 445;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initSWFAddress():void
		{
			var ctMenu:ContextMenu = new ContextMenu();
			ctMenu.hideBuiltInItems();			
			
			var n:int = Config.RUBRIQUES.length;
			for ( var i:int; i < n; ++i )
				ctMenu.customItems.push( new ContextMenuItem( Config.RUBRIQUES[ i ].toUpperCase() ) );
			
			this.contextMenu = ctMenu;
			
			n = ctMenu.customItems.length;
			for ( i = 0; i < n; ++i )
				ctMenu.customItems[ i ].addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, onSWFAdressMenuItemSelect );
			
			SWFAddress.addEventListener( SWFAddressEvent.CHANGE, onSWFAdressChange );
		}
		
		private function isRubrique( rubriqueName:String ):Boolean
		{
			var i:int = Config.RUBRIQUES.length;
			while ( --i > -1 )
				if ( Config.RUBRIQUES[ i ] == rubriqueName ) return true;
			
			return false;
		}
		
		private function switchRubrique():void
		{
			menu.update();
			
			switch( Config.oldSection )
			{
				case Config.HOME: _homeCtrl.deactivate(); break;
				case Config.WORKS: break;
				case Config.LAB: break;
				case Config.ABOUT: break;
			}
			
			switch( Config.currentSection )
			{
				case Config.HOME: title.update( "The last updates" ); _homeCtrl.activate(); break;
				case Config.WORKS: title.update( "Projects List" ); break;
				case Config.LAB: title.update( "Laboratory projects List" ); break;
				case Config.ABOUT: title.update( "More informations" ); break;
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get path_xml():String { return loaderInfo.parameters[ "path_xml" ] || "assets/xml/"; }
		public function get path_swf():String { return loaderInfo.parameters[ "path_swf" ] || "assets/swf/"; }
		
	}
	
}