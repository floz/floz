
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.wtf.engines.renderer 
{
	import flash.events.EventDispatcher;
	
	public class ARenderer extends EventDispatcher implements IRenderable
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _renderables:Vector.<IRenderable>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ARenderer() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_renderables = new Vector.<IRenderable>();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function render( renderTime:Number ):void
		{
			var l:int = _renderables.length;
			while ( --l > -1 )
				_renderables[ l ].render( renderTime );
		}
		
		public function register( renderable:IRenderable ):Boolean
		{
			if ( _renderables.indexOf( renderable, 0 ) != -1 )
				return false;
			
			var l:int = _renderables.length;
			return ( _renderables.push( renderable ) != _renderables.length );
		}
		
		public function unregister( renderable:IRenderable ):Boolean
		{
			var idx:int = _renderables.indexOf( renderable, 0 );
			if ( idx < -1 ) 
				return false;
			
			var l:int = _renderables.length;
			return ( _renderables.splice( idx, 1 ).length != l );
		}
		
		public function unregisterAll():void
		{
			init();
		}
		
		public function dispose():void
		{
			_renderables = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}