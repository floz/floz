﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package ui.panel
{
	import assets.fonts.FAkkuratBold;
	import assets.GBackground;
	import assets.GTooltip;
	import elive.navigation.NavIds;
	import elive.navigation.NavManager;
	import elive.rubriques.Rubrique;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import fr.minuit4.core.configuration.Config;
	import fr.minuit4.motion.easing.Quad;
	import fr.minuit4.motion.M4Tween;
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
		
		private var _tooltip:GTooltip;
		
		private var _rub:Rubrique;
		
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
			
			btClose.removeEventListener( MouseEvent.MOUSE_DOWN, btCloseDownHandler );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
			
			_tooltip.alpha = .8;
			_tooltip.y = 100;
			M4Tween.to( _tooltip, .2, { y: 45, alpha: 1, ease: Quad.easeOut } );
			
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
			cntContent.addChild( _rub );
			
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
			_tooltip.y = 100;
			addChild( _tooltip );
			
			var format:TextFormat = new TextFormat( new FAkkuratBold().fontName );
			_tooltip.tf.embedFonts = true;
			_tooltip.tf.defaultTextFormat = format;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function loadRub( navId:String, sectionId:int, id:int ):void
		{
			this._navId = navId;
			this._sectionId = sectionId;
			this._id = id;
			
			setTooltipText( navId );
			
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
			_tooltip.tf.text = text;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}