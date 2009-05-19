
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Ribbon extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _color:uint;
		
		private var _px:Number;
		private var _py:Number;
		private var _vx:Number;
		private var _vy:Number;
		
		private var _inited:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Ribbon( color:uint ) 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			this.mouseChildren =
			this.mouseEnabled = false;
			
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onFrame(e:Event):void 
		{
			update();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function update():void
		{
			var tx:Number = _px;
			var ty:Number = _py;
			
			_vx += ( _px - stage.mouseX ) * .05; 
			_vy += ( _py - stage.mouseY ) * .05;
			
			_vx *= .9;
			_vy *= .9;
			
			_px -= _vx;
			_py -= _vy;
			
			this.graphics.lineTo( _px, _py );
			
			drawSegment( tx, ty, _px, _py );
		}
		
		private function drawSegment( ax:Number, ay:Number, bx:Number, by:Number ):void
		{
			trace( "--------------" );
			trace( "bx-ax : " + ( bx - ax ) );
			var vx:Number = bx - ax;
			trace( "by-ay : " + ( by - ay ) );
			var vy:Number = by - ay;
			trace( "tan : " + Math.atan2( vy, vx ) );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function draw():void
		{
			this._vx = 0;
			this._vy = 0;
			
			this._px = stage.mouseX;
			this._py = stage.mouseY;
			
			this.graphics.lineStyle( 1, _color );
			this.graphics.moveTo( _px, _py );
			
			_inited = true;
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		public function end():void
		{
			if ( !_inited ) 
				return;
			
			removeEventListener( Event.ENTER_FRAME, onFrame );
			
			this.graphics.endFill();
			_inited = false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get drawing():Boolean { return _inited; }
		
	}
	
}