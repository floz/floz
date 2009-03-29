
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Puce extends MovieClip
	{
		// - CONSTS ----------------------------------------------------------------------
		
		public static const TOOLTIP_SHOW:String = "tooltip_show";
		public static const TOOLTIP_HIDE:String = "tooltip_hide";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _infos:Object;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Puce( enable:Boolean = true ) 
		{
			if ( !enable ) return;
			this.addEventListener( MouseEvent.ROLL_OVER, onOver );
			this.addEventListener( MouseEvent.ROLL_OUT, onOut );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			if ( this == Model.currentPuce && Model.mainTooltipVisible ) return;
			dispatchEvent( new Event( TOOLTIP_SHOW, true ) );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			dispatchEvent( new Event( TOOLTIP_HIDE, true ) );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setInfos( infos:Object ):void
		{
			_infos = infos;
		}
		
		public function getInfos():Object { return _infos; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}