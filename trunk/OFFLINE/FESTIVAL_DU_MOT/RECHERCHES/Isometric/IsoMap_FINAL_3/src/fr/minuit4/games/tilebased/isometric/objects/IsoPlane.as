
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.isometric.objects 
{
	import flash.display.GraphicsPathCommand;
	import fr.minuit4.games.tilebased.common.materials.Material;
	import fr.minuit4.games.tilebased.isometric.geom.IsoMath;
	import fr.minuit4.geom.Point3D;
	
	public class IsoPlane extends IsoObject
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected const _COMMANDS:Vector.<int> = new Vector.<int>( 5, true );
		protected const _DATAS:Vector.<Number> = new Vector.<Number>( 10, true );
		
		protected var _material:Material;
		protected var _size:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoPlane( material:Material, size:int = 32 ) 
		{
			this._material = material;
			this._size = size;
			
			initCommands();
			initDatas();
			
			render();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function initCommands():void
		{
			_COMMANDS[ 0 ] = GraphicsPathCommand.MOVE_TO;
			var i:int = _COMMANDS.length;
			while ( --i > 0 )
				_COMMANDS[ i ] = GraphicsPathCommand.LINE_TO;
		}
		
		protected function initDatas():void
		{
			var p1:Point3D = IsoMath.isoToScreen( _size, 0 );
			var p2:Point3D = IsoMath.isoToScreen( _size, _size );
			var p3:Point3D = IsoMath.isoToScreen( 0, _size );
			
			_DATAS[ 0 ] = 0;
			_DATAS[ 1 ] = 0;
			
			_DATAS[ 2 ] = p1.x;
			_DATAS[ 3 ] = p1.y;
			
			_DATAS[ 4 ] = p2.x;
			_DATAS[ 5 ] = p2.y;
			
			_DATAS[ 6 ] = p3.x;
			_DATAS[ 7 ] = p3.y;
			
			_DATAS[ 8 ] = 0;
			_DATAS[ 9 ] = 0;
		}
		
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
			
			graphics.drawPath( _COMMANDS, _DATAS );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get size():int { return _size; }
		
		public function set size(value:int):void 
		{
			_size = value;
			render();
		}
		
		public function get material():Material { return _material; }
		
		public function set material(value:Material):void 
		{
			_material = value;
			render();
		}
		
	}
	
}