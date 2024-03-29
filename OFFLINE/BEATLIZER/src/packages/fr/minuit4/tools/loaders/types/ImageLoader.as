﻿
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.loaders.types 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import fr.minuit4.tools.loaders.BasicLoader;
	
	public class ImageLoader extends BasicLoader
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _loader:Loader;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ImageLoader( isPersistent:Boolean = false ) 
		{
			super( isPersistent );
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener( Event.INIT, onInit );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected override function setItemLoaded():void
		{
			_itemLoaded = _loader.contentLoaderInfo.content;			
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
			
			_loader.contentLoaderInfo.removeEventListener( Event.INIT, onInit );
			_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onComplete );
			
			try { _loader.close(); } 
			catch ( e:Error ) { }
			
			_loader = null;
			
			if ( !_isPersistent )
			{
				if( _itemLoaded is Bitmap ) Bitmap( _itemLoaded ).bitmapData.dispose();
				_itemLoaded = null;
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}