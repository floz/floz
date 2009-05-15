
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.details 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import main.Config;
	import main.ProjectEvent;
	
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
		
		private function onProjectSelect(e:ProjectEvent):void 
		{
			var projectEvent:ProjectEvent = new ProjectEvent( ProjectEvent.PROJECT_SELECT );
			projectEvent.index = e.index;
			projectEvent.section = e.section;
			
			_dispatcher.dispatchEvent( projectEvent );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate( section:String, index:int ):void
		{
			if ( _detailContainer )
			{
				_detailContainer.switchProject( index );
				return;
			}
			
			_datas = section == Config.WORKS ? Config.worksDatas : Config.labDatas;
			
			var project:Object = _datas[ index ];
			if ( !project ) throw new Error( "Aucun projet associé !" );
			
			while ( Config.cntMain.numChildren ) Config.cntMain.removeChildAt( 0 );
			
			_detailContainer = new DetailsContainer();
			_detailContainer.addEventListener( ProjectEvent.PROJECT_SELECT, onProjectSelect );
			Config.cntMain.addChild( _detailContainer );
			_detailContainer.linkToProject( project );
		}
		
		public function deactivate():void
		{
			if ( _detailContainer )
			{
				_detailContainer.removeEventListener( ProjectEvent.PROJECT_SELECT, onProjectSelect );
				Config.cntMain.removeChild( _detailContainer );
			}
			_detailContainer = null;
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_dispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}