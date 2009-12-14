package com.bigarobas.display.screen {
	import com.bigarobas.display.layer.Layer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class BitmapScreen extends Screen {
		protected var _bitmap:Bitmap;
		protected var _source:DisplayObject;
		protected var _frequenceMode:String;
		protected var _sourceMode:String;
		
		public static const SOURCE_BITMAP_DATA:String = "source_bitmap_data";
		public static const SOURCE_DRAWABLE_MODEL:String = "source_drawable_model";
		public static const SOURCE_NONE:String = "source_none";
		
		public function BitmapScreen(vWidth:Number=100,vHeight:Number=100) {
							
			_bitmap = new Bitmap(new BitmapData(vWidth, vHeight));
			addEventListener(Event.ENTER_FRAME, onEnterFrameRendering);
			addChild(_bitmap);
			
		}
		
		private function onEnterFrameRendering(e:Event):void {
			render();
		}
		
		public function render():void {
			switch (_sourceMode) {
				case SOURCE_DRAWABLE_MODEL:
					if (_source.width>0 && _source.height>0) {
						_bitmap.bitmapData.dispose();
						_bitmap.bitmapData = new BitmapData(_source.width, _source.height);
						_bitmap.bitmapData.draw(_source);
					}
					break;
			}
		}
		public function get bitmap():Bitmap { return _bitmap; }
		
		public function get bitmapdata():BitmapData { return _bitmap.bitmapData; }
		
		public function set bitmapdata(value:BitmapData):void {
			_bitmap.bitmapData = value;
			_sourceMode = SOURCE_BITMAP_DATA;
		}
		
		public function get source():DisplayObject { return _source; }
		
		public function set source(value:DisplayObject):void {
			_source = value;
			_sourceMode = SOURCE_DRAWABLE_MODEL;
		}
		
		
		
	}
	
}