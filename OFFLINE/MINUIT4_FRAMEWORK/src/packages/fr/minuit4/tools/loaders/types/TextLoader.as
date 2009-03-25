
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.loaders.types 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import fr.minuit4.tools.loaders.BasicLoader;
	
	public class TextLoader extends BasicLoader
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _loader:URLLoader;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TextLoader( isPersistent = false ) 
		{
			super( isPersistent );
			
			_loader = new URLLoader();
			_loader.addEventListener( Event.INIT, onInit, false, 0, true );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, onIOError, false, 0, true );
			_loader.addEventListener( ProgressEvent.PROGRESS, onProgress, false, 0, true );
			_loader.addEventListener( Event.COMPLETE, onComplete, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected override function setItemLoaded():void
		{
			_itemLoaded = _loader.data;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public override function load( url:String ):void
		{
			super.load( url );
			_loader.load( _request );
		}
		
		public override function destroy():void
		{
			super.destroy();
			
			_loader.removeEventListener( Event.INIT, onInit );
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader.removeEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.removeEventListener( Event.COMPLETE, onComplete );
			
			try { _loader.close(); }
			catch ( e:Error ) { }
			
			_loader = null;
			
			if ( !_isPersistent )
				_itemLoaded = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}