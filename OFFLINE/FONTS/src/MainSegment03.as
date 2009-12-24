
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
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import fr.floz.geom.CurveBezier;
	import fr.floz.geom.Segment;
	
	public class MainSegment03 extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _start:Point;
		private var _anchor:Point;
		private var _end:Point;
		
		private var _anchorHandle:Sprite;
		private var _startHandle:Sprite;
		private var _endHandle:Sprite;
		
		private var _lines:Vector.<CurveBezier>;
		private var _breakCount:int = 1;
		
		private var _tfCounter:TextField;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainSegment03() 
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
			
			_lines = new Vector.<CurveBezier>();
			_lines[ 0 ] = new CurveBezier( _start, _anchor, _end );
			
			var addBt:Sprite = createBt( "ADD BREAKPOINT" );
			addBt.x = 
			addBt.y = 10;
			addBt.addEventListener( MouseEvent.CLICK, addClickHandler );
			addChild( addBt );
			
			var subBt:Sprite = createBt( "REMOVE BREAKPOINT" );
			subBt.x = addBt.x + addBt.width + 10;
			subBt.y = 10;
			subBt.addEventListener( MouseEvent.CLICK, subClickHandler );
			addChild( subBt );
			
			createCounter();
			
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
		
		private function addClickHandler(e:MouseEvent):void 
		{
			++_breakCount;
			_tfCounter.text = _breakCount.toString();
			render();
		}
		
		private function subClickHandler(e:MouseEvent):void 
		{
			if ( _breakCount > 0 )
			{
				--_breakCount;
				_tfCounter.text = _breakCount.toString();
			}
			render();
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
			
			drawBaseLines();
			refreshLines();
			drawBreakLines();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function drawCircle( target:Sprite, color:uint ):void
		{
			var g:Graphics = target.graphics;
			g.beginFill( color, .5 );
			g.drawCircle( 0, 0, 7 );
			g.endFill();
		}
		
		private function createBt( title:String ):Sprite
		{
			var format:TextFormat = new TextFormat( "_sans", 10, 0xffffff );
			var tf:TextField = new TextField();
			tf.defaultTextFormat = format;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.text = title;
			tf.x = 5;
			
			var bt:Sprite = new Sprite();
			var g:Graphics = bt.graphics;
			g.beginFill( 0x444444 );
			g.drawRect( 0, 0, tf.textWidth + 13, 17 );
			g.endFill();
			
			bt.mouseChildren = false;
			bt.buttonMode = true;
			
			bt.addChild( tf );			
			
			return bt;
		}
		
		private function createCounter():void
		{
			var bt:Sprite = new Sprite();
			var g:Graphics = bt.graphics;
			g.beginFill( 0x444444 );
			g.drawRect( 0, 0, 30, 17 );
			g.endFill();
			
			bt.x = stage.stageWidth - 10 - bt.width;
			bt.y = 10;
			
			var format:TextFormat = new TextFormat( "_sans", 10, 0xffffff );
			_tfCounter = new TextField();
			_tfCounter.defaultTextFormat = format;
			_tfCounter.width = bt.width;
			_tfCounter.autoSize = TextFieldAutoSize.CENTER;
			_tfCounter.text = _breakCount.toString();
			bt.addChild( _tfCounter );
			
			addChild( bt );
		}
		
		private function drawBaseLines():void
		{
			graphics.lineStyle( 1, 0x00ff00 ); // courbe verte
			graphics.moveTo( _start.x, _start.y );
			graphics.curveTo( _anchor.x, _anchor.y, _end.x, _end.y );
			
			graphics.lineStyle( 1, 0xffcc00 ); // courbe jaune
			graphics.moveTo( _start.x, _start.y );
			graphics.lineTo( _anchor.x, _anchor.y );
			graphics.lineTo( _end.x, _end.y );
		}
		
		private function refreshLines():void
		{
			var updatedLines:Vector.<CurveBezier> = new Vector.<CurveBezier>();
			updatedLines[ 0 ] = new CurveBezier( _start, _anchor, _end );
			
			var n:int = _breakCount;
			for ( var i:int; i < n; ++i )
				updatedLines = breakLines( updatedLines );
			
			_lines = updatedLines;
		}
		
		private function breakLines( lines:Vector.<CurveBezier> ):Vector.<CurveBezier>
		{
			var updatedLines:Vector.<CurveBezier> = new Vector.<CurveBezier>();
			
			var dx:Number, dy:Number, anchorLength:Number;
			var curves:Vector.<CurveBezier>;
			var s:CurveBezier;
			var n:int = lines.length;
			for ( var i:int; i < n; ++i )
			{
				s = lines[ i ];
				curves = s.breakInCurves();
				
				updatedLines.push( curves[ 0 ] );
				updatedLines.push( curves[ 1 ] );
			}
			return updatedLines;
		}
		
		private function drawBreakLines():void
		{
			var s:CurveBezier = _lines[ 0 ];
			
			graphics.lineStyle( 1, 0xff0000 );
			graphics.moveTo( s.start.x, s.start.y )
			graphics.lineTo( s.control.x, s.control.y );
			graphics.lineTo( s.end.x, s.end.y );
			
			var n:int = _lines.length;
			for ( var i:int = 1; i < n; ++i )
			{
				s = _lines[ i ];
				graphics.lineTo( s.control.x, s.control.y );
				graphics.lineTo( s.end.x, s.end.y );
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}