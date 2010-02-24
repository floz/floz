
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.common.layers 
{
	import flash.display.Sprite;
	import fr.minuit4.games.core.renderers.IRenderable;
	import fr.minuit4.games.tilebased.common.objects.GameObject;
	
	public class Layer extends Sprite implements ILayer
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _objects:Array;
		private var _needRender:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Layer() 
		{
			_objects = [];
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addObject( object:GameObject ):void
		{
			_objects[ _objects.length ] = object;	
			addChild( object );
			
			object.registerToLayer( this );
		}
		
		public function render( forceRender:Boolean = false, renderTime:Number = -1 ):void
		{
			if ( !_needRender && !forceRender )
				return;
			
			_objects.sortOn( "depth", Array.NUMERIC );
			
			var n:int = _objects.length;
			for ( var i:int; i < n; ++i )
				addChild( _objects[ i ] );
			
			_needRender = false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get needRender():Boolean { return _needRender; }
		
		public function set needRender(value:Boolean):void 
		{
			_needRender = value;
		}
		
	}
	
}