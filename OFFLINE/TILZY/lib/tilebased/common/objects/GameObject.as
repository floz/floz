
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.common.objects 
{
	import flash.display.Sprite;
	import fr.minuit4.games.tilebased.common.layers.ILayer;
	
	public class GameObject extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _layer:ILayer;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function GameObject() 
		{
			
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
		
		public function registerToLayer( layer:ILayer ):void
		{
			_layer = layer;
			invalidate();
		}
		
		public function unregisterFromLayer():void
		{
			_layer = null;
		}
		
		public function isRegisterToLayer( layer:ILayer ):Boolean
		{
			return ( hasLayer() && ( _layer == layer ) );
		}
		
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