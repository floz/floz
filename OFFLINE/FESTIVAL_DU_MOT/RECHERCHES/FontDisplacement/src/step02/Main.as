
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package step02
{
	import com.festivaldumot.core.Config;
	import com.festivaldumot.display.typo.Letter;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _dotsRef:Vector.<Dot>;
		private var _dots:Vector.<Dot>;
		
		private var _quad:Sprite;
		
		private var _center:Point = new Point();
		private var _allowMoving:Boolean;
		
		private var _dx:Number;
		private var _dy:Number;
		
		private const MIN_DIST:Number = .3;
		private const SIZE:Number = 30;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			buildDots();
			buildQuad();
			
			initListeners();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			_allowMoving = true;
			
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
			stage.addEventListener( MouseEvent.MOUSE_UP, mouseUpHandler );
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			if ( !_allowMoving )
			{
				checkMovement();
			}
			else
			{
				_dx = stage.mouseX;
				_dy = stage.mouseY;
			}
			
			updateDots();
			render();
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			_dx = stage.mouseX;
			_dy = stage.mouseY;
			
			_allowMoving = false;
			
			stage.removeEventListener( MouseEvent.MOUSE_UP, mouseUpHandler );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function buildDots():void
		{			
			var cnt:Sprite = new Sprite();
			addChild( cnt );
			
			var letter:Letter = new Letter( "O", Config.TYPOGRAPHY );
			var path:Vector.<Point> = letter.getPath();
			
			var d:Dot;
			var n:int = path.length;
			_dots = new Vector.<Dot>( n, true );
			_dotsRef = new Vector.<Dot>( n, true );
			for ( var i:int; i < n; ++i )
			{
				d = new Dot();
				d.x = path[ i ].x;
				d.y = path[ i ].y;
				cnt.addChild( d );
				_dots[ i ] = d;
				_dotsRef[ i ] = d.clone();
			}
		}
		
		private function buildQuad():void
		{
			_quad = new Sprite();
			addChild( _quad );
			
			render();
		}
		
		private function render():void
		{
			var g:Graphics = _quad.graphics;
			g.clear();
			g.beginFill( 0x000000 );
			g.moveTo( _dots[ 0 ].x, _dots[ 0 ].y );
			
			var n:int = _dots.length;
			for ( var i:int = 1; i < n; ++i )
				g.lineTo( _dots[ i ].x, _dots[ i ].y );
		}
		
		private function initListeners():void
		{
			_quad.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
		}
		
		private function updateDots():void
		{
			var dx:Number = ( _dx - _center.x ) * .2;
			var dy:Number = ( _dy - _center.y ) * .2;
			_center.x += dx;
			_center.y += dy;
			
			var baseDist:Number;
			var dist:Number;
			
			var n:int = _dots.length;
			for ( var i:int; i < n; ++i )
			{
				baseDist = Math.sqrt( _dotsRef[ i ].x * _dotsRef[ i ].x + _dotsRef[ i ].y * _dotsRef[ i ].y );
				
				dx = _dx - _dots[ i ].x;
				dy = _dy - _dots[ i ].y;
				dist = Math.sqrt( dx * dx + dy * dy ) - baseDist;
				dist /= 100;
				
				_dots[ i ].x = _dotsRef[ i ].x + _center.x - 20 * dist;
				_dots[ i ].y = _dotsRef[ i ].y + _center.y - 20 * dist;
			}
		}
		
		private function checkMovement():void
		{
			var dx:Number = _dx - _center.x;
			var dy:Number = _dy - _center.y;
			var dist:Number = Math.sqrt( dx * dx + dy * dy );
			
			if ( dist <= MIN_DIST )
				removeEventListener( Event.ENTER_FRAME, enterFrameHandler );
			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}