
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.common.layers 
{
	import flash.display.Sprite;
	import flash.utils.getTimer;
	import fr.minuit4.games.core.renderers.IRenderable;
	import fr.minuit4.games.tilebased.common.objects.GameObject;
	
	public class Layer extends Sprite implements ILayer
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _objects:Array;
		private var _objectsToRender:Vector.<GameObject>;
		private var _needRender:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Layer() 
		{
			_objects = [];
			_objectsToRender = new Vector.<GameObject>();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function getDepthIdx( depth:Number ):int
		{
			const L:int = _objects.length;
			
			var min:int = 0;
			var max:int = L;
			
			var mid:int;
			
			while ( min < max )
			{
				mid = min + ( ( max - min ) >> 1 );
				if ( mid < min )
					min = mid + 1;
				else
					max = mid;
			}
			
			return min;			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addObject( object:GameObject ):void
		{
			var idx:int = getDepthIdx( object.depth );
			_objects[ idx ] = object;
			addChildAt( object, idx );
			
			object.registerToLayer( this );
		}
		
		public function removeObject( object:GameObject ):void
		{
			var idx:int = getDepthIdx( object.depth );
			if ( !object.isRegisterToLayer( this ) )
				return;
			
			// On vérifie si l'index est correct, si non on le recherche.
			var go:GameObject = _objects[ idx ];
			if ( go != object )
			{
				while ( go != object )
					go = _objects[ ++idx ];
			}			
			_objects.splice( idx, 1 );
			
			// On vérifie et supprime si présent dans la liste des objets à rendre.
			idx = _objectsToRender.indexOf( object );
			if ( idx >= 0 )
				_objectsToRender.splice( idx, 1 );
			
			object.unregisterFromLayer();
		}
		
		public function render( forceRender:Boolean = false, renderTime:Number = -1 ):void
		{
			if ( !_needRender && !forceRender )
				return;
			
			var go:GameObject;
			
			var i:int = _objectsToRender.length;
			while ( --i > -1 )
			{
				go = _objectsToRender[ i ];
				addChildAt( go, getDepthIdx( go.depth ) );
			}
			
			_objectsToRender = new Vector.<GameObject>();
			_needRender = false;
		}
		
		public function renderObject( object:GameObject ):void
		{
			_objectsToRender[ _objectsToRender.length ] = object;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get needRender():Boolean { return _needRender; }
		
		public function set needRender(value:Boolean):void 
		{
			_needRender = value;
		}
		
	}
	
}