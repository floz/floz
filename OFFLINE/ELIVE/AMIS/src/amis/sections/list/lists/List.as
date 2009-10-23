/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.list.lists
{
	import amis.sections.list.apercus.Apercu;
	import amis.sections.list.SousRub;
	import elive.core.users.User;
	import elive.events.NavEvent;
	import elive.navigation.HistoricManager;
	import elive.navigation.NavIds;
	import elive.xmls.EliveXML;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.core.configuration.Configuration;
	import fr.minuit4.net.loaders.types.DatasLoader;
	
	public class List extends SousRub
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _historicManager:HistoricManager;	
		
		private var _datasLoader:DatasLoader;		
		private var _apercuOnScroll:Apercu;
		
		protected var _xml:XML;
		
		protected var _disabled:Boolean;
		
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
			
			if ( !_disabled )
			{
				_cntContent.removeEventListener( MouseEvent.MOUSE_OVER, mouseOverHandler );
				_cntContent.removeEventListener( MouseEvent.MOUSE_OUT, mouseOutHandler );
				_cntContent.removeEventListener( MouseEvent.MOUSE_DOWN, mouseOutHandler );
			}
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		protected function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			
			if ( !_disabled )
			{
				_cntContent.addEventListener( MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true );
				_cntContent.addEventListener( MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true );
				_cntContent.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true );
			}
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
			
			var navEvent:NavEvent = new NavEvent( NavEvent.SWITCH_SECTION, true );
			navEvent.sectionId = 1;
			navEvent.id = apercu.getId();
			dispatchEvent( navEvent );
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
		
		protected function build():void
		{
			// ABSTRACT
		}		
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function dispose():void
		{
			_apercuOnScroll = null;
			_xml = null;
			
			super.dispose();
			
			if ( hasEventListener( Event.ADDED_TO_STAGE ) ) removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}