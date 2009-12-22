
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import fr.floz.geom.Segment;
	
	public class MainSegment01 extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _start:Point;
		private var _anchor:Point;
		private var _end:Point;
		
		private var _anchorHandle:Sprite;
		private var _startHandle:Sprite;
		private var _endHandle:Sprite;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainSegment01() 
		{
			_start = new Point( stage.stageWidth * .5 - 10, stage.stageHeight * .5 );
			_anchor = new Point( stage.stageWidth * .5 - 50, stage.stageHeight * .5 - 200 );
			_end = new Point( stage.stageWidth * .5 + 300, stage.stageHeight * .5 );
			
			_anchorHandle = new Sprite();			
			_startHandle = new Sprite();
			_endHandle = new Sprite();
			
			drawCircle( _startHandle, 0x00ff00 );
			drawCircle( _anchorHandle, 0xffcc00 );
			drawCircle( _endHandle, 0x00ff00 );
			
			_startHandle.x = _start.x;
			_startHandle.y = _start.y;
			_anchorHandle.x = _anchor.x;
			_anchorHandle.y = _anchor.y;
			_endHandle.x = _end.x;
			_endHandle.y = _end.y;
			
			_startHandle.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true );
			_startHandle.addEventListener( MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true );
			_anchorHandle.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true );
			_anchorHandle.addEventListener( MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true );
			_endHandle.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true );
			_endHandle.addEventListener( MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true );
			
			_startHandle.buttonMode = 
			_anchorHandle.buttonMode =
			_endHandle.buttonMode = true;
			
			addChild( _startHandle );
			addChild( _anchorHandle );
			addChild( _endHandle );
			
			render();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			e.currentTarget.startDrag();
			addEventListener( Event.ENTER_FRAME, render );
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			e.currentTarget.stopDrag();
			removeEventListener( Event.ENTER_FRAME, render );
		}
		
		private function render( e:Event = null ):void
		{
			graphics.clear();
			
			_start.x = _startHandle.x;
			_start.y = _startHandle.y;
			_anchor.x = _anchorHandle.x;
			_anchor.y = _anchorHandle.y;
			_end.x = _endHandle.x;
			_end.y = _endHandle.y;
			
			graphics.lineStyle( 1, 0x00ff00 );
			graphics.moveTo( _start.x, _start.y );
			graphics.curveTo( _anchor.x, _anchor.y, _end.x, _end.y );
			
			graphics.lineStyle( 1, 0xffcc00 );
			graphics.moveTo( _start.x, _start.y );
			graphics.lineTo( _anchor.x, _anchor.y );
			graphics.lineTo( _end.x, _end.y );
			
			var s:Segment = new Segment( _start, _end, _anchor );
			
			var ratio:Number;
			var dx:Number = _end.x - _start.x;
			var dy:Number = _end.y - _start.y;
			var totalLength:Number = Math.sqrt( dx * dx + dy * dy );
			
			var adx:Number = _anchor.x - _start.x;
			var ady:Number = _anchor.y - _start.y;
			var anchorLength:Number = Math.sqrt( adx * adx + ady * ady );
			
			var ns:Segment = s.subdivide( anchorLength / s.getLength() );
			
			graphics.lineStyle( 1, 0xff0000 );
			graphics.moveTo( ns.start.x, ns.start.y );
			graphics.lineTo( ns.control.x, ns.control.y );
			graphics.lineTo( ns.end.x, ns.end.y );
			
			graphics.lineTo( ns.next.control.x, ns.next.control.y );
			graphics.lineTo( ns.next.end.x, ns.next.end.y );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function drawCircle( target:Sprite, color:uint ):void
		{
			var g:Graphics = target.graphics;
			g.beginFill( color, .5 );
			g.drawCircle( 0, 0, 7 );
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}