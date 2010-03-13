
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.isometric.objects.primitives
{
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	import fr.tilzy.common.materials.Material;
	import fr.tilzy.isometric.geom.IsoMath;
	import fr.tilzy.isometric.graphics.IsoDrawing;
	import fr.tilzy.isometric.objects.IsoObject;
	
	public class IsoPlane extends IsoPrimitive
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _size:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoPlane( material:Material, size:int = 32 ) 
		{
			this._size = size;
			
			initShape();
			
			super( material );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initShape():void
		{
			_commands = new Vector.<int>();
			_datas = new Vector.<Number>();
			
			var gp:GraphicsPath = IsoDrawing.getRectPath( _size, _size );
			_commands = _commands.concat( gp.commands );
			_datas = _datas.concat( gp.data );
			
			_commands.fixed = true;
			_datas.fixed = true;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get size():int { return _size; }
		
		public function set size(value:int):void 
		{
			_size = value;
			initShape();
			render();
		}
		
	}
	
}