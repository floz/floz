
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
		
		private var _path:Vector.<Point>;
		private var _shape:Shape;
		private var _g:Graphics;
		
		private var _commands:Vector.<int>;
		
		private var _lastX:Number;
		private var _lastY:Number;
		
		private var _isMoving:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function LayerObject( path:Vector.<Point> ) 
		{
			this._path = path;
			
			_shape = new Shape();
			_g = _shape.graphics;
			addChild( _shape );
			
			addCenter();			
			initPath();
			convertPath();
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
			g.beginFill( 0xff00ff );
			g.drawCircle( 0, 0, 5 );
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
		
		private function convertPath():void
		{
			var minX:Number = 0;
			var minY:Number = 0;
			var maxX:Number = 0;
			var maxY:Number = 0;
			
			// garder la position x & y en mémoire, pour le placement du shape graphique
			// trouver la position du centre, et construire la lettre en fonction
		}
		
		private function draw( color:uint = 0x000000 ):void
		{
			_g.clear();
			_g.beginFill( color );
			
			var j:int;
			var n:int = _path.length << 1;
			var datas:Vector.<Number> = new Vector.<Number>( n, true );
			for ( var i:int; i < n; i += 2 )
			{
				datas[ i ] = _path[ j ].x;
				datas[ i + 1 ] = _path[ j ].y;
				++j;
			}
			_g.drawPath( _commands, datas );
			_g.endFill();
			
			var rect:Rectangle = _shape.getBounds( _shape ); // TODO : Fix it !
			
			_shape.x = -_shape.width * .5 -rect.x;
			_shape.y = -_shape.height * .5 - rect.y;
		}
		
		private function onMove():void
		{
			var vx:Number = ( stage.mouseX - this.x ) * .1;
			var vy:Number = ( stage.mouseY - this.y ) * .1;
			this.x += vx;
			this.y += vy;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function startMove():void
		{			
			_isMoving = true;
			
			cacheAsBitmap = false;
			addEventListener( Event.ENTER_FRAME, enterFrameHandler, false, 0, true );
		}
		
		public function stopMove():void
		{
			_isMoving = false;
		}
		
		public function select():void
		{
			draw( 0xffcc00 );
		}
		
		public function deselect():void
		{
			draw();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}