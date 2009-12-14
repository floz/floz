package com.bigarobas.display.layer {
	import com.bigarobas.display.GraphicSprite;
	import com.bigarobas.events.FullEventDispatcher;
	import com.bigarobas.superstatics.SuperDisplayObject;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	
	public class Layer extends FullEventDispatcher implements ILayer {
			
		protected var _ghost:GraphicSprite;
		protected var _bg:GraphicSprite;
		protected var _contentContainer:Sprite;
		protected var _content:LayerContent;
		protected var _fg:GraphicSprite;
		protected var _contentMask:GraphicSprite;
		
		protected var _paddingTop:Number = 0;
		protected var _paddingRight:Number = 0;
		protected var _paddingBottom:Number = 0;
		protected var _paddingLeft:Number = 0;
		
		protected var _marginTop:Number = 0;
		protected var _marginRight:Number = 0;
		protected var _marginBottom:Number = 0;
		protected var _marginLeft:Number = 0;
		
		protected var _x:Number = 0;
		protected var _y:Number = 0;
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		protected var _contentWidth:Number = 0;
		protected var _contentHeight:Number = 0;
		protected var _forcedWidth:Number = 0;
		protected var _forcedHeight:Number = 0;
		protected var _realWidth:Number = 0;
		protected var _realHeight:Number = 0;
		protected var _displayWidth:Number = 0;
		protected var _displayHeight:Number = 0;
		protected var _visibleWidth:Number = 0;
		protected var _visibleHeight:Number = 0;
		
		protected var _masked:Boolean = false;
		protected var _autoMask:String = LayerAutoMask.NONE;
		protected var _autoSize:String = LayerAutoSize.NONE;
		protected var _autoAnim:String = LayerAutoAnim.NONE;
		protected var _align:String = LayerAlign.NONE;
		protected var _alignMode:String = LayerAlignMode.NORMAL;
		
		protected var _mouseClickPoint:Point = new Point(0, 0);
		protected var _contentOrigin:Point = new Point(0, 0);
		
		protected var _needRedisplay:Boolean = false;
		
		protected var _maxScrollH:Number = 0;
		protected var _maxScrollV:Number = 0;
		protected var _scrollH:Number = 0;
		protected var _scrollV:Number = 0;
		
			
		public function Layer(vDisplayObject:DisplayObject=null) {
			
			_ghost = new GraphicSprite();
			_ghost.fillAlpha = 0;
			_ghost.lineThick = 0;
			
			_bg = new GraphicSprite();
			_contentContainer = new Sprite();
			_content = new LayerContent(this);
			_fg = new GraphicSprite();
			_fg.mouseChildren = false;
			_fg.mouseEnabled = false;
			
			_contentMask = new GraphicSprite();
			_contentMask.fillAlpha = 0;
			_contentMask.lineThick = 0;
			
			super.addChild(_bg);
			super.addChild(_contentContainer);
			_contentContainer.addChild(_content);
			super.addChild(_fg);
			super.addChild(_contentMask);
			
			addEventListener(LayerEvent.CONTENT_CHANGED, onContentChanged);
			addEventListener(LayerEvent.SIZE, onResize);
			addEventListener(LayerEvent.PLACE, onReplace);
			addEventListener(LayerEvent.MOVED, onMoved);
			addEventListener(LayerEvent.DISPLAYED, onDisplayed);
			
			addEventListener(MouseEvent.MOUSE_DOWN, registerClickPoint);
			//addEventListener(Event.ENTER_FRAME, onEnterFrameCheckRedisplay);
			
			if (vDisplayObject != null) addChild(vDisplayObject);
			else display();
		}
		
		private function onEnterFrameCheckRedisplay(e:Event):void {
			redisplay();
			needRedisplay = false;			
		}
		
		private function registerClickPoint(e:MouseEvent):void {
			_mouseClickPoint.x = mouseX;
			_mouseClickPoint.y = mouseY;
		}
		
		private function onResize(e:LayerEvent):void {
			e.stopImmediatePropagation();
			needRedisplay = true;
		}
		
		private function onReplace(e:LayerEvent):void {
			e.stopImmediatePropagation();
			needRedisplay = true;
		}
		
		private function onMoved(e:LayerEvent):void {
			e.stopImmediatePropagation();
			needRedisplay = true;
		}
		
		private function onContentChanged(e:LayerEvent):void {
			e.stopImmediatePropagation();
		}
		
		
		private function onDisplayed(e:LayerEvent):void {
			e.stopImmediatePropagation();
		}
		
		protected function display():void {
			
		}
		
		public function redisplay():void {
			size();
			place();
			drawMask();
			drawGhost();
			display();
			dispatchEvent(new LayerEvent(LayerEvent.DISPLAYED));
		}
		
		public function resize():void {
			//size();
			dispatchEvent(new LayerEvent(LayerEvent.SIZE));
		}
		
		public function replace():void {
			//place();
			dispatchEvent(new LayerEvent(LayerEvent.PLACE));
		}
		
		public function size():void {
			
			_contentWidth = _content.visibleWidth;
			_contentHeight = _content.visibleHeight;
			
			switch (_autoSize) {
				
				case LayerAutoSize.NONE :
					_displayWidth = _contentWidth;
					_displayHeight = _contentHeight;
					
					break;
					
				case LayerAutoSize.AUTO :
					_displayWidth = _contentWidth;
					_displayHeight = _contentHeight;
					break;
				
				case LayerAutoSize.CROP :
					_masked = true;
					_autoMask = LayerAutoMask.CROP;
					_displayWidth = _forcedWidth;
					_displayHeight = _forcedHeight;
					break;
				
				case LayerAutoSize.FIT :
					_content.width = _forcedWidth;
					_content.height = _forcedHeight;
					_contentWidth = _content.width;
					_contentHeight = _content.height;
					_displayWidth = _forcedWidth;
					_displayHeight = _forcedHeight;
					break;
					
				case LayerAutoSize.SCALE :
					var cwh:Number = _contentWidth / _contentHeight;
					var fwh:Number = _forcedWidth / _forcedHeight;
					var fwcw:Number =  _forcedWidth / _contentWidth;
					var fhch:Number = _forcedHeight / _contentHeight;
					var fillRect:Boolean = false;
					var s : Number = cwh >= fwh ? (fillRect ? fhch : fwcw) : (fillRect ? fwcw : fhch);
					_content.width = _contentWidth * s;
					_content.height = _contentHeight * s;
					_contentWidth = _content.width;
					_contentHeight = _content.height;
					_displayWidth = _contentWidth;
					_displayHeight = _contentHeight;
					break;
				
				default :
					_displayWidth = _contentWidth;
					_displayHeight = _contentHeight;
					break;
				
			}
			
			_width = _paddingLeft + _displayWidth + _paddingRight;
			_height = _paddingTop + _displayHeight + _paddingBottom;
	
		}
		
		public function place():void {
			
			switch (_alignMode) {
				
				case LayerAlignMode.NORMAL:
					
					switch (_align) {
						case LayerAlign.NONE:
							_contentOrigin.x = _paddingLeft;
							_contentOrigin.y = _paddingTop;
							break;
						case LayerAlign.TOP_LEFT:
							_contentOrigin.x = _paddingLeft;
							_contentOrigin.y = _paddingTop;
							break;
						case LayerAlign.TOP:
							_contentOrigin.x = (_forcedWidth - _displayWidth) / 2;
							_contentOrigin.y = _paddingTop;
							break;
						case LayerAlign.TOP_RIGHT:
							_contentOrigin.x = _forcedWidth - _displayWidth - _paddingRight;
							_contentOrigin.y = _paddingTop;
							break;
						case LayerAlign.LEFT:
							_contentOrigin.x = _paddingLeft;
							_contentOrigin.y = (_forcedHeight - _displayHeight) / 2;
							break;
						case LayerAlign.MIDDLE:
							_contentOrigin.x = (_forcedWidth - _displayWidth) / 2;
							_contentOrigin.y = (_forcedHeight - _displayHeight) / 2;
							break;
						case LayerAlign.RIGHT:
							_contentOrigin.x = _forcedWidth - _displayWidth - _paddingRight;
							_contentOrigin.y = (_forcedHeight - _displayHeight) / 2;
							break;
						case LayerAlign.BOTTOM_LEFT:
							_contentOrigin.x = _paddingLeft;
							_contentOrigin.y = _forcedHeight - _displayHeight - _paddingBottom;
							break;
						case LayerAlign.BOTTOM:
							_contentOrigin.x = (_forcedWidth - _displayWidth) / 2;
							_contentOrigin.y = _forcedHeight - _displayHeight - _paddingBottom;
							break;
						case LayerAlign.BOTTOM_RIGHT:
							_contentOrigin.x = _forcedWidth - _displayWidth - _paddingRight;
							_contentOrigin.y = _forcedHeight - _displayHeight - _paddingBottom;
							break;
						default:
							_align = LayerAlign.NONE;
							_contentOrigin.x = _paddingLeft;
							_contentOrigin.y = _paddingTop;
							break;
					}
						
					break;
					
				case LayerAlignMode.CENTERED:
					
					switch (_align) {
						case LayerAlign.NONE:
							_contentOrigin.x = -_width / 2;
							_contentOrigin.y = -_height / 2;
							break;
						case LayerAlign.TOP_LEFT:
							_contentOrigin.x = _paddingLeft;
							_contentOrigin.y = _paddingTop;
							break;
						case LayerAlign.TOP:
							_contentOrigin.x = -_width / 2;
							_contentOrigin.y = _paddingTop;
							break;
						case LayerAlign.TOP_RIGHT:
							_contentOrigin.x = -_width;
							_contentOrigin.y = _paddingTop;
							break;
						case LayerAlign.LEFT:
							_contentOrigin.x = _paddingLeft;
							_contentOrigin.y = -_height / 2;
							break;
						case LayerAlign.MIDDLE:
							_contentOrigin.x = -_width / 2;
							_contentOrigin.y = -_height / 2;
							break;
						case LayerAlign.RIGHT:
							_contentOrigin.x = -_width;
							_contentOrigin.y = -_height / 2;
							break;
						case LayerAlign.BOTTOM_LEFT:
							_contentOrigin.x = _paddingLeft;
							_contentOrigin.y = -_height;
							break;
						case LayerAlign.BOTTOM:
							_contentOrigin.x = -_width / 2;
							_contentOrigin.y = -_height;
							break;
						case LayerAlign.BOTTOM_RIGHT:
							_contentOrigin.x = -_width;
							_contentOrigin.y = -_height;
							break;
						default:
							_align = LayerAlign.NONE;
							_contentOrigin.x = -_width / 2;
							_contentOrigin.y = -_height / 2;
							break;
					}
				
					break;
					
					
			}
			
			
			var rx:Number = 0;
			var ry:Number = 0;
			switch (_alignMode) {
				case LayerAlignMode.NORMAL:
					rx = 0;
					ry = 0;
					break;
				case LayerAlignMode.CENTERED:
					rx = _width / 2;
					ry = _height / 2;
					break;
			}
			
			super.x = _x + rx;
			super.y = _y + ry;

			_contentContainer.x = _contentOrigin.x;
			_contentContainer.y = _contentOrigin.y;
			
			_bg.x = -rx;
			_bg.y = -ry;
			_fg.x = _bg.x;
			_fg.y = _bg.y;
			_ghost.x = _bg.x;
			_ghost.y = _bg.y;
			_contentMask.x = _contentOrigin.x;
			_contentMask.y = _contentOrigin.y;
			
			dispatchEvent(new LayerEvent(LayerEvent.PLACED));
			
		}
		
		private function drawMask():void {
			_contentMask.clear();
			if (_masked) {
				switch (_autoMask) {
					case (LayerAutoMask.CROP) :
					_contentMask.drawRect(_forcedWidth, _forcedHeight);
					_contentContainer.mask = _contentMask;
					break;
				}
				
			} else {
				_contentContainer.mask = null;
			}
			
		}
		
		private function drawGhost():void {
			_ghost.clear();
			_ghost.drawRect(_width, _height);
		}
		
		public function get bg():GraphicSprite { return _bg; }
		public function get fg():GraphicSprite { return _fg; }
		public function get content():LayerContent { return _content; }
		
		public function get paddings():Array { return [_paddingTop , _paddingRight , _paddingBottom , _paddingLeft]; }
		
		public function set paddings(value:Array):void {
			_paddingTop = value[0];
			_paddingRight = value[1];
			_paddingBottom = value[2];
			_paddingLeft = value[3];
			replace();
		}
		
		public function set padding(value:Number):void {
			_paddingTop = _paddingRight = _paddingBottom = _paddingLeft = value;
			replace();
		}
		
		public function get margins():Array { return [_marginTop , _marginRight , _marginBottom , _marginLeft];}
		
		public function set margins(value:Array):void {
			_marginTop = value[0];
			_marginRight = value[1];
			_marginBottom = value[2];
			_marginLeft = value[3];
			_needRedisplay = true;
		}
		
		public function set margin(value:Number):void {
			_marginTop = _marginRight = _marginBottom = _marginLeft = value;
			replace();
		}
		
		override public function get graphics():Graphics { return _content.graphics; }
		
		public function swapToFront(child:DisplayObject):void {
			if (child.parent==_content) {
				swapChildrenAt(getChildIndex(child), (numChildren - 1));
			}
		}
		
		public function swapToBack(child:DisplayObject):void {
			if (child.parent==_content) {
				swapChildrenAt(getChildIndex(child), 0);
			}
		}
		
		
		override public function addChild(child:DisplayObject):DisplayObject {
			_content.addChild(child);
			redisplay();
			dispatchEvent(new LayerEvent(LayerEvent.CONTENT_CHANGED));
			return(child);
		}
		
		override public function getChildIndex(child:flash.display.DisplayObject):int {
			return _content.getChildIndex(child);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			_content.removeChild(child);
			redisplay();
			dispatchEvent(new LayerEvent(LayerEvent.CONTENT_CHANGED));
			return(child);
		}
		
		override public function removeChildAt(id:int):DisplayObject {
			var d:DisplayObject = _content.removeChildAt(id);
			redisplay();
			dispatchEvent(new LayerEvent(LayerEvent.CONTENT_CHANGED));
			return(d);
		}
		
		override public function getChildAt(index:int):flash.display.DisplayObject {
			return _content.getChildAt(index);
		}
		
		override public function getChildByName(name:String):flash.display.DisplayObject {
			return _content.getChildByName(name);
		}
		
		override public function swapChildren(child1:flash.display.DisplayObject, child2:flash.display.DisplayObject):void {
			_content.swapChildren(child1, child2);
		}
		
		override public function swapChildrenAt(index1:int, index2:int):void {
			_content.swapChildrenAt(index1, index2);
		}
		
		
		override public function get numChildren():int {
			return (_content.numChildren);
		}
		
		//##################################################################
		//##################################################################
		
		override public function get width():Number {
			return _width;
			//return visibleWidth;
		}
		
		override public function get height():Number {
			return _height;
			//return visibleHeight;
		}
		
		
		override public function set width(value:Number):void {
			_forcedWidth = value;
			resize();
		}
		
		override public function set height(value:Number):void {
			_forcedHeight = value;
			resize();
		}
		
		public function get visibleWidth():Number { 
			_visibleWidth = _paddingLeft + _paddingRight;
			if (_masked) {
				_visibleWidth+=SuperDisplayObject.getVisibleRect(_contentContainer).width;
			} else {
				_visibleWidth += _content.visibleWidth;
			}
			
			return _visibleWidth;
			
		}
		public function get visibleHeight():Number { 
			_visibleHeight = _paddingTop + _paddingBottom;
			
			if (_masked) {
				_visibleHeight+=SuperDisplayObject.getVisibleRect(_contentContainer).height;
			} else {
				_visibleHeight += _content.visibleHeight;
			}
			
			return _visibleHeight; 
		
		}
		
		public function getVisibleRect():Rectangle {
			var r:Rectangle = SuperDisplayObject.getVisibleRect(_contentContainer, this);
			r.width += _paddingLeft + _paddingRight;
			r.height += _paddingTop + _paddingBottom;
			return (r);
		}
		
		public function get autoSize():String { return _autoSize; }
		
		public function set autoSize(value:String):void {
			_autoSize = value;
			resize();
		}
		public function get realWidth():Number { return super.width; }
		
		public function set realWidth(value:Number):void {
			_realWidth = value;
			super.width = _realWidth;
		}
		
		public function get realHeight():Number { return super.height; }
		
		public function set realHeight(value:Number):void {
			_realHeight = value;
			super.height = _realHeight;
		}
		
		
		
		
		//##################################################################
		//##################################################################
		
		override public function set x(value:Number):void {
			_x = value;
			dispatchEvent(new LayerEvent(LayerEvent.MOVED));
		}
		
		override public function set y(value:Number):void {
			_y = value;
			dispatchEvent(new LayerEvent(LayerEvent.MOVED));
		}
		
		override public function get x():Number {
			return _x;
		}
		
		override public function get y():Number {
			return _y;
		}
		
		public function get mouseClickPoint():Point { return _mouseClickPoint; }
		
		//##################################################################
		//##################################################################
		
		public function get masked():Boolean { return _masked; }
		
		public function set masked(value:Boolean):void {
			_masked = value;
		}
		
		public function get align():String { return _align; }
		
		public function set align(value:String):void {
			_align = value;
			replace();
		}
		
		public function get alignMode():String { return _alignMode; }
		
		public function set alignMode(value:String):void {
			_alignMode = value;
			replace();
		}
		
		
		
		public function get maxScrollH():Number { 
			_maxScrollH = _content.visibleWidth - _forcedWidth;
			return _maxScrollH; 
		}
		
		public function get maxScrollV():Number { 
			_maxScrollV = _content.visibleHeight - _forcedHeight;
			return _maxScrollV; 
		}
		
		public function get scrollH():Number { return _scrollH; }
		
		public function set scrollH(value:Number):void {
			_scrollH = value;
			_content.x = - scrollH * maxScrollH;
		}
		
		public function get scrollV():Number { return _scrollV; }
		
		public function set scrollV(value:Number):void {
			_scrollV = value;
			_content.y = - scrollV * maxScrollV;
		}
		
		public function get needRedisplay():Boolean { return _needRedisplay; }
		
		public function set needRedisplay(value:Boolean):void {
			_needRedisplay = value;
			if (_needRedisplay) {
				addEventListener(Event.ENTER_FRAME, onEnterFrameCheckRedisplay);
			} else {
				removeEventListener(Event.ENTER_FRAME, onEnterFrameCheckRedisplay);
			}
		}
		
	
		
		
		
		public function empty():int {
			var n:int = numChildren;
			while (numChildren) removeChildAt(0);
			return(n);
		}
		
		public function drawRulers():void {
			var w:Number = _forcedWidth;
			var h:Number = _forcedHeight;
			fg.drawGride(w, h, 20, 20);
		}

	}
	
}