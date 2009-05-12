﻿
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
	import main.details.DetailsCtrl;
	import main.home.HomeCtrl;
	import main.menu.Menu;
	import main.projects.ProjectsCtrl;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _background:Background;
		private var _homeCtrl:HomeCtrl;
		private var _projectsCtrl:ProjectsCtrl;
		private var _detailsCtrl:DetailsCtrl;
		
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
			Config.path_css = path_css;
			
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
			
			initSWFAddress();
			
			menu.init();
			menu.addEventListener( Event.CHANGE, onRubriqueChange );
			
			_homeCtrl = new HomeCtrl();
			_homeCtrl.addEventListener( ProjectEvent.PROJECT_SELECT, onProjectSelect );
			_homeCtrl.addEventListener( Event.COMPLETE, onSwitchSectionComplete );
			
			_projectsCtrl = new ProjectsCtrl();
			_projectsCtrl.addEventListener( ProjectEvent.PROJECT_SELECT, onProjectSelect );
			_projectsCtrl.addEventListener( Event.COMPLETE, onSwitchSectionComplete );
			
			_detailsCtrl = new DetailsCtrl();
			_detailsCtrl.addEventListener( Event.COMPLETE, onSwitchSectionComplete );
			
			stage.addEventListener( Event.RESIZE, onResize );
			onResize( null );
			
			if ( Config.DEBUG )
			{
				var fps:FPS = new FPS();
				fps.x = 170;
				addChild( fps );
			}
		}
		
		private function onProjectSelect(e:ProjectEvent):void 
		{
			Config.tempSection = formatText( e.section ) + "/" + e.index + "/";
			onRubriqueChange( null );
		}
		
		private function onRubriqueChange(e:Event):void 
		{
			switch( Config.currentSection )
			{
				case Config.HOME: _homeCtrl.deactivate(); break;
				case Config.WORKS: _projectsCtrl.deactivate(); break;
				case Config.LAB: _projectsCtrl.deactivate(); break;
				case Config.ABOUT: ; break;
				case Config.DETAILS: _detailsCtrl.deactivate(); break;
			}
		}
		
		private function onSwitchSectionComplete(e:Event):void 
		{
			trace( Config.tempSection );
			SWFAddress.setValue( Config.tempSection );
		}
		
		private function onSWFAdressMenuItemSelect(e:ContextMenuEvent):void 
		{
			Config.tempSection = formatText( e.currentTarget.caption );
			onRubriqueChange( null );
		}
		
		private function onSWFAdressChange(e:SWFAddressEvent):void 
		{
			var a:Array = [];
			var n:int = e.pathNames.length;
			for ( var i:int; i < n; ++i )
				a.push( e.pathNames[ i ].toLowerCase() );
			
			n = a.length;
			if ( !n || n > 2 )
			{
				SWFAddress.setValue( formatText( Config.HOME ) + "/" );				
				return;
			}			
			else if ( n == 1 )
			{
				if ( a[ 0 ] == Config.currentSection || !isRubrique( a[ 0 ] ) ) 
				{
					SWFAddress.setValue( formatText( Config.HOME ) + "/" );	
					return;
				}
				
				Config.currentSection = a[ 0 ];
			}
			else if ( n == 2 )
			{
				if ( !isRubrique( a[ 0 ] ) ) 
				{
					SWFAddress.setValue( formatText( Config.HOME ) + "/" );	
					return;
				}
				
				var datas:Array = a[ 0 ] == Config.WORKS ? Config.worksDatas : Config.labDatas;
				if ( a[ i ] < 0 || a[ i ] > datas.length ) 
				{
					SWFAddress.setValue( formatText( Config.HOME ) + "/" );	
					return;
				}
				
				Config.detailsSection = a[ 0 ];
				Config.detailsId = a[ 1 ];
				Config.currentSection = Config.DETAILS;
				a.pop();
			}
			
			switchRubrique();
			
			_title = "Floz - Flash Developer";
			
			n = a.length;
			if ( n > 0 ) _title += " - ";
			for ( i = 0; i < n; ++i )
			{
				_title += formatText( a[ i ] );
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
			
			var n:int = Config.RUBRIQUES.length - 1;
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
				if ( Config.RUBRIQUES[ i ] == rubriqueName.toLowerCase() || Config.DETAILS == rubriqueName.toLowerCase() ) return true;
			
			return false;
		}
		
		private function switchRubrique():void
		{
			menu.update();
			
			switch( Config.currentSection )
			{
				case Config.HOME: title.update( "The last updates" ); _homeCtrl.activate(); break;
				case Config.WORKS: title.update( "Projects List" ); _projectsCtrl.activate(); break;
				case Config.LAB: title.update( "Laboratory projects List" ); _projectsCtrl.activate(); break;
				case Config.ABOUT: title.update( "More informations" ); break;
				case Config.DETAILS: title.update( "TEMPTEMPTEMP" ); _detailsCtrl.activate( Config.detailsSection, Config.detailsId ); break;
			}
		}
		
		private function formatText( txt:String ):String
		{
			return txt.substr( 0, 1 ).toUpperCase() + txt.substr( 1 ).toLowerCase();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get path_xml():String { return loaderInfo.parameters[ "path_xml" ] || "assets/xml/"; }
		public function get path_swf():String { return loaderInfo.parameters[ "path_swf" ] || "assets/swf/"; }
		public function get path_css():String { return loaderInfo.parameters[ "path_swf" ] || "assets/css/"; }
		
	}
	
}