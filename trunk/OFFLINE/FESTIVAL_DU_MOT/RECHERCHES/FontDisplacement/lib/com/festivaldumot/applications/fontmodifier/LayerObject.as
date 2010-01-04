
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.festivaldumot.applications.fontmodifier 
{
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class LayerObject extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _basePath:Vector.<Point>;
		private var _shape:Shape;
		private var _debugLigne:Sprite;
		private var _g:Graphics;
		
		private var _commands:Vector.<int>;
		private var _path:Vector.<Number>;
		private var _centerPoint:Point = new Point();
		
		private var _baseX:Number;
		private var _baseY:Number;
		
		private var _isMoving:Boolean;
		
		private var _marks:Sprite;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function LayerObject( path:Vector.<Point> ) 
		{
			_marks = new Sprite();
			
			this.path = path;
			
			_shape = new Shape();
			_g = _shape.graphics;
			addChild( _shape );
			
			_debugLigne = new Sprite();
			addChild( _debugLigne );
			
			addChild( _marks );
			
			addCenter();
			
			initPath();
			draw();
			
			cacheAsBitmap = true;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function enterFrameHandler(e:Event):void 
		{
			onMove();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function addCenter():void
		{
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.beginFill( 0x44cc44 );
			g.drawCircle( 0, 0, 1 );
			addChild( s );
		}
		
		private function initPath():void
		{
			var i:int = 1;
			var n:int = _path.length;
			
			_commands = new Vector.<int>( n, true );
			_commands[ 0 ] = GraphicsPathCommand.MOVE_TO;
			for ( i; i < n; ++i )
				_commands[ i ] = GraphicsPathCommand.LINE_TO;
		}
		
		private function draw( color:uint = 0x000000 ):void
		{
			_g.clear();
			_g.beginFill( color );			
			_g.drawPath( _commands, _path );
			_g.endFill();		
			
			while ( _marks.numChildren ) _marks.removeChildAt( 0 );
			
			var n:int = _path.length;
			for ( var i:int; i < n; i += 2 )
				addMark( _path[ i ], _path[ i + 1 ] );
		}
		
		private function onMove():void
		{
			var dx:Number = ( stage.mouseX - _centerPoint.x ) / scaleX;
			var dy:Number = ( stage.mouseY - _centerPoint.y ) / scaleY;
			
			var vx:Number = dx * .7;
			var vy:Number = dy * .7;
			_centerPoint.x += vx;
			_centerPoint.y += vy;
			
			//var d:Vector.<Number> = new Vector.<Number>( _path.length, true );
			//var n:int = d.length;
			//for ( var i:int; i < n; i += 2 )
			//{
				//_path[ i ] += _centerPoint.x;// _centerPoint.x;
				//_path[ i + 1 ] += _centerPoint.y;
			//}
			
			this.x = _centerPoint.x;
			this.y = _centerPoint.y;
			
			_g.clear();
			_g.beginFill( 0x000000 );			
			_g.drawPath( _commands, _path );
			_g.endFill();		
			
			var g:Graphics = _debugLigne.graphics;
			g.clear();
			g.lineStyle( .5, 0xffcc00 );
			g.moveTo( 0, 0 );
			g.lineTo( dx, dy );
			g.endFill();
		}
		
		private function addMark( px:Number, py:Number ):void
		{
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.beginFill( 0xff00ff );
			g.drawCircle( 0, 0, .5 );
			g.endFill();
			_marks.addChild( s );
			
			_marks.cacheAsBitmap = true;
			
			s.x = px;
			s.y = py;
		}
		
		private function convertPath():void
		{
			var j:int;
			var n:int = _basePath.length << 1;
			_path = new Vector.<Number>( n, true );
			
			for ( var i:int; i < n; i += 2 )
			{
				_path[ i ] = _basePath[ j ].x;
				_path[ i + 1 ] = _basePath[ j ].y;
				
				addMark( _path[ i ], _path[ i + 1 ] );
				
				++j;
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function startMove():void
		{			
			_isMoving = true;
			
			_centerPoint.x = this.x;
			_centerPoint.y = this.y;
			
			cacheAsBitmap = false;
			addEventListener( Event.ENTER_FRAME, enterFrameHandler, false, 0, true );
		}
		
		public function stopMove():void
		{
			_isMoving = false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function set path( value:Vector.<Point> ):void
		{
			_basePath = value;
			convertPath();
		}
		public function get path():Vector.<Point> { return _basePath; }
		
	}
	
}