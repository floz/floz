
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.ui 
{
	import assets.GButton;
	import elive.utils.EliveUtils;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	
	public class EliveButton extends GButton
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function EliveButton() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			removeEventListener( MouseEvent.ROLL_OVER, rollOverHandler );
			removeEventListener( MouseEvent.ROLL_OUT, rollOutHandler );
			
			bg = null;
			tf = null;
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
			
			addEventListener( MouseEvent.ROLL_OVER, rollOverHandler, false, 0, true );
			addEventListener( MouseEvent.ROLL_OUT, rollOutHandler, false, 0, true );
		}
		
		private function rollOverHandler(e:MouseEvent):void 
		{
			bg.gotoAndStop( "over" );
		}
		
		private function rollOutHandler(e:MouseEvent):void 
		{
			bg.gotoAndStop( "out" );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			tf.autoSize = TextFieldAutoSize.LEFT;
			
			this.buttonMode = true;
			this.mouseChildren = false;
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function resize():void
		{
			bg.width = tf.textWidth + 10;
			tf.width = tf.textWidth;
			tf.x = bg.width * .5 - tf.textWidth * .5;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setText( text:String ):void
		{
			EliveUtils.configureText( tf, "button", text );
			resize();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}