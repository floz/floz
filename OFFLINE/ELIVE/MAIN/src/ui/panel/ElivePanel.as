
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package ui.panel
{
	import assets.GBackground;
	import assets.GTooltip;
	import aze.motion.easing.Quadratic;
	import aze.motion.Eaze;
	import elive.navigation.HistoricManager;
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
		private var _historicManager:HistoricManager;
		
		private var _navId:String;
		private var _sectionId:int;
		private var _id:int;
		private var _assetsLoader:AssetsLoader;
		
		private var _panelHeader:PanelHeader
		
		private var _tooltipField:TextField;		
		private var _tooltip:GTooltip;	
		
		private var _rub:IRubrique;
		
		private var _tweening:Boolean;
		
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
			
			Eaze.killTweensOf( _tooltip );
			Eaze.killTweensOf( this );
			Eaze.killTweensOf( btClose );
			Eaze.killTweensOf( btClose.croix );
			
			btClose.removeEventListener( MouseEvent.MOUSE_DOWN, btCloseDownHandler );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
			
			_tooltip.y = 100;
			_tooltip.alpha = 0;
			Eaze.delay( .4 ).chainTo( _tooltip, .1, { alpha: .4 } ).chainTo( _tooltip, .35, { y: 45, alpha: 1 } );
			
			_panelHeader.makeAppear();
			
			this.alpha = .4;
			Eaze.to( this, .5, { alpha: 1 } );
			Eaze.from( btClose, .25, { scaleX: 0, scaleY: 0 } ).chainFrom( btClose, .35, { rotation: 360 } );
			
			_navManager.setEnable( true );
			
			btClose.addEventListener( MouseEvent.MOUSE_DOWN, btCloseDownHandler, false, 0, true );
			btClose.addEventListener( MouseEvent.ROLL_OVER, btCloseRollOverHandler, false, 0, true );
			btClose.addEventListener( MouseEvent.ROLL_OUT, btCloseRollOutHandler, false, 0, true );
		}
		
		private function btCloseDownHandler(e:MouseEvent):void 
		{		
			_navManager.setEnable( false );
			_panelHeader.makeDisappear();
			
			Eaze.to( _tooltip, .6, { y: 100, alpha: 0 } );
			Eaze.to( this, .5, { alpha: 0 } ).onComplete( onBtCloseDown );			
		}
		
		private function rubLoadedHandler(e:Event):void 
		{
			_rub = _assetsLoader.getItemLoaded();
			_rub.navigateTo( _sectionId, _id );
			
			if ( cntContent.numChildren )
			{
				var display:DisplayObject = cntContent.getChildAt( 0 );
				Eaze.to( display, .5, { alpha: 0 } ).onComplete( cleanCnt, display );
			}
			
			DisplayObject( _rub ).alpha = 0;
			Eaze.delay( .25 ).chainTo( _rub, .25, { alpha: 1 } ).onComplete( _navManager.setEnable, true );
			cntContent.addChild( _rub as DisplayObject );
			
			cntTooltip.addChild( _tooltip );
			
			_assetsLoader.removeEventListener( Event.COMPLETE, rubLoadedHandler );
			_assetsLoader.dispose();
			_assetsLoader = null;
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			if ( !_navManager.isEnabled() ) e.stopImmediatePropagation();
		}
		
		private function btCloseRollOverHandler(e:MouseEvent):void 
		{
			Eaze.to( btClose, .25, { scaleX: 1.35, scaleY: 1.35 } ).chainTo( btClose, .15, { scaleX: 1.25, scaleY: 1.25 } );
			Eaze.to( btClose.croix, .25, { rotation: 180 } );
		}
		
		private function btCloseRollOutHandler(e:MouseEvent):void 
		{
			Eaze.to( btClose, .25, { scaleX: 1, scaleY: 1 } );
			Eaze.to( btClose.croix, .25, { rotation: 0 } );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_navManager = NavManager.getInstance();
			_historicManager = HistoricManager.getInstance();
			createHeader();
			createTooltip();
			
			btClose.buttonMode = true;
			
			cntContent.y = 75;			
			cntContent.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, true );
		}
		
		private function createHeader():void
		{
			_panelHeader = new PanelHeader();
			cntHead.addChild( _panelHeader );
		}
		
		private function createTooltip():void
		{
			_tooltip = new GTooltip();
			_tooltip.x = this.width * .5 - _tooltip.width * .5;
			_tooltip.y = 45;
			
			EliveUtils.configureText( _tooltip.tf, "elive_panel_tooltip", "Mes (e)buddies" );
		}
		
		private function cleanCnt( display:DisplayObject ):void
		{
			cntContent.removeChild( display );
		}
		
		private function setTweening( value:Boolean ):void
		{
			_tweening = value;
		}
		
		private function onBtCloseDown():void
		{
			_navManager.setEnable( true );
			_navManager.switchRub( NavIds.HOME );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function loadRub( navId:String, sectionId:int, id:int ):void
		{
			this._navId = navId;
			this._sectionId = sectionId;
			this._id = id;
			
			setTooltipText( navId );
			_navManager.setEnable( false );
			
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
				case NavIds.EMAKE: text = "(e)Make"; break;
				default: text = "Minuit4"; break;
			}
			EliveUtils.configureText( _tooltip.tf, "elive_panel_tooltip", text );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}