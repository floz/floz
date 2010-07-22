/**
 * Written by :
 * @author David Ronai
 */
package com.isoo.map 
{
	import flash.display.BitmapData;
	
	public class Tile 
	{
		
		public static const Width:uint = 64;
		public static const	Height:uint = 32;
		
		private var _flag:int;
		private var _height:int;
		private var _id:int;
		
		public function Tile() 
		{
			flag = Flag.WALKABLE;
			_height = 0;
			_id = 1;
		}		
		
		public function get walkable():Boolean { return Boolean(flag & Flag.WALKABLE); }
		
		public function set walkable(value:Boolean):void 
		{
			if( value )
				flag |= Flag.WALKABLE;
			else 
				flag &= ~Flag.WALKABLE;
		}
		
		public function get killable():Boolean { return Boolean(flag & Flag.KILLABLE); }
		
		public function set killable(value:Boolean):void 
		{
			if( value )
				flag |= Flag.KILLABLE;
			else 
				flag &= ~Flag.KILLABLE;
		}
		
		public function get visible():Boolean { return !Boolean(flag & Flag.VISIBLE); }
		
		public function set visible(value:Boolean):void 
		{
			if( !value )
				flag |= Flag.VISIBLE;
			else 
				flag &= ~Flag.VISIBLE;
		}
		
		public function get height():int { return _height; }	
		
		public function set height(value:int):void 
		{
			_height = value;
		}
		
		public function get flag():int { return _flag; }
		
		public function set flag(value:int):void 
		{
			_flag = value;
		}
		
		public function get id():int { return _id; }
		
		public function set id(value:int):void 
		{
			_id = value;
		}
		
	}
	
}