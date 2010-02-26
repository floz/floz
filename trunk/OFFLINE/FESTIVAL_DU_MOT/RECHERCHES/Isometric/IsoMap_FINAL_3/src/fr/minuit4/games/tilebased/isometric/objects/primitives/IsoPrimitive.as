
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.isometric.objects.primitives 
{
	import fr.minuit4.games.tilebased.common.materials.Material;
	import fr.minuit4.games.tilebased.isometric.objects.IsoObject;
	
	public class IsoPrimitive extends IsoObject
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _material:Material;
		
		protected var _commands:Vector.<int>;
		protected var _datas:Vector.<Number>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoPrimitive( material:Material ) 
		{
			this._material = material;
			
			render();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function applyMaterial():Boolean
		{
			if ( !material )
				return false;
			
			graphics.clear();
			graphics.drawGraphicsData( material.graphicsData );
			
			return true;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function render():void
		{
			if ( !applyMaterial() )
				return;
			
			graphics.drawPath( _commands, _datas );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get material():Material { return _material; }
		
		public function set material(value:Material):void 
		{
			_material = value;
			render();
		}
		
	}
	
}