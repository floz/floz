
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package ui.panel
{
	//import assets.fonts.FAkkuratBold;
	import assets.GBackground;
	import assets.GTooltip;
	import aze.motion.Eaze;
	import elive.navigation.NavIds;
	import elive.navigation.NavManager;
	import elive.rubriques.IRubrique;
	import elive.utils.EliveUtils;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import fr.minuit4.core.configuration.Config;
	import fr.minuit4.net.loaders.types.AssetsLoader;
	import ui.panel.header.PanelHeader;
	
	public class ElivePanel extends GBackground
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _navManager:NavManager;
		
		private var _navId:String;
		private var _sectionId:int;
		private var _id:int;
		private var _assetsLoader:AssetsLoader;
		
		private var _tooltipField:TextField;
		
		private var _tooltip:GTooltip;
		
		private var _rub:IRubrique;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ElivePanel() 
		{
			init();			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
			
			cntTooltip.removeChild( _tooltip );
			
			btClose.removeEventListener( MouseEvent.MOUSE_DOWN, btCloseDownHandler );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
			
			Eaze.from( _tooltip, .2, { y: 100, alpha: .8 } );
			
			btClose.addEventListener( MouseEvent.MOUSE_DOWN, btCloseDownHandler, false, 0, true );
		}
		
		private function btCloseDownHandler(e:MouseEvent):void 
		{
			_navManager.switchRub( NavIds.HOME );
		}
		
		private function rubLoadedHandler(e:Event):void 
		{
			_rub = _assetsLoader.getItemLoaded();
			_rub.navigateTo( 0 );
			cntContent.addChild( _rub as DisplayObject );
			
			Eaze.from( cntContent, .25, { alpha: .6 } );
			
			cntTooltip.addChild( _tooltip );
			
			_assetsLoader.removeEventListener( Event.COMPLETE, rubLoadedHandler );
			_assetsLoader.dispose();
			_assetsLoader = null;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_navManager = NavManager.getInstance();
			createHeader();
			createTooltip();
			
			cntContent.y = 75;
		}
		
		private function createHeader():void
		{
			var panelHeader:PanelHeader = new PanelHeader();
			cntHead.addChild( panelHeader );
		}
		
		private function createTooltip():void
		{
			_tooltip = new GTooltip();
			_tooltip.x = this.width * .5 - _tooltip.width * .5;
			_tooltip.y = 45;
			
			EliveUtils.configureText( _tooltip.tf, "elive_panel_tooltip", "Mes (e)buddies" );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function loadRub( navId:String, sectionId:int, id:int ):void
		{
			this._navId = navId;
			this._sectionId = sectionId;
			this._id = id;
			
			setTooltipText( navId );
			
			while ( cntContent.numChildren ) cntContent.removeChildAt( 0 );
			_rub = null;
			
			_assetsLoader = new AssetsLoader( Config.getProperty( "pathRub" ) + "/" + _navId + ".swf" );
			_assetsLoader.addEventListener( Event.COMPLETE, rubLoadedHandler, false, 0, true );
			_assetsLoader.load();
		}
		
		public function setTooltipText( navId:String ):void
		{
			var text:String;
			switch( navId )
			{
				case NavIds.ELIVES: text = "Mes (e)lives"; break;
				case NavIds.AMIS: text = "Mes (e)buddies"; break;
				case NavIds.PROFIL: text = "Mon profil"; break;
				default: text = "Minuit4"; break;
			}
			EliveUtils.configureText( _tooltip.tf, "elive_panel_tooltip", text );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}