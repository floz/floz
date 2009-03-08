
package havas.tools
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.system.System;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	import flash.system.Capabilities;
	import flash.utils.getTimer;

	public class FPS extends Sprite
	{
		private var _width:uint;
		private var _height:uint;
		private var time:uint;
		private var count:uint;
		private var interval:uint;
		private var avrTotal:uint;
		private var avrCount:uint;
		private var avrInterval:uint = 10;
		private var memory:uint;
		private var bd:BitmapData;
		private var background:Bitmap;
		private var graph:Bitmap;
		private var rect:Rectangle;
		private var fps:TextField;
		private var avr1:TextField;
		private var avr2:TextField;
		private var mem:TextField;
		private var prevFps:int;
		private var prevMem:int;
		private var scroll:uint = 2;
		
		public function FPS(width:uint = 250,
							height:uint = 54,
							interval:uint = 10,
							dark:Boolean = true,
							memory:uint = 100) 
		{
			_width = Math.min(Math.max(width, 100), 530);
			_height = Math.min(Math.max(height, 54), 380);
			this.interval = Math.min(Math.max(interval, 5), 100);
			if (Capabilities.playerType == "PlugIn") memory += 80;
			this.memory = Math.min(Math.max(memory * 0x100000, 50 * 0x100000), 500 * 0x100000);
			
			x = 10;
			y = 10;
			
			var tmp:BitmapData = new BitmapData(_width, _height, true, 0xff000000);
			rect = new Rectangle(1, 1, _width - 2, _height - 2);
			tmp.fillRect(rect, dark ? 0xb3000000 : 0x1a000000);
			background = new Bitmap(tmp);
			
			addChild(background);
			
			var infos:Sprite = new Sprite();
			infos.x = infos.y = 1;
			infos.graphics.beginFill(0);
			infos.graphics.drawRect(0, 0, 48, 37);
			
			fps = new TextField();
			var fps2:TextField = new TextField();
			avr1 = new TextField();
			avr2 = new TextField();
			mem = new TextField();
			var mem2:TextField = new TextField();
			
			var tf:TextFormat = new TextFormat("Tahoma", 10, 0x00ff00);
			fps.defaultTextFormat = fps2.defaultTextFormat = avr1.defaultTextFormat = avr2.defaultTextFormat = tf;
			avr2.textColor = 0x008000;
			tf.color = 0xff0000;
			mem.defaultTextFormat = mem2.defaultTextFormat = tf;
			
			fps.selectable = fps2.selectable = avr1.selectable = avr2.selectable = mem.selectable = mem2.selectable = false;
			fps.width = avr1.width = mem.width = 28;
			fps.autoSize = mem.autoSize = avr1.autoSize = TextFieldAutoSize.RIGHT;
			fps2.autoSize = mem2.autoSize = avr2.autoSize = TextFieldAutoSize.LEFT;
			fps2.x = mem2.x = avr2.x = 27;
			fps.y = fps2.y = -1;
			avr1.y = avr2.y = 10;
			mem.y = mem2.y = 21;
			fps.text = mem.text = "0.0";
			avr1.text = "---";
			avr2.text = "0";
			fps2.text = "Fps";
			mem2.text = "Mb";
			
			infos.addChild(fps);
			infos.addChild(fps2);
			infos.addChild(avr1);
			infos.addChild(avr2);
			infos.addChild(mem);
			infos.addChild(mem2);
			
			bd = new BitmapData(_width - 2, _height - 2, true, 0);
			graph = new Bitmap(bd);
			graph.x = graph.y = 1;
			addChild(graph);
			
			prevFps = bd.height - 1;
			prevMem = bd.height - 1;
			rect.x = bd.width - scroll;
			rect.y = 0;
			rect.width = scroll;
			rect.height = bd.height;
			
			addChild(infos);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		// EVENT
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(MouseEvent.MOUSE_UP, onUp);
			addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addEventListener(Event.ENTER_FRAME, onFrame);
			
			doubleClickEnabled = true;
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			removeEventListener(MouseEvent.MOUSE_UP, onUp);
			removeEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			removeEventListener(Event.ENTER_FRAME, onFrame);
			
			background.bitmapData.dispose();
			graph.bitmapData.dispose();
		}
		
		private function onFrame(e:Event):void 
		{
			if (++count >= interval)
			{
				var f:Number = ((1000 * count) / (getTimer() - time));
				fps.text = f.toFixed(1);
				count = 0;
				time = getTimer();
				
				mem.text = "" + (System.totalMemory / 0x100000).toFixed(1);
				
				//
				
				bd.scroll(-scroll, 0);
				bd.fillRect(rect, 0xffff00ff);
				
				// ratio fps
				var rf:Number = Math.min(1, f / stage.frameRate);
				var nextFps:int = (1 - rf) * (bd.height - 1);
				trace( "nextFps : " + nextFps );
				line(bd.width - scroll, prevFps, bd.width - 1, nextFps, 0xff00ff00);
				trace( "prevFps : " + prevFps );
				prevFps = nextFps;
				
				// ratio memory
				var rm:Number = Math.min(1, System.totalMemory / memory);
				var nextMem:int = (1 - rm) * (bd.height - 1);
				line(bd.width - scroll, prevMem, bd.width - 1, nextMem, 0xffff0000);
				prevMem = nextMem;
				
				avrTotal += f;
				if (++avrCount >= avrInterval)
				{
					var i:int = int(avr2.text) + 1;
					avr1.text = String((avrTotal / avrInterval).toFixed(1));
					avr2.text = String(i < 1000 ? i : 1);
					avrCount = avrTotal = 0;
				}
			}
		}
		
		private function onDown(e:MouseEvent):void 
		{
			startDrag();
		}
		
		private function onUp(e:MouseEvent):void 
		{
			stopDrag();
		}
		
		private function onDoubleClick(e:MouseEvent):void 
		{
			parent.removeChild(this);
		}
		
		// PRIVATE
		
		private function line(x0:int,
							  y0:int,
							  x1:int,
							  y1:int,
							  c:uint):void
		{
			var dx:int;
			var dy:int;
			var i:int;
			var xinc:int;
			var yinc:int;
			var cumul:int;
			var x:int;
			var y:int;
			//var bd:BitmapData = graph.bitmapData;
			x = x0;
			y = y0;
			dx = x1 - x0;
			dy = y1 - y0;
			xinc = (dx > 0) ? 1 : -1;
			yinc = (dy > 0) ? 1 : -1;
			dx = Math.abs(dx);
			dy = Math.abs(dy);
			
			bd.setPixel32(x, y, c);
			
			if ( dx > dy ) {
				cumul = dx / 2 ;
		  		for ( i = 1 ; i <= dx ; i++ ){
					x += xinc;
					cumul += dy;
					if (cumul >= dx) {
			  			cumul -= dx;
			  			y += yinc;
					}
					bd.setPixel32(x, y, c);
				}
			}else {
		  		cumul = dy / 2;
		  		for ( i = 1 ; i <= dy ; i++ ){
					y += yinc;
					cumul += dx;
					if ( cumul >= dy ) {
						cumul -= dy;
			  			x += xinc ;
					}
					bd.setPixel32(x, y, c);
				}
			}
		}
	}
}




