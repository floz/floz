
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.isometric.objects.primitives
{
	import flash.display.GraphicsPathCommand;
	import fr.minuit4.games.tilebased.common.materials.Material;
	import fr.minuit4.games.tilebased.isometric.geom.IsoMath;
	import fr.minuit4.games.tilebased.isometric.objects.IsoObject;
	import fr.minuit4.geom.Point3D;
	
	public class IsoPlane extends IsoPrimitive
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _size:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoPlane( material:Material, size:int = 32 ) 
		{
			this._size = size;
			super( material );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function initCommands():void
		{
			_commands = new Vector.<int>( 5, true );
			
			_commands[ 0 ] = GraphicsPathCommand.MOVE_TO;
			var i:int = _commands.length;
			while ( --i > 0 )
				_commands[ i ] = GraphicsPathCommand.LINE_TO;
		}
		
		override protected function initDatas():void
		{
			var p1:Point3D = IsoMath.isoToScreen( _size, 0 );
			var p2:Point3D = IsoMath.isoToScreen( _size, _size );
			var p3:Point3D = IsoMath.isoToScreen( 0, _size );
			
			_datas = new Vector.<Number>( 10, true );
			
			_datas[ 0 ] = 0;
			_datas[ 1 ] = 0;
			
			_datas[ 2 ] = p1.x;
			_datas[ 3 ] = p1.y;
			
			_datas[ 4 ] = p2.x;
			_datas[ 5 ] = p2.y;
			
			_datas[ 6 ] = p3.x;
			_datas[ 7 ] = p3.y;
			
			_datas[ 8 ] = 0;
			_datas[ 9 ] = 0;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get size():int { return _size; }
		
		public function set size(value:int):void 
		{
			_size = value;
			initDatas();
			render();
		}
		
	}
	
}