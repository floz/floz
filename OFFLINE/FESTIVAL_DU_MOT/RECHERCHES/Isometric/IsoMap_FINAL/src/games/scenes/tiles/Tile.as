
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package games.scenes.tiles 
{
	import flash.display.Sprite;
	
	public class Tile extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _size:int;
		protected var _color:uint = 0xff000000;
		
		protected var _wireframeMode:Boolean = true;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Tile( size:int ) 
		{
			this.size = size;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function build():void
		{
			// HAS TO BE OVERRIDED
		}
		
		protected function destroy():void
		{
			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get color():uint { return _color; }
		
		public function set color( value:uint ):void 
		{
			_color = value;
			if ( _wireframeMode ) build();
		}
		
		public function get size():int { return _size; }
		
		public function set size(value:int):void 
		{
			_size = value;
			if( _wireframeMode ) build();
		}
		
		public function get wireframeMode():Boolean { return _wireframeMode; }
		
		public function set wireframeMode(value:Boolean):void 
		{
			_wireframeMode = value;
			if ( !_wireframeMode )
				destroy();
			else
				build();
		}
		
	}
	
}