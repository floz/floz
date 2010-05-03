
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.core.layers 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import fr.tilzy.common.objects.GameObject;
	import fr.tilzy.isometric.objects.primitives.IsoBox;
	import fr.tilzy.isometric.objects.primitives.IsoPlane;
	
	/**
	 * Un layer est un conteneur gérant la profondeur des objets, en fonction de leurs propriétés 'depth'.
	 * Les objets attendus sont des GameObject.
	 */
	public class Layer extends Sprite implements ILayer
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _objects:/*GameObject*/Array;
		private var _objectsToRender:Vector.<GameObject>;
		private var _needRender:Boolean;
		
		private var _objA:GameObject;
		private var _objB:GameObject;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Crée un nouveau Layer.
		 */
		public function Layer() 
		{
			_objects = [];
			_objectsToRender = new Vector.<GameObject>();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function addToList( object:GameObject ):void
		{
			var idx:int = getDepthIdx( object.depth );
			_objects.splice( idx, 0, object );
			addChildAt( object, idx );
			
			var startIdx:int = idx;
			var sorted:Boolean = true;
			
			do
			{
				idx = startIdx;
				_objA = _objects[ idx ];
				
				sorted = true;
				
				while( idx + 1 < _objects.length && _objects[ idx + 1 ].depth == _objA.depth )
				{
					_objB = _objects[ idx + 1 ];
					if ( _objA.y > _objB.y )
					{
						_objects[ idx ] = _objB;
						_objects[ idx + 1 ] = _objA;
						swapChildren( _objA, _objB );
						
						sorted = false;
					}
					
					_objA = _objB;
					++idx;
				}
			} 
			while ( !sorted );
			
			_objA = null;
			_objB = null;
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
		
		/**
		 * Ajoute un objet au layer.
		 * @param	object	GameObject	L'objet à ajouter.
		 */
		public function addObject( object:GameObject ):void
		{
			addToList( object );
			object.registerToLayer( this );
		}
		
		/**
		 * Supprimer un objet du layer.
		 * @param	object	GameObject	L'objet à supprimer.
		 */
		public function removeObject( object:GameObject ):void
		{
			if ( !object.isRegisterToLayer( this ) )
				return;
			
			var idx:int = getDepthIdx( object.depth );
			
			// On vérifie si l'index est correct, si non on le recherche.
			var go:GameObject = _objects[ idx ];
			if ( go != object )
			{
				while ( go != object )
					go = _objects[ ++idx ];
			}			
			_objects.splice( idx, 1 );
			
			// On vérifie et supprime si présent dans la liste des objets à rendre.
			/*idx = _objectsToRender.indexOf( object ); // TODO : Optimiser à ce niveau ?
			if ( idx >= 0 )
				_objectsToRender.splice( idx, 1 );*/
			
			object.unregisterFromLayer();
			
			// Ne pas oublier de le virer de la display list :)
			removeChild( go );
		}
		
		/**
		 * Actualise l'affichage du layer.
		 * @param	forceRender	Boolean	Force l'affichage, même s'il n'y en a pas la nécessité.
		 */
		public function render( forceRender:Boolean = false ):void
		{
			/*if ( !_needRender && !forceRender )
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
			_needRender = false;*/
		}
		
		/**
		 * Rend disponible un objet au prochain rendu.
		 * Appellé automatiquement par l'objet lorsque sa position change.
		 * @param	object	GameObject	L'objet à rendre.
		 */
		public function renderObject( object:GameObject ):void
		{
			//var idx:int = _objectsToRender.indexOf( object );
			//if ( idx >= 0 ) // TODO : Optimiser à ce niveau ?
				//_objectsToRender.splice( idx, 1 );
			
			//_objectsToRender.splice( 0, 0, object );
			
			var idx:int = _objects.indexOf( object );
			if ( idx >= 0 )
				_objects.splice( idx, 1 );
			
			addToList( object );
			
			// Lancer un render à chaque fois, plutot qu'ajouter tout dans la liste et la traiter a l'appel de render() ?
		}
		
		public function dispose():void
		{			
			_objA = null;
			_objB = null;
			var i:int = _objects.length;
			while ( --i > -1 )
			{
				_objects[ i ].unregisterFromLayer();
			}
			_objectsToRender = null;
		}
		
		public function traceObjects():void
		{
			trace( "Object : " + _objects );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get needRender():Boolean { return _needRender; }
		
		public function set needRender( value:Boolean ):void 
		{
			_needRender = value;
		}
		
	}
	
}