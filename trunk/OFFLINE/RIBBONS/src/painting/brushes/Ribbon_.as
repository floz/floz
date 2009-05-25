
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes
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
		
		private var link1x:Number;
		private var link1y:Number;
		private var link2x:Number;
		private var link2y:Number;
		
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
			
			drawSegment( tx, ty, _px, _py, Math.atan2( _py - ty, _px - tx ) );
		}
		
		private function drawSegment( x1:Number, y1:Number, x2:Number, y2:Number, a:Number ):void
		{
			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;
			var rayon:Number = Math.sqrt( dx * dx + dy *dy ) * .5;	

			var g:Graphics = this.graphics;
			
			var posX:Number = Math.cos( toRadians( 80 ) ) * rayon * .5;
			var posY:Number = Math.sin( toRadians( 80 ) ) * rayon * .5;
			
			var ox:Number = x1 + dx * .5;
			var oy:Number = y1 + dy * .5;
			
			g.lineStyle( 1, 0x0000ff );
			g.moveTo( link2x ? link2x : rayon * Math.cos( Math.atan2( -posY, -posX ) + a ) + ox, link2y ? link2y : rayon * Math.sin( Math.atan2( -posY, -posX ) + a ) + oy );
			g.lineTo( link1x ? link1x : rayon * Math.cos( Math.atan2( posY, -posX ) + a ) + ox, link1y ? link1y : rayon * Math.sin( Math.atan2( posY, -posX ) + a ) + oy );
			g.lineTo( rayon * Math.cos( Math.atan2( posY, posX ) + a ) + ox, rayon * Math.sin( Math.atan2( posY, posX ) + a ) + oy );
			g.lineTo( rayon * Math.cos( Math.atan2( -posY, posX ) + a ) + ox, rayon * Math.sin( Math.atan2( -posY, posX ) + a ) + oy );
			g.lineTo( link2x ? link2x : rayon * Math.cos( Math.atan2( -posY, -posX ) + a ) + ox, link2y ? link2y : rayon * Math.sin( Math.atan2( -posY, -posX ) + a ) + oy );
			g.endFill();

			link1x = rayon * Math.cos( Math.atan2( posY, posX ) + a ) + ox;
			link1y = rayon * Math.sin( Math.atan2( posY, posX ) + a ) + oy;
			
			link2x = rayon * Math.cos( Math.atan2( -posY, posX ) + a ) + ox;
			link2y = rayon * Math.sin( Math.atan2( -posY, posX ) + a ) + oy;
		}
		
		private function toDegres( value:Number ):Number
		{
			return ( value * 180 / Math.PI );
		}

		private function toRadians( value:Number ):Number
		{
			return ( value * Math.PI / 180 );
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