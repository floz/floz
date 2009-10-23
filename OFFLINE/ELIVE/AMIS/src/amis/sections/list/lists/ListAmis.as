
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.list.lists 
{
	import amis.sections.list.apercus.ApercuAmi;
	import elive.core.users.User;
	import elive.xmls.EliveXML;
	import flash.events.Event;
	
	public class ListAmis extends List
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _amis:Vector.<User>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ListAmis() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		protected override function addedToStageHandler( e:Event ):void
		{
			super.addedToStageHandler( e );
			loadXML( "friends_list.xml" );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------		
		
		override protected function build():void 
		{
			resetFriends();
			_amis = EliveXML.parseUsers( _xml );
			
			var apercu:ApercuAmi;
			var i:int, n:int = _amis.length, py:int;
			for ( ; i < n; ++i )
			{
				apercu = new ApercuAmi( _amis[ i ] );
				apercu.y = py;
				apercu.buttonMode = true;
				_cntContent.addChild( apercu );
				
				py += apercu.height;
			}
		}
		
		private function resetFriends():void
		{		
			while ( _cntContent.numChildren ) _cntContent.removeChildAt( 0 );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function dispose():void 
		{
			super.dispose();
			
			_amis = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}