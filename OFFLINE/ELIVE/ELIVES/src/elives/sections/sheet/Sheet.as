
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elives.sections.sheet 
{
	import assets.GApercu;
	import assets.GScrollbarBackground;
	import assets.GScrollbarSlider;
	import assets.GScrollbarSmallBackground;
	import elive.core.challenges.Challenge;
	import elive.core.challenges.ChallengeStatus;
	import elive.core.comments.Comment;
	import elive.core.interfaces.ILinkable;
	import elive.core.users.User;
	import elive.events.EliveEvent;
	import elive.events.NavEvent;
	import elive.ui.compteur.Compteur;
	import elive.ui.EliveButton;
	import elive.ui.sousmenu.SousMenu;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.core.interfaces.IDisposable;
	import fr.minuit4.tools.scrollbars.VScrollbar;
	
	public class Sheet extends Sprite implements IDisposable
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _sousMenu:SousMenu;
		private var _challenge:Challenge;
		
		private var _compteur:Compteur;
		private var _cntContent:Sprite;
		private var _cntGlobal:Sprite;
		private var _scrollBar:VScrollbar;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Sheet() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function switchSousRubriqueHandler(e:NavEvent):void 
		{
			switch( e.navId )
			{
				case SousMenuActionsIds.ACCEPT: _challenge.setStatus( ChallengeStatus.CURRENT ); break;
				case SousMenuActionsIds.REFUSE: _challenge.setStatus( ChallengeStatus.ENDED_REFUSED ); break;
				case SousMenuActionsIds.VALID: _challenge.setStatus( ChallengeStatus.ENDED_WON ); break;
			}
			onEliveStatusChange(); 
			buildSousMenu();
		}
		
		private function eliveStatusChangeHandler(e:EliveEvent):void 
		{
			if ( _challenge.getStatus() == ChallengeStatus.CURRENT )
				_challenge.setStatus( ChallengeStatus.ENDED_LOST );
			else if ( _challenge.getStatus() == ChallengeStatus.PENDING );
				_challenge.setStatus( ChallengeStatus.ENDED_REFUSED );
			
			onEliveStatusChange(); 
			buildSousMenu();
		}
		
		private function btCommentDownHandler(e:MouseEvent):void 
		{
			// TODO: La fenêtre de commentaires;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_cntGlobal = new Sprite();
			_cntGlobal.x = 5;
			_cntGlobal.y = 160;
			addChild( _cntGlobal );
			
			var mask:Sprite = new Sprite();
			var g:Graphics = mask.graphics;
			g.beginFill( 0x00ff00 );
			g.drawRect( 0, 0, 266, 220 );
			g.endFill();
			_cntGlobal.addChild( mask );
			
			_cntContent = new Sprite();  
			_cntContent.y = 5;
			_cntGlobal.addChild( _cntContent );
			
			_scrollBar = new VScrollbar( new GScrollbarSmallBackground(), new GScrollbarSlider() );
			_scrollBar.x = 275;
			_scrollBar.y = 160;
			_scrollBar.link( _cntContent, mask );
			addChild( _scrollBar );	
			_scrollBar.enableBlur = true;
		}
		
		private function build():void
		{
			buildSousMenu();
			
			_compteur = new Compteur(); 
			_compteur.addEventListener( EliveEvent.ELIVE_STATUS_CHANGE, eliveStatusChangeHandler, false, 0, true );
			_compteur.x = 144 - _compteur.width * .5;
			_compteur.y = 88;
			_compteur.setEndTime( _challenge.endTime );
			addChild( _compteur );
			
			buildContent();
		}
		
		private function buildSousMenu():void
		{
			if ( _sousMenu )
			{
				if ( _sousMenu.hasEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE ) ) 
					_sousMenu.removeEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubriqueHandler );
				
				removeChild( _sousMenu );
				_sousMenu = null;
			}
			
			_sousMenu = new SousMenu();
			_sousMenu.x = 20;
			_sousMenu.y = 60;
			
			switch( _challenge.getStatus() )
			{
				case ChallengeStatus.PENDING:
					_sousMenu.addItem( "Accepter", SousMenuActionsIds.ACCEPT, "elives_sousmenu_bt_over_encours" );
					_sousMenu.addItem( "Refuser", SousMenuActionsIds.REFUSE, "elives_sousmenu_bt_over_termines" );
					_sousMenu.addEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubriqueHandler, false, 0, true );
					break;
				case ChallengeStatus.CURRENT:
					_sousMenu.addItem( "Valider", SousMenuActionsIds.VALID, "elives_sousmenu_bt_over_encours" );
					_sousMenu.addItem( "Refuser", SousMenuActionsIds.REFUSE, "elives_sousmenu_bt_over_termines" );
					_sousMenu.addEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubriqueHandler, false, 0, true );
					break;
				case ChallengeStatus.ENDED_LOST:
				case ChallengeStatus.ENDED_REFUSED:
					_sousMenu.addItem( "Perdu !", "none", "elives_sousmenu_bt_over_termines" );
					_sousMenu.deactivate();
					break;
				case ChallengeStatus.ENDED_WON:
					_sousMenu.addItem( "Bravo !", "none", "elives_sousmenu_bt_over_encours" );
					_sousMenu.deactivate();
					break;
			}
			
			_sousMenu.disableActivatedState();
			_sousMenu.buildSeparatorBars();
			addChild( _sousMenu );
		}
		
		private function buildContent():void
		{
			TextApercu.STATUS = _challenge.getStatus();
			
			while ( _cntContent.numChildren ) _cntContent.removeChildAt( 0 );
			
			// Emaker
			var apercuEmaker:TextApercu = new TextApercu();
			apercuEmaker.setTitleText( "(e)maker" );
			apercuEmaker.setContentText( _challenge.getSender().name );
			_cntContent.addChild( apercuEmaker );
			
			
			// Elivers
			var user:User;
			var users:Vector.<User> = _challenge.getTargets();
			var text:String = "";
			var i:int, n:int = users.length;
			for ( ; i < n; ++i )
			{
				user = users[ i ];
				text += user.name;
				if ( i != int( n - 1 ) ) text += ", ";
			}
			
			var apercuElivers:TextApercu = new TextApercu();
			apercuElivers.y = apercuEmaker.height + 3;
			apercuElivers.setTitleText( "(e)liver(s)" );
			apercuElivers.setContentText( text );
			_cntContent.addChild( apercuElivers );
			
			
			// Description
			var apercuDesc:TextApercu = new TextApercu();
			apercuDesc.y = apercuElivers.height + apercuElivers.y + 3;
			apercuDesc.setTitleText( "Description de l'(e)live" );
			apercuDesc.setContentText( _challenge.description );
			_cntContent.addChild( apercuDesc );
			
			
			// Commentaires
			text = "";
			var date:Date;
			var comment:Comment;
			var comments:Vector.<Comment> = _challenge.getComments();
			i = 0, n = comments.length;
			for ( ; i < n; ++i )
			{
				comment = comments[ i ];
				date = new Date( comment.date );
				text += comment.text + "\n" + "<span class='comment_user'>de : " + comment.getUser().name + "</span>\n---------------------------------------";
				if ( i != int( n - 1 ) ) text += "\n";
			}
			
			var apercuComments:TextApercu = new TextApercu();
			apercuComments.y = apercuDesc.height + apercuDesc.y + 3;
			apercuComments.setTitleText( "Commentaires de l'(e)live" );
			apercuComments.setContentText( text );
			_cntContent.addChild( apercuComments );
			
			var bt:EliveButton = new EliveButton();
			bt.addEventListener( MouseEvent.MOUSE_DOWN, btCommentDownHandler, false, 0, true );
			bt.setText( "Commenter" );
			bt.y = apercuComments.y + apercuComments.height + 5;
			_cntContent.addChild( bt );
		}
		
		private function onEliveStatusChange():void
		{
			// TODO: Envoyer les infos du nouveau status à php
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function linkTo( challenge:Challenge ):void
		{
			this._challenge = challenge;
			build();
		}
		
		public function dispose():void
		{
			if( _compteur.hasEventListener( EliveEvent.ELIVE_STATUS_CHANGE ) )
				_compteur.removeEventListener( EliveEvent.ELIVE_STATUS_CHANGE, eliveStatusChangeHandler );
			
			_compteur = null;
			
			if ( _sousMenu.hasEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE ) ) 
					_sousMenu.removeEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubriqueHandler );
			
			_sousMenu = null;
			
			_scrollBar.dispose();
			_scrollBar = null;
			
			_cntGlobal = null;
			_cntContent = null;
			
			_challenge = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}