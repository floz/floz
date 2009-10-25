/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.sheet.sheets.elives 
{
	import assets.GApercu;
	import assets.GApercuAvatar;
	import assets.GAvatar1;
	import aze.motion.Eaze;
	import elive.core.challenges.Challenge;
	import elive.core.challenges.ChallengeStatus;
	import elive.events.EliveEvent;
	import elive.ui.compteur.Compteur;
	import elive.utils.EliveUtils;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.events.Event;
	import flash.text.TextField;
	import fr.minuit4.core.configuration.Config;
	import fr.minuit4.core.configuration.Configuration;
	
	public class Apercu extends GApercu
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _compteur:Compteur;
		private var _challenge:Challenge;
		private var _avatarHolder:GApercuAvatar;
		
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
			
			if ( _compteur.hasEventListener( EliveEvent.ELIVE_STATUS_CHANGE ) )
				_compteur.removeEventListener( EliveEvent.ELIVE_STATUS_CHANGE, eliveStatusChangeHandler );
			
			_compteur = null;
			
			Eaze.killTweensOf( apercuOver );
			
			apercuBg = null;
			apercuOver = null;
			apercuTop = null;
			
			Bitmap( _avatarHolder.cnt.getChildAt( 0 ) ).bitmapData.dispose();
			_avatarHolder = null;
			
			_challenge = null;	
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
		}
		
		private function eliveStatusChangeHandler(e:EliveEvent):void 
		{
			_compteur.removeEventListener( EliveEvent.ELIVE_STATUS_CHANGE, eliveStatusChangeHandler );
			
			if ( _challenge.getStatus() == ChallengeStatus.CURRENT )
				_challenge.setStatus( ChallengeStatus.ENDED_LOST );
			else if ( _challenge.getStatus() == ChallengeStatus.PENDING );
				_challenge.setStatus( ChallengeStatus.ENDED_REFUSED );
			
			onEliveStatusChange();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			EliveUtils.configureText( apercuTop.tf, "elives_list_apercu_title", _challenge.title );
			EliveUtils.configureText( apercuBg.tf, "elives_list_apercu_content", "(e)maker : " + _challenge.getSender().name );
			
			customizeTopBg();
			
			_compteur = new Compteur();
			_compteur.addEventListener( EliveEvent.ELIVE_STATUS_CHANGE, eliveStatusChangeHandler, false, 0, true );
			_compteur.scaleX = _compteur.scaleY = .8;
			_compteur.setEndTime( _challenge.endTime );
			_compteur.x = 65;
			_compteur.y = 50;
			addChild( _compteur );
			
			_avatarHolder = new GApercuAvatar();
			_avatarHolder.x = 3;
			_avatarHolder.y = 53;
			_avatarHolder.cnt.addChild( new Bitmap( new GAvatar1( 0, 0 ), PixelSnapping.AUTO, true ) );
			addChild( _avatarHolder );
			
			this.mouseChildren = false;
			apercuOver.alpha = 0;
		}
		
		private function customizeTopBg():void
		{
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
		}
		
		private function onEliveStatusChange():void
		{
			// TODO: Envoyer les infos du nouveau status à php
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function over():void
		{
			apercuOver.alpha = .6;
			Eaze.to( apercuOver, .25, { alpha: 1 } );
		}
		
		public function out():void
		{
			apercuOver.alpha = .4;
			Eaze.to( apercuOver, .25, { alpha: 0 } );
		}
		
		public function getId():int { return _challenge.id; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}