
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
	import fr.minuit4.games.tilebased.isometric.objects.primitives.IsoBox;
	import fr.minuit4.games.tilebased.isometric.objects.primitives.IsoPlane;
	
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
		
		private function addToList( object:GameObject ):void
		{
			var depth:int = getDepthIdx( object.depth );
			_objects.splice( depth, 0, object );
			addChildAt( object, depth );
		}
		
		// Binary search : optimisation, plus rapide que de sortOn le tableau
		private function getDepthIdx( depth:Number ):int
		{
			const L:int = _objects.length;
			
			var min:int = 0;
			var max:int = L;
			
			var mid:int;
			
			while ( min < max )
			{
				mid = min + ( ( max - min ) >> 1 );
				if ( _objects[ mid ].depth < depth )
					min = mid + 1;
				else
					max = mid;
			}
			
			return min;			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addObject( object:GameObject ):void
		{
			addToList( object );
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
			idx = _objectsToRender.indexOf( object ); // TODO : Optimiser à ce niveau ?
			if ( idx >= 0 )
				_objectsToRender.splice( idx, 1 );
			
			object.unregisterFromLayer();
		}
		
		public function render( forceRender:Boolean = false, renderTime:Number = -1 ):void
		{
			if ( !_needRender && !forceRender )
				return;
			
			var go:GameObject;
			
			var idx:int, depth:int;
			var i:int = _objectsToRender.length;
			while ( --i > -1 )
			{
				// On récupère l'objet à render, ainsi que sa profondeur, et on reset sa position.
				go = _objectsToRender[ i ];
				
				// On met à jour la liste d'objets.
				idx = _objects.indexOf( go ); // TODO : Regarder pour optimiser à cet endroit
				if ( idx >= 0 )
					_objects.splice( idx, 1 );				
				
				addToList( go );
			}
			
			_objectsToRender = new Vector.<GameObject>();
			
			_needRender = false;
		}
		
		public function renderObject( object:GameObject ):void
		{
			if ( _objectsToRender.indexOf( object ) >= 0 ) // TODO : Optimiser à ce niveau ?
				return;
			
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