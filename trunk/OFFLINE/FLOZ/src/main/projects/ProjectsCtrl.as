
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.projects 
{
	import flash.events.EventDispatcher;
	import main.Config;
	
	public class ProjectsCtrl 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _dispatcher:EventDispatcher;
		private var _datasProjects:Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ProjectsCtrl() 
		{
			_dispatcher = new EventDispatcher();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate():void
		{
			switch( Config.currentSection )
			{
				case Config.WORKS: _datasProjects = Config.worksDatas; break;
				case Config.LAB: Config.labDatas;  break;
				default: throw new Error( "Impossibilité de lancé cette rubrique" ); break;
			}
			
			while ( Config.cntMain.numChildren ) Config.cntMain.removeChildAt( 0 );
		}
		
		public function deactivate():void
		{
			
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}