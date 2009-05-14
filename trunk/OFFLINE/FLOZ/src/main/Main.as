
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
	import fr.minuit4.animation.Loading;
	import fr.minuit4.utils.debug.FPS;
	import main.about.AboutCtrl;
	import main.details.DetailsCtrl;
	import main.home.HomeCtrl;
	import main.menu.Menu;
	import main.projects.ProjectsCtrl;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _loading:Loading;
		
		private var _ready:Boolean;
		private var _background:Background;
		private var _homeCtrl:HomeCtrl;
		private var _projectsCtrl:ProjectsCtrl;
		private var _detailsCtrl:DetailsCtrl;
		private var _aboutCtrl:AboutCtrl;
		
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
			
			_loading = new Loading();
			cntBackground.addChild( _loading );
			_loading.x = stage.stageWidth * .5 - _loading.width * .5 + 15;
			_loading.y = stage.stageHeight * .5 - _loading.height * .5 + 15;
			_loading.play();
			
			logo.visible = false;
			
			stage.addEventListener( Event.RESIZE, onResize );
			
			var preloader:Preloader = new Preloader();
			preloader.addEventListener( Event.COMPLETE, init );
			preloader.init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function init(e:Event):void 
		{
			_ready = true;
			
			Config.cntMain = cntMain;
			
			_loading.stop();
			cntBackground.removeChild( _loading );
			_loading = null;
			
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
			_detailsCtrl.addEventListener( ProjectEvent.PROJECT_SELECT, onProjectSelectDirect );
			_detailsCtrl.addEventListener( Event.COMPLETE, onSwitchSectionComplete );
			
			_aboutCtrl = new AboutCtrl();
			_aboutCtrl.addEventListener( Event.COMPLETE, onSwitchSectionComplete );
			
			onResize( null );
			
			if ( Config.DEBUG )
			{
				var fps:FPS = new FPS();
				fps.x = 170;
				addChild( fps );
			}
		}
		
		private function onProjectSelectDirect(e:ProjectEvent):void 
		{
			SWFAddress.setValue( formatText( e.section ) + "/" + e.index + "/" );
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
				case Config.ABOUT: _aboutCtrl.deactivate(); break;
				case Config.DETAILS: _detailsCtrl.deactivate(); break;
			}
		}
		
		private function onSwitchSectionComplete(e:Event):void 
		{
			SWFAddress.setValue( Config.tempSection );
		}
		
		private function onSWFAdressMenuItemSelect(e:ContextMenuEvent):void 
		{
			if ( e.currentTarget.caption.toLowerCase() == Config.currentSection ) return;
			
			Config.tempSection = formatText( e.currentTarget.caption );
			onRubriqueChange( null );
		}
		
		private function onSWFAdressChange(e:SWFAddressEvent):void 
		{
			trace( "Main.onSWFAdressChange > e : " + e );
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
				if ( a[ 0 ] == Config.currentSection || !isRubrique( a[ 0 ] ) || a[ 0 ] == Config.DETAILS ) 
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
				if ( a[ 1 ] < 0 || a[ 1 ] >= datas.length ) 
				{
					SWFAddress.setValue( formatText( Config.HOME ) + "/" );	
					return;
				}
				
				Config.detailsSection = a[ 0 ];
				Config.detailsId = a[ 1 ];
				Config.currentSection = Config.DETAILS;
				Config.detailsTitle = a[ 0 ].toLowerCase() == Config.WORKS ? Config.worksDatas[ a[ 1 ] ].title : Config.labDatas[ a[ 1 ] ].title;
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
			if ( !_ready )
			{
				_loading.x = stage.stageWidth * .5 - _loading.width * .5 + 15;
				_loading.y = stage.stageHeight * .5 - _loading.height * .5 + 15;
				return;
			}
			
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
				if ( Config.RUBRIQUES[ i ] == rubriqueName.toLowerCase() || Config.DETAILS == rubriqueName.toLowerCase() ) return true;
			
			return false;
		}
		
		private function switchRubrique():void
		{
			menu.update();
			
			switch( Config.currentSection )
			{
				case Config.HOME: title.update( "Last updates" ); _homeCtrl.activate(); break;
				case Config.WORKS: title.update( "Projects List" ); _projectsCtrl.activate(); break;
				case Config.LAB: title.update( "Laboratory projects List" ); _projectsCtrl.activate(); break;
				case Config.ABOUT: title.update( "More informations" ); _aboutCtrl.activate(); break;
				case Config.DETAILS: title.update( Config.detailsTitle ); _detailsCtrl.activate( Config.detailsSection, Config.detailsId ); break;
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