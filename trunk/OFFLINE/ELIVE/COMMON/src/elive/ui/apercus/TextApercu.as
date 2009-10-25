
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.ui.apercus
{
	import assets.GApercu;
	import elive.core.challenges.ChallengeStatus;
	import elive.utils.EliveUtils;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	
	public class TextApercu extends GApercu
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TextApercu() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			apercuBg = null;
			apercuOver = null;
			apercuTop = null;
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			removeChild( apercuOver );
			apercuBg.tf.autoSize = TextFieldAutoSize.LEFT;			
			apercuTop.bg.transform.colorTransform = EliveUtils.getColorTransform( 0xA10D59 );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setTitleText( text:String ):void
		{
			EliveUtils.configureText( apercuTop.tf, "elives_list_apercu_title", text );
		}
		
		public function setContentText( text:String ):void
		{
			EliveUtils.configureText( apercuBg.tf, "elives_list_apercu_content", text );
			apercuBg.bg.height = apercuBg.tf.textHeight + 10;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}