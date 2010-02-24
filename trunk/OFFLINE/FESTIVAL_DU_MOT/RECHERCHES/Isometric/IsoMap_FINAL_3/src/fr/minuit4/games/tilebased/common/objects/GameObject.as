
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
				_layer.needRender = true;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function registerToLayer( layer:ILayer ):void
		{
			this._layer = layer;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get depth():Number
		{
			return NaN;
		}
		
	}
	
}