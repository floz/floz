
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.sheet.sheets 
{
	import amis.sections.sheet.apercus.GallerieApercu;
	import assets.GScrollbarBackground;
	import assets.GScrollbarSlider;
	import elive.core.challenges.Challenge;
	import elive.core.challenges.ChallengeStatus;
	import elive.core.users.User;
	import elive.xmls.EliveXML;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.core.configuration.Configuration;
	import fr.minuit4.net.loaders.types.DatasLoader;
	import fr.minuit4.tools.scrollbars.VScrollbar;
	import fr.minuit4.ui.Dummy;
	
	public class SheetGalerie extends Sheet
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _datasLoader:DatasLoader;
		
		private var _cntContent:Sprite;
		private var _scrollbar:VScrollbar;
		
		private var _challengesWon:Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SheetGalerie() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			if ( _datasLoader && _datasLoader.hasEventListener( Event.COMPLETE ) )
			{
				_datasLoader.removeEventListener( Event.COMPLETE, loadChallengesHandler );
				_datasLoader.dispose();
				_datasLoader = null;
			}
			
			_scrollbar.dispose();
			_scrollbar = null;
			
			_cntContent = null;
			
			_challengesWon = null;
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
		}
		
		private function loadChallengesHandler(e:Event):void 
		{
			var xml:XML = XML( _datasLoader.getItemLoaded() );
			_datasLoader.removeEventListener( Event.COMPLETE, loadChallengesHandler );
			_datasLoader.dispose();
			_datasLoader = null;
			
			var challenge:Challenge;
			_challengesWon = [];
			var challenges:Array = EliveXML.parseChallenges( xml );
			var i:int, n:int = challenges.length;
			for ( ; i < n; ++i )
			{
				challenge = challenges[ i ];
				if ( challenge.getStatus() != ChallengeStatus.ENDED_WON ) continue;
				
				_challengesWon.push( challenge );
			}
			
			buildGallerie();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_cntContent = new Sprite();
			addChild( _cntContent );
			
			var mask:Sprite = new Sprite();
			var g:Graphics = mask.graphics;
			g.beginFill( 0x00ff00 );
			g.drawRect( 0, 0, 266, 288 );
			g.endFill();
			addChild( mask );
			
			_scrollbar = new VScrollbar( new GScrollbarBackground(), new GScrollbarSlider() );
			_scrollbar.link( _cntContent, mask );
			_scrollbar.x = 270;
			addChild( _scrollbar );
			_scrollbar.enableBlur = true;
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function loadChallenges():void
		{
			_datasLoader = new DatasLoader( Configuration.pathXML + "/" + "actions_list_termines_2.xml" );
			_datasLoader.addEventListener( Event.COMPLETE, loadChallengesHandler, false, 0, true );
			_datasLoader.load();
		}
		
		private function buildGallerie():void
		{
			var challenge:Challenge;
			var gallerieApercu:GallerieApercu;
			var py:int, i:int, n:int = _challengesWon.length;
			for ( ; i < n; ++i )
			{
				challenge = _challengesWon[ i ];
				gallerieApercu = new GallerieApercu();
				gallerieApercu.setTitleText( challenge.title );
				gallerieApercu.loadImage( challenge.getMediasUrls()[ 0 ] );
				gallerieApercu.y = py;
				_cntContent.addChild( gallerieApercu );
				py += gallerieApercu.height;				
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function linkTo(user:User):void 
		{
			super.linkTo(user);
			loadChallenges();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}