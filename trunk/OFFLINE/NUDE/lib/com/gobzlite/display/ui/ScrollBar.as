package com.gobzlite.display.ui
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Rectangle; 
	import flash.text.TextField;
	
	/**
	 * Simple Scrollbar with blur effect based on various net source
	 * 
	 * ----------------------
	 * Code Sample :
	 * var sb:Scrollbar = Scrollbar.make( 350, 6 );
	 * sb.attach( content, mask);
	 * addChild( sb );
	 * ----------------------
	 * 
	 * @author: David Ronai
	 * @version: 1.0
	 */
	public class ScrollBar extends Sprite
	{
		
		private var _content:DisplayObject;
		private var _mask:DisplayObject;
		private var _ruler:Sprite; 
		private var _background:DisplayObject;
		
		private var _blurred:Boolean; 
		private var _yFactor:Number; 
		
		private var _oldHeight:Number;
		
		private var minY:Number;
		private var maxY:Number;
		public var percentuale:Number;
		private var contentstarty:Number; 
		private var bf:BlurFilter;
		private var isDragable:Boolean;
		
		/**
		 * Create a new scrollbar
		 * 
		 * @param	ruler ruller design
		 * @param	background scrollbar background
		 * @param	blurred added blur effect on scroll
		 * @param	yFactor power of blur effect
		 */
		public function ScrollBar(ruler:Sprite, background:DisplayObject, blurred:Boolean = true, yFactor:Number = 4 )
		{
			_ruler = ruler; 
			_background = background;
			_blurred = blurred; 
			_yFactor = yFactor;			
			
			_ruler.x = _background.x;
			_ruler.y = _background.y;
			_ruler.buttonMode = true; 
			
			addChild( background );
			addChild( ruler );
		}
		
		/**
		 * Create a new Scrollbar
		 * 
		 * @return a new scrollbar ready to use
		 */
		public static function make( height:uint, width:int, rullerColor:uint = 0xFFFFFF, backgroundColor:uint = 0xCCCCCC, blurred:Boolean = true, yFactor:Number = 4):ScrollBar 
		{
			
			var background:Shape = new Shape();
			background.graphics.beginFill( backgroundColor );
			background.graphics.drawRect( 0, 0, width, height );
			background.graphics.endFill();
			
			var ruler:Sprite = new Sprite();
			ruler.graphics.beginFill( rullerColor );
			ruler.graphics.drawRect(0, 0, width, height/10);
			ruler.graphics.endFill();
			
			return new ScrollBar( ruler, background, blurred, yFactor );
		}
		
		/**
		 * Attach the scrollbar to content and mask
		 * @param	content
		 * @param	mask
		 */
		public function attach(content:DisplayObject, mask:DisplayObject):void 
		{
			
			_content = content; 			
			//_content.cacheAsBitmap = true; 
			_oldHeight = _content.height;
			
			_mask = mask; 
			_content.mask = _mask; 
			
			bf = new BlurFilter(0, 0, 1);			
			_content.filters = new Array(bf);			
			
			contentstarty = _content.y;
			
			if( stage )
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null) : void 
		{
			_ruler.addEventListener(MouseEvent.MOUSE_DOWN, clickHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, releaseHandler); 
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, wheelHandler, true);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			addEventListener(Event.REMOVED, removeHandler);
		}
		
		private function clickHandler( e:MouseEvent ):void 
		{
			if ( !isDragable )
				return;
			var rect:Rectangle = new Rectangle(_background.x, minY, 0, maxY);
			_ruler.startDrag(false, rect);
		}
		
		private function releaseHandler( e:MouseEvent ):void 
		{
			_ruler.stopDrag();
		}
		
		private function wheelHandler( e:MouseEvent ):void 
		{
			if ( isDragable && _content.stage && _mask.hitTestPoint(_content.stage.mouseX, _content.stage.mouseY))
				scrollData(e.delta*3);
		}
		
		private function enterFrameHandler( e:Event ):void 
		{
			positionContent();
		}
		
		private function scrollData( q:int ):void 
		{
			var d:Number;
			var rulerY:Number;
			
			var quantity:Number = _ruler.height / 5; 

			d = -q * Math.abs(quantity); 
	
			if (d > 0)
				rulerY = Math.min(maxY, _ruler.y + d);
			else if (d < 0) 
				rulerY = Math.max(minY, _ruler.y + d);
			
			_ruler.y = rulerY; 
		}
		
		/**
		 * Work to every frame : Move the content :)
		 */
		public function positionContent():void 
		{
			
			//_ruler.height = (_mask.height / _content.height) * _background.height;
			
			maxY =_background.height - _ruler.height;
			minY = _background.y;
			
 			if (_ruler.y > maxY){
				_ruler.y = maxY; 
			}
			
			//Draguable ?
			isDragable = _content.height > _mask.height;

			//Draguable 
			_ruler.visible = isDragable;
			_background.visible = isDragable;

			
			percentuale = Math.round((100 / maxY) * _ruler.y);
			if ( percentuale > 100 )
				percentuale = 0;
			
			var downY:Number = _content.height - (_mask.height / 2);
				
			var finalY:Number = contentstarty - (((downY - (_mask.height/2)) / 100) * percentuale);			
			
			if ( _oldHeight != _content.height){
				_oldHeight = _content.height;
			} else if (_content.y != finalY) {
				var diff:Number = finalY-_content.y;
				_content.y += diff / _yFactor; 
				
				var bfactor:Number = Math.abs(diff)/8; 
				bf.blurY = bfactor/2;
				if (_blurred == true) {
					_content.filters = new Array(bf);
				}
			}
		}
		
		/**
		 * Remove all listener and link to other object.
		 * @param	e
		 */
		private function removeHandler(e:Event):void 
		{	
			_ruler.removeEventListener(MouseEvent.MOUSE_DOWN, clickHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, releaseHandler); 
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL, wheelHandler, true);
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			removeEventListener(Event.REMOVED, removeHandler);
			
			_content = null;
			_mask = null;
			_ruler = null; 
			_background = null;
			bf = null;
		}
		
		public function onMax():void
		{
			_ruler.y = _background.height - _ruler.height;
		}
	}
}