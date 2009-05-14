
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.about 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import main.Config;
	
	public class AboutCtrl 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _dispatcher:EventDispatcher;
		
		private var _aboutContainer:AboutContainer;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AboutCtrl() 
		{
			_dispatcher = new EventDispatcher();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function onComplete(e:Event):void 
		{
			_aboutContainer.removeEventListener(Event.COMPLETE, onComplete);
			Config.cntMain.removeChild( _aboutContainer );
			_aboutContainer = null;
			
			_dispatcher.dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate():void
		{
			while ( Config.cntMain.numChildren ) Config.cntMain.removeChildAt( 0 );
			
			_aboutContainer = new AboutContainer();
			_aboutContainer.activate();
			_aboutContainer.addEventListener( Event.COMPLETE, onComplete );
			Config.cntMain.addChild( _aboutContainer );
		}
		
		public function deactivate():void
		{
			_aboutContainer.deactivate();
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_dispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}