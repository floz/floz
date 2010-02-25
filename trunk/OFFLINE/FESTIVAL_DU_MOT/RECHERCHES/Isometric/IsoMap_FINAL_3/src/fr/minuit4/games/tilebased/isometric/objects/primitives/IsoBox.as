
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
	
	public class IsoBox extends IsoPrimitive
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _width:Number;
		private var _length:Number;
		private var _height:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoBox( material:Material, width:Number = 32, length:Number = 32, height:Number = 16 ) 
		{
			this._width = width;
			this._length = length;
			this._height = height;
			
			super( material );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function initCommands():void
		{
			_commands = new Vector.<int>( 15, true );
			
			var i:int = _commands.length;
			while ( --i > -1 )
				_commands[ i ] = GraphicsPathCommand.LINE_TO;
			
			_commands[ 0 ] = GraphicsPathCommand.MOVE_TO;
			_commands[ 5 ] = GraphicsPathCommand.MOVE_TO;
			_commands[ 10 ] = GraphicsPathCommand.MOVE_TO;
		}
		
		override protected function initDatas():void
		{
			var o:Point3D = IsoMath.isoToScreen( _width, 0, 0 );
			var p1:Point3D = IsoMath.isoToScreen( _width, _length, 0 );
			var p2:Point3D = IsoMath.isoToScreen( _width, _length, _height );
			var p3:Point3D = IsoMath.isoToScreen( _width, 0, _height );
			
			_datas = new Vector.<Number>( 30, true );
			
			_datas[ 0 ] = o.x;
			_datas[ 1 ] = o.y;
			
			_datas[ 2 ] = p1.x;
			_datas[ 3 ] = p1.y;
			
			_datas[ 4 ] = p2.x;
			_datas[ 5 ] = p2.y;
			
			_datas[ 6 ] = p3.x;
			_datas[ 7 ] = p3.y;
			
			_datas[ 8 ] = o.x;
			_datas[ 9 ] = o.y;
			
			o = IsoMath.isoToScreen( 0, _length, 0 );
			p1 = IsoMath.isoToScreen( _width, _length, 0 );
			p2 = IsoMath.isoToScreen( _width, _length, _height );
			p3 = IsoMath.isoToScreen( 0, _length, _height );
			
			_datas[ 10 ] = o.x;
			_datas[ 11 ] = o.y;
			
			_datas[ 12 ] = p1.x;
			_datas[ 13 ] = p1.y;
			
			_datas[ 14 ] = p2.x;
			_datas[ 15 ] = p2.y;
			
			_datas[ 16 ] = p3.x;
			_datas[ 17 ] = p3.y;
			
			_datas[ 18 ] = o.x;
			_datas[ 19 ] = o.y;
			
			o = IsoMath.isoToScreen( 0, 0, _height );
			p1 = IsoMath.isoToScreen( _width, 0, _height );
			p2 = IsoMath.isoToScreen( _width, _length, _height );
			p3 = IsoMath.isoToScreen( 0, _length, _height );
			
			_datas[ 20 ] = o.x;
			_datas[ 21 ] = o.y;
			
			_datas[ 22 ] = p1.x;
			_datas[ 23 ] = p1.y;
			
			_datas[ 24 ] = p2.x;
			_datas[ 25 ] = p2.y;
			
			_datas[ 26 ] = p3.x;
			_datas[ 27 ] = p3.y;
			
			_datas[ 28 ] = o.x;
			_datas[ 29 ] = o.y;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		override public function get width():Number { return _width }
		
		override public function set width(value:Number):void 
		{
			this._width = value;
			initDatas();
			render();
		}
		
		public function get length():Number { return _length; }
		
		public function set length(value:Number):void 
		{
			_length = value;
			initDatas();
			render();
		}
		
		override public function get height():Number { return _height; }
		
		override public function set height(value:Number):void 
		{
			_height = value;
			initDatas();
			render();
		}
		
	}
	
}