
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.common.objects 
{
	import flash.display.Sprite;
	import fr.tilzy.core.layers.ILayer;
	
	public class GameObject extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _layer:ILayer;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function GameObject() 
		{
			// ABSTRACT
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function invalidate():void
		{
			if ( _layer )
			{
				_layer.renderObject( this );
				_layer.needRender = true;
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Enregistre un objet auprès d'un layer.
		 * @param	layer	ILlayer	L'objet layer.
		 */
		public function registerToLayer( layer:ILayer ):void
		{
			_layer = layer;
			invalidate();
		}
		
		/**
		 * Désenrengistre un objet de son layer.
		 */
		public function unregisterFromLayer():void
		{
			_layer = null;
		}
		
		/**
		 * Permet de savoir si un objet est déjà enregistré à un Layer.
		 * @param	layer	ILayer	L'objet Layer à tester.
		 * @return	Boolean
		 */
		public function isRegisterToLayer( layer:ILayer ):Boolean
		{
			return ( hasLayer() && ( _layer == layer ) );
		}
		
		/**
		 * Indique si l'objet est enregistré auprès d'un layer.
		 * @return	Boolean
		 */
		public function hasLayer():Boolean
		{
			return ( _layer != null );
		}
		
		override public function toString():String
		{
			return "GameObject : name : " + ( name || "default" + parent.getChildIndex( this ) ) + ", depth : " + depth;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get depth():Number
		{
			return NaN;
		}
		
	}
	
}