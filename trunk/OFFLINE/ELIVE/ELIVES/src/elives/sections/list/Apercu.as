/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elives.sections.list 
{
	import assets.GApercu;
	import elive.core.challenges.Challenge;
	import elive.core.challenges.ChallengeStatus;
	import elive.utils.EliveUtils;
	import flash.events.Event;
	import flash.text.TextField;
	import fr.minuit4.core.configuration.Config;
	import fr.minuit4.core.configuration.Configuration;
	import fr.minuit4.motion.M4Tween;
	
	public class Apercu extends GApercu
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _challenge:Challenge;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Apercu( challenge:Challenge ) 
		{
			this._challenge = challenge;
			
			init();
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			
			_challenge = null;			
			M4Tween.killTweensOf( apercuOver );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			EliveUtils.configureText( apercuTop.tf, "elives_list_apercu_title", _challenge.title );
			EliveUtils.configureText( apercuBg.tf, "elives_list_apercu_content", "(e)maker : " + _challenge.getSender().name );
			
			var color:uint;
			switch( _challenge.getStatus() )
			{
				case ChallengeStatus.CURRENT: 
				case ChallengeStatus.ENDED_WON:
					color = 0xc2d24f; 
					break;
				case ChallengeStatus.PENDING: color = 0xf8b63d; break;
				case ChallengeStatus.ENDED_LOST:
				case ChallengeStatus.ENDED_REFUSED:				
					color = 0x965698;
					break;
			}
			apercuTop.bg.transform.colorTransform = EliveUtils.getColorTransform( color );
			
			this.mouseChildren = false;
			apercuOver.alpha = 0;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function over():void
		{
			apercuOver.alpha = .6;
			M4Tween.to( apercuOver, .25, { alpha: 1 } );
		}
		
		public function out():void
		{
			apercuOver.alpha = .4;
			M4Tween.to( apercuOver, .25, { alpha: 0 } );
		}
		
		public function getId():int { return _challenge.id; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}