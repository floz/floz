
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
	import fr.tilzy.isometric.geom.IsoDrawing;
	import fr.tilzy.isometric.geom.IsoMath;
	import fr.tilzy.isometric.objects.IsoObject;
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
			
			initShape();
			
			super( material );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initShape():void
		{
			_commands = new Vector.<int>();
			_datas = new Vector.<Number>();
			
			var gp:GraphicsPath = IsoDrawing.getRectPath( 0, _length, _height, new Point3D( _width, 0, 0 ) );
			_commands = _commands.concat( gp.commands );
			_datas = _datas.concat( gp.data );
			
			gp = IsoDrawing.getRectPath( _width, 0, _height, new Point3D( 0, _length, 0 ) );
			_commands = _commands.concat( gp.commands );
			_datas = _datas.concat( gp.data );
			
			gp = IsoDrawing.getRectPath( _width, _length, 0, new Point3D( 0, 0, _height ) );
			_commands = _commands.concat( gp.commands );
			_datas = _datas.concat( gp.data );
			
			_commands.fixed = true;
			_datas.fixed = true;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		override public function get width():Number { return _width }
		
		override public function set width(value:Number):void 
		{
			this._width = value;
			initShape();
			//initDatas();
			render();
		}
		
		public function get length():Number { return _length; }
		
		public function set length(value:Number):void 
		{
			_length = value;
			initShape();
			render();
		}
		
		override public function get height():Number { return _height; }
		
		override public function set height(value:Number):void 
		{
			_height = value;
			initShape();
			render();
		}
		
	}
	
}