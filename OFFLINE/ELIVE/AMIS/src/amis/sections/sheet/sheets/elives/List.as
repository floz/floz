/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.sheet.sheets.elives
{
	import elive.core.challenges.Challenge;
	import elive.events.NavEvent;
	import elive.navigation.HistoricManager;
	import elive.navigation.NavIds;
	import elive.navigation.NavManager;
	import elive.xmls.EliveXML;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.core.configuration.Configuration;
	import fr.minuit4.net.loaders.types.DatasLoader;
	
	public class List extends SousRub
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _historicManager:HistoricManager;
		
		private var _challenges:Vector.<Challenge>
		private var _datasLoader:DatasLoader;
		
		private var _apercuOnScroll:Apercu;
		
		private var _xml:XML;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function List() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			_cntContent.removeEventListener( MouseEvent.MOUSE_OVER, mouseOverHandler );
			_cntContent.removeEventListener( MouseEvent.MOUSE_OUT, mouseOutHandler );
			_cntContent.removeEventListener( MouseEvent.MOUSE_DOWN, mouseOutHandler );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			
			_cntContent.addEventListener( MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true );
			_cntContent.addEventListener( MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true );
			_cntContent.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true );
		}
		
		private function mouseOverHandler(e:MouseEvent):void 
		{
			var apercu:Apercu = e.target as Apercu;
			if ( isDragging() )
			{
				_apercuOnScroll = apercu;
				return;
			}
			apercu.over();
		}
		
		private function mouseOutHandler(e:MouseEvent):void 
		{
			if ( isDragging() )
			{
				_apercuOnScroll = null;
				return;
			}
			var apercu:Apercu = e.target as Apercu;
			apercu.out();
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			var apercu:Apercu = e.target as Apercu;
			
			_historicManager.registerLastNav( NavIds.AMIS, 0 );			
			NavManager.getInstance().switchRub( NavIds.ELIVES, 1, apercu.getId() );
		}
		
		private function datasLoaderCompleteHandler( e:Event ):void
		{
			_xml = XML( _datasLoader.getItemLoaded() );
			
			_datasLoader.removeEventListener( Event.COMPLETE, datasLoaderCompleteHandler );
			_datasLoader.dispose();
			_datasLoader = null;
			
			build();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_historicManager = HistoricManager.getInstance();
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );			
		}
		
		protected function loadXML( xmlName:String ):void
		{
			_datasLoader = new DatasLoader( Configuration.pathXML + "/" + xmlName );
			_datasLoader.addEventListener( Event.COMPLETE, datasLoaderCompleteHandler, false, 0, true );
			_datasLoader.load();
		}
		
		private function build():void
		{
			resetChallenges();
			_challenges = EliveXML.parseChallenges( _xml );
			
			var apercu:Apercu;
			var i:int, n:int = _challenges.length, py:int;
			for ( ; i < n; ++i )
			{
				apercu = new Apercu( _challenges[ i ] );
				apercu.y = int( py );
				_cntContent.addChild( apercu );
				
				py += apercu.height;
			}
		}
		
		private function resetChallenges():void
		{
			_challenges = null;			
			while ( _cntContent.numChildren ) _cntContent.removeChildAt( 0 );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function dispose():void
		{
			resetChallenges();
			
			_apercuOnScroll = null;
			_xml = null;
			
			super.dispose();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}