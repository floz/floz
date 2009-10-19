/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elives.sections.list 
{
	import assets.GScrollbarBackground;
	import assets.GScrollbarSlider;
	import elive.core.challenges.Challenge;
	import elive.events.NavEvent;
	import elive.rubriques.sections.Section;
	import elive.xmls.EliveXML;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import fr.minuit4.core.configuration.Configuration;
	import fr.minuit4.net.loaders.types.DatasLoader;
	import fr.minuit4.tools.scrollbars.VScrollbar;
	
	public class ElivesList extends Section
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _cntMenu:Sprite;
		private var _cntApercus:Sprite;
		private var _scrollBar:VScrollbar;
		
		private var _datasLoader:DatasLoader;
		
		private var _challenges:Vector.<Challenge>;
		
		private var _activated:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const SECTION_ID:int = 0;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ElivesList() 
		{
			init();
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			_challenges = null;			
			while ( _cntApercus.numChildren ) _cntApercus.removeChildAt( 0 );
			deactivate();
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
			
			_datasLoader = new DatasLoader( Configuration.pathXML + "/actions_list.xml" );
			_datasLoader.addEventListener( Event.COMPLETE, datasLoaderCompleteHandler, false, 0, true );
			_datasLoader.load();
		}
		
		private function datasLoaderCompleteHandler(e:Event):void 
		{
			var xml:XML = XML( _datasLoader.getItemLoaded() );
			
			_datasLoader.removeEventListener( Event.COMPLETE, datasLoaderCompleteHandler );
			_datasLoader.dispose();
			_datasLoader = null;
			
			_challenges = EliveXML.parseChallenges( xml );
			build();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_cntMenu = new Menu();
			_cntMenu.x = 3;
			addChild( _cntMenu );
			
			_cntApercus = new Sprite();
			_cntApercus.x = 5;
			_cntApercus.y = 90;
			addChild( _cntApercus );
			
			_scrollBar = new VScrollbar( new GScrollbarBackground(), new GScrollbarSlider() );
			_scrollBar.link( _cntApercus, new Rectangle( 0, 0, 264, 290 ) );
			_scrollBar.x = 275;
			_scrollBar.y = 90;
			addChild( _scrollBar );
			//_scrollBar.enableBlur = true;
		}
		
		private function build():void
		{
			var apercu:Apercu;
			var i:int, n:int = _challenges.length, py:int;
			for ( ; i < n; ++i )
			{
				apercu = new Apercu( _challenges[ i ] );
				apercu.y = py;
				_cntApercus.addChild( apercu );
				
				py += apercu.height;
			}
			
			activate();
		}
		
		private function mouseOverHandler(e:MouseEvent):void 
		{
			var apercu:Apercu = e.target as Apercu;
			apercu.over();
		}
		
		private function mouseOutHandler(e:MouseEvent):void 
		{
			var apercu:Apercu = e.target as Apercu;
			apercu.out();
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			var apercu:Apercu = e.target as Apercu;
			
			var navEvent:NavEvent = new NavEvent( NavEvent.SWITCH_SECTION, true );
			navEvent.sectionId = 1;
			navEvent.id = apercu.getId();
			dispatchEvent( navEvent );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function activate():void 
		{
			if ( _activated ) return;
			
			_cntApercus.addEventListener( MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true );
			_cntApercus.addEventListener( MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true );
			_cntApercus.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true );
			
			_activated = true;
		}
		
		override public function deactivate():void 
		{
			if ( !_activated ) return;
			
			_cntApercus.removeEventListener( MouseEvent.MOUSE_OVER, mouseOverHandler );
			_cntApercus.removeEventListener( MouseEvent.MOUSE_OUT, mouseOutHandler );
			_cntApercus.removeEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
			
			_activated = false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}