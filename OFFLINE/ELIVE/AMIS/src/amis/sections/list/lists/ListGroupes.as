
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.list.lists 
{
	import amis.sections.list.apercus.ApercuGroupe;
	import elive.core.groups.Group;
	import elive.xmls.EliveXML;
	import flash.events.Event;
	
	public class ListGroupes extends List
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _groups:Vector.<Group>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ListGroupes() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		protected override function addedToStageHandler( e:Event ):void
		{
			super.addedToStageHandler( e );
			loadXML( "lists_list.xml" );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_disabled = true;
		}
		
		override protected function build():void 
		{
			resetGroups();
			_groups = EliveXML.parseGroups( _xml );
			
			var apercu:ApercuGroupe;
			var i:int, n:int = _groups.length, py:int;
			for ( ; i < n; ++i )
			{
				apercu = new ApercuGroupe( _groups[ i ] );
				apercu.y = py;
				_cntContent.addChild( apercu );
				
				py += apercu.height;
			}
		}
		
		private function resetGroups():void
		{		
			while ( _cntContent.numChildren ) _cntContent.removeChildAt( 0 );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function dispose():void 
		{
			super.dispose();
			
			_groups = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}