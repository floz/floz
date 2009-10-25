/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  elive.ui.sousmenu 
{
	import assets.GBtSousMenu;
	import aze.motion.Eaze;
	import elive.utils.EliveUtils;
	import flash.events.Event;
	import fr.minuit4.core.interfaces.IDisposable;
	import fr.minuit4.motion.M4Tween;
	
	public class SousMenuItem extends GBtSousMenu
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _overClass:String;
		private var _alphaMaxValue:Number = 1;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var title:String;
		public var sousRubId:String;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SousMenuItem( title:String, sousRubId:String, overClass:String ) 
		{
			this.title = title;
			this.sousRubId = sousRubId;
			this._overClass = overClass;
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			Eaze.killTweensOf( bg );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			EliveUtils.configureText( tf, "elives_menu_bt", this.title );
			
			bg.alpha = 0;			
			this.mouseChildren = false;
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function over():void
		{
			EliveUtils.configureText( tf, _overClass, this.title );
			
			bg.alpha = .6;
			Eaze.to( bg, .25, { alpha: _alphaMaxValue } );
		}
		
		public function out():void
		{
			EliveUtils.configureText( tf, "elives_menu_bt", this.title );
			
			bg.alpha = .4;
			Eaze.to( bg, .25, { alpha: 0 } );
		}
		
		public function setAlphaMax( value:Number ):void
		{
			this._alphaMaxValue = value;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}