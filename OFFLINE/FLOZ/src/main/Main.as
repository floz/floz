
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
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _background:Background;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var logo:Sprite;
		public var cnt:Sprite;
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
			_background = new Background();
			cntBackground.addChild( _background );
			
			initSWFAdress();
			
			logo.visible = true;
		}
		
		private function onSWFAdressMenuItemSelect(e:ContextMenuEvent):void 
		{
			SWFAddress.setValue( "/" + e.currentTarget.caption + "/" );
		}
		
		private function onSWFAdressChange(e:SWFAddressEvent):void 
		{
			trace( "Main.onSWFAdressChange > e : " + e.value.toLowerCase() );
			trace( "base : " + SWFAddress.getBaseURL() );
			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initSWFAdress():void
		{
			var ctMenu:ContextMenu = new ContextMenu();
			ctMenu.hideBuiltInItems();
			
			ctMenu.customItems.push( new ContextMenuItem( Config.HOME.toUpperCase() ) );
			ctMenu.customItems.push( new ContextMenuItem( Config.WORKS.toUpperCase() ) );
			ctMenu.customItems.push( new ContextMenuItem( Config.LAB.toUpperCase() ) );
			ctMenu.customItems.push( new ContextMenuItem( Config.ABOUT.toUpperCase() ) );
			this.contextMenu = ctMenu;
			
			var n:int = ctMenu.customItems.length;
			for ( var i:int; i < n; ++i )
				ctMenu.customItems[ i ].addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, onSWFAdressMenuItemSelect );
			
			SWFAddress.addEventListener( SWFAddressEvent.CHANGE, onSWFAdressChange );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get path_xml():String { return loaderInfo.parameters[ "path_xml" ] || "assets/xml/"; }
		public function get path_swf():String { return loaderInfo.parameters[ "path_swf" ] || "assets/swf/"; }
		
	}
	
}