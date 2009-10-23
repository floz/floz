
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elives.sections.sheet 
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
		
		public static var STATUS:String;
		
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
			
			var color:uint;
			if ( STATUS == ChallengeStatus.ENDED_WON )
				color = 0xF9B73D;
			else if ( STATUS == ChallengeStatus.ENDED_LOST || STATUS == ChallengeStatus.ENDED_REFUSED )
				color = 0x97579A;
			
			apercuTop.bg.transform.colorTransform = EliveUtils.getColorTransform( color );
			
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