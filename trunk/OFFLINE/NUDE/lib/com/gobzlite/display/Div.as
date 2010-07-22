package com.gobzlite.display
{
	import com.gobzlite.utils.align;
	import com.gobzlite.utils.align.Align;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * Inspired by HTML Div :
	 * 
	 * Improve Sprite with autoPlacement, AutoResize, Background, Width %, padding, margin, etc ...
	 * 
	 * ------------------------
	 * + synthax
	 * ------------------------
	 * 
	 * var div:Div = new Div();
	 * var div:Div = Div.factory.align( );
	 * 
	 * addChild( div );
	 * 
	 * div.align( ... );
	 * div.padding( ... );
	 * div.margin( ... );
	 * 
	 * div.vertical( ... );
	 * div.horizontal( ... );
	 * div.sort( "vertical"||"horizontal"||"none" );
	 * div.unsort( ... );
	 * 
	 * div.height( ... );
	 * div.width( ... );
	 * 
	 * div.background( ... );
	 * 
	 * div.autoResize( ... );
	 * 
	 * 
	 * -----------------------
	 * + chainAction
	 * -----------------------
	 * 
	 * div.align( Align.CENTER, true ).setHeight( ... ).vertical( ... );
	 * 
	 * @version 0.3 fix resize bug
	 * @version 0.2 change synthax
	 * @version 0.1 first implementation
	 * 
	 * @author DavidRonai
	 */
	public class Div extends Sprite
	{
		
		// - PRIVATE VAR -------------------------------------------------------------------
		
		//Align content vertically or horizontally
		public static const NONE:int 			= 	0x000000;
		public static const VERTICAL:int 		=	0x000001;
		public static const HORIZONTAL:int 		=	0x000002;
		private var _alignContent:int;
		private var _alignPadding:int;
		
		//Background
		private var _backgroundColor:int;
		private var _backgroundAlpha:Number;
		
		//padding
		private var _paddingTop:Number;
		private var _paddingBottom:Number;
		private var _paddingLeft:Number;
		private var _paddingRight:Number;
		
		//dimension
		private var _width:int;
		private var _height:int;
		
		//if width and height is in percent
		private var _widthPercent:Boolean;
		private var _heightPercent:Boolean;
		private var _widthAuto:Boolean;
		private var _heightAuto:Boolean;
		
		//div position 
		private var _position:int;
		private var _onStage:Boolean;
		
		
		// - CONSTRUCTOR ------------------------------------------------------------------		
	
		
		/**
		 * Create a new div
		 * 
		 * @param	width	can be a string as "100%" or an int as 100
		 * @param	height	can be a string as "100%" or an int as 100
		 */
		public function Div( width:* = "auto", height:* = "auto"  ) 
		{
			size( width, height );
			autoResize();
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		
		
		// - PRIVATE HANDLERS --------------------------------------------------------------------
		
		
		
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedStage );
			
			if ( !Resize.hasStage )
				Resize.stage(stage);
			
			resize();
		}
		
		private function onRemovedStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedStage);
			Resize.remove( this );
		}
		
		
		
		// - PUBLIC METHOD ---------------------------------------------------------------------
		
		
		/**
		 * align div 
		 * 
		 * @param	position align position
		 * @param	onStage	True if you want the div align beside the stage else div resize in his parent
		 * @return Current div
		 */
		public function position( position:int = Align.NONE, onStage:Boolean = false):Div
		{
			_position = position;
			_onStage = onStage;
			return this;
		}
		
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		// align content vertically , horizontally or not
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		public function vertical( verticalPadding:int ):Div
		{
			_alignContent = VERTICAL;
			_alignPadding = verticalPadding;
			return this;
		}
		public function horizontal( horizontalPadding:int ):Div
		{
			_alignContent = HORIZONTAL;
			_alignPadding = horizontalPadding;
			return this;
		}
		public function sort( type:int = NONE, padding:int = 0 ):Div
		{
			_alignPadding = type;
			_alignPadding = padding;
			return this;
		}
		public function unsort():Div
		{
			_alignContent = NONE;
			return this;
		}
		
		//xxxxxxxxxxxxxxxxxxxxxxxxx
		// setHeight & setWidth
		//xxxxxxxxxxxxxxxxxxxxxxxxx
		
		/**
		 * Define object size
		 * 
		 * @param	width	can be a string as "100%" or an int as 100
		 * @param	height	can be a string as "100%" or an int as 100
		 * @return	Current div
		 */
		public function size(width:*, height:*):Div
		{
			setWidth( width );
			setHeight( height );
			return this;
		}
		
		/**
		 * Define width
		 * 
		 * @param	value	can be a string as "100%" or an int as 100
		 * @return	Current div
		 */
		public function setWidth( value:* ):Div
		{
			
			_widthAuto = false;
			
			if ( value is int || value is uint || value is Number ) {
				_width = value as int;
				_widthPercent = false;
			}
			else if ( value is String ) 
			{
				var str:String = value as String;
				
				if ( str == "auto") {
					_widthAuto = true;
					return resize();
				}
				
				if ( str.charAt(str.length - 1) == "%" ) 
				{
					_width = int(str.slice(0, str.length - 1));
					_widthPercent = true;
				}
				else {
					_width = int(str);
					_widthPercent = false;
				}
					
			} else {
				_width = 0;
				_widthPercent = false;
			}
			return resize();
		}
		
		/**
		 * Define height
		 * 
		 * @param	value	can be a string as "100%" or an int as 100
		 * @return	Current div
		 */
		public function setHeight( value:* ):Div
		{
			
			_heightAuto = false;
			
			if ( value is int || value is uint || value is Number ) {
				_height = value as int;
				_heightPercent = false;
			}
			else if ( value is String ) 
			{
				var str:String = value as String;
				if ( str == "auto") {
					_heightAuto = true;
					return resize();
				}
				if ( str.charAt(str.length - 1) == "%" ) 
				{
					_height = int(str.slice(0, str.length - 1));
					_heightPercent = true;
				}
				else {
					_height = int(str);
					_heightPercent = false;
				}
					
			} else {
				_height = 0;
				_heightPercent = false;
			}
			return resize();
		}
		
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		// Resize
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		
		public function resize():Div 
		{
			// Align content vectically or horizontally
			switch ( _alignContent ) 
			{
				case Div.HORIZONTAL : 
					align(this).horizontal( _alignPadding );
					break;
					
				case Div.VERTICAL : 
					align(this).vertical( _alignPadding );
					break;
					
				default : 
				case Div.NONE :
					break;
			}
			
			//redraw Background
			draw();
			
			// Align the div
			if( _onStage )
				align(this).toStage( _position );
			else 
				align(this).to( _position );
			
			return this;
		}
		
		/**
		 * AutoResize
		 * 
		 * @param value	True for auto resize else false 
		 * @return Current div
		 */
		public function autoResize(value:Boolean=true):Div 
		{
			if ( value )
				Resize.add(this);
			else
				Resize.remove(this);
			
			return this;
		}
		
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		// Background
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		
		/**
		 * Set background style, if empty remove background
		 * 
		 * @param	color background color
		 * @param	alpha background alpha
		 * @return
		 */
		public function background(color:int = -1, alpha:Number = 1):Div 
		{
			_backgroundColor = color;
			_backgroundAlpha = alpha;
			
			return this;
		}
		
		private function draw():void
		{
			graphics.clear();
			
			if ( _backgroundColor < 0 )
				return;
			
			graphics.beginFill( _backgroundColor, _backgroundAlpha);
			graphics.drawRect( 0, 0, width, height);
			graphics.endFill();
		}
		
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		// set padding and margin inpired by html
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx		
		
		/**
		 * Set padding same HTML BlockObject 
		 * 
		 * ---------------------------------------
		 * - padding( all );
		 * - padding( top&bottom, right&left );
		 * - padding( top, right, bottom, left );
		 * ---------------------------------------
		 * 
		 * @param	top top value
		 * @param	right same as top value if is NaN
		 * @param	bottom same as top value if is NaN
		 * @param	left same as right value if is NaN
		 */
		public function padding( top:Number, right:Number = NaN, bottom:Number = NaN, left:Number = NaN ):Div 
		{	
			if ( isNaN(right) ){
				right = left = bottom = top;
			} else if ( isNaN(bottom) || isNaN(left) ){
				bottom = top;
				left = right;
			}
			
			_paddingTop = top;
			_paddingBottom = bottom;
			_paddingLeft = left;
			_paddingRight = right;
			
			return this;
		}
		
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		// override get width & get height
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		override public function get width():Number 
		{
			if ( _widthAuto )
				return super.width;
			
			if ( _widthPercent && parent ) {
				if ( parent is Stage )
					return (parent as Stage).stageWidth * _width / 100;
				else 
					return parent.width * _width / 100;
			}
			
			return _width;
		}
		override public function get height():Number 
		{ 
			if ( _heightAuto )
				return super.height;
				
			if ( _heightPercent && parent ) {
				if ( parent is Stage )
					return (parent as Stage).stageHeight * _height / 100;
				else 
					return parent.height * _height / 100;
			}
			
			return _height;
		}
		
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		// override set width & set height
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		override public function set width(value:Number):void 
		{			
			_width = value;
			resize();
		}		
		override public function set height(value:Number):void 
		{
			_height = value;
			resize();
		}
		
		
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxx
		// override addChild
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxx
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			var child:DisplayObject = super.addChild(child);
			resize();
			return child;
		}
		
		
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxx
		//  width and height percent
		//xxxxxxxxxxxxxxxxxxxxxxxxxxxx		
		public function get widthPercent():Number { return width; }		
		public function set widthPercent(value:Number):void 
		{
			_width = value;
			_widthPercent = true;
			resize();
		}
		
		
		public function get heightPercent():Number { return height; }		
		public function set heightPercent(value:Number):void 
		{
			_height = value;
			_heightPercent = true;
			resize();
		}
		
		/**
		 * Remove div from parent, listener, and Resize manager. 
		 * @return the div
		 */
		public function dispose():Div
		{
			Resize.remove( this );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedStage );
			removeEventListener( Event.ADDED_TO_STAGE, onStage);
			
			if ( parent )
				parent.removeChild( this );
				
			return this;
		}
		
		
		// - STATIC METHOD -----------------------------------------------------------------
		
		
		/**
		 * Create and return new Div instance.
		 * 
		 * @usage	Div.factory.align(...).size(...).etc(...)
		 * @return  a new Div
		 */
		public static function get factory():Div
		{
			return new Div();
		}
	}
}