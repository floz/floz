﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.details 
{
	import flash.events.EventDispatcher;
	import main.Config;
	
	public class DetailsCtrl 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _dispatcher:EventDispatcher;
		
		private var _datas:Array;
		private var _detailContainer:DetailsContainer;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DetailsCtrl() 
		{
			_dispatcher = new EventDispatcher();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate( section:String, index:int ):void
		{
			_datas = section == Config.WORKS ? Config.worksDatas : Config.labDatas;
			
			var project:Object = _datas[ index ];	
			if ( !project ) throw new Error( "Aucun projet associé !" );
			
			while ( Config.cntMain.numChildren ) Config.cntMain.removeChildAt( 0 );
			
			_detailContainer = new DetailsContainer();
			_detailContainer.linkToProject( project );
			Config.cntMain.addChild( _detailContainer );
		}
		
		public function deactivate():void
		{
			
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}