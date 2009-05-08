
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class Borders extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private const _SPEED:Number = .2;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _width:Number;
		private var _height:Number;
		private var _bWidth:Number;
		private var _bHeight:Number;
		
		private var _bUp:Shape;
		private var _bDown:Shape;
		private var _bLeft:Shape;
		private var _bRight:Shape;
		
		private var _shown:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var cnt:Sprite;
		public var msk:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Borders( width:Number, height:Number, bWidth:Number, bHeight:Number ) 
		{
			this._width = width;
			this._height = height;
			this._bWidth = bWidth;
			this._bHeight = bHeight;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			TweenLite.killTweensOf( _bUp );
			TweenLite.killTweensOf( _bDown );
			TweenLite.killTweensOf( _bLeft );
			TweenLite.killTweensOf( _bRight );
			
			_bUp = 
			_bDown = 
			_bLeft = 
			_bRight = null;
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			_bUp = createBorder( _width, _bHeight );
			_bUp.y = -_bHeight;
			_bDown = createBorder( _width, _bHeight );
			_bDown.y = _height;
			_bLeft = createBorder( _bWidth, _height );
			_bLeft.x = -_bWidth;
			_bRight = createBorder( _bWidth, _height );
			_bRight.x = _width;
			
			cnt.addChild( _bUp );
			cnt.addChild( _bDown );
			cnt.addChild( _bLeft );
			cnt.addChild( _bRight );
			
			msk.width = _width;
			msk.height = _height;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function createBorder( width:Number, height:Number, color:uint = 0x000000, alpha:Number = 1 ):Shape
		{
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.beginFill( color, alpha );
			g.drawRect( 0, 0, width, height );
			g.endFill();
			
			return s;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function show():void
		{
			TweenLite.to( _bUp, _SPEED, { y: 0, ease: Quad.easeOut } );
			TweenLite.to( _bDown, _SPEED, { y: _height - _bHeight, ease: Quad.easeOut } );
			TweenLite.to( _bLeft, _SPEED, { x: 0, ease: Quad.easeOut } );
			TweenLite.to( _bRight, _SPEED, { x: _width - _bWidth, ease: Quad.easeOut } );
			_shown = true;
		}
		
		public function hide( delay:int = 0 ):void
		{
			TweenLite.to( _bUp, _SPEED, { y: -_bHeight, ease: Quad.easeOut, delay: delay * .1 } );
			TweenLite.to( _bDown, _SPEED, { y: _height, ease: Quad.easeOut, delay: delay * .1 } );
			TweenLite.to( _bLeft, _SPEED, { x: -_bWidth, ease: Quad.easeOut, delay: delay * .1 } );
			TweenLite.to( _bRight, _SPEED, { x: _width, ease: Quad.easeOut, delay: delay * .1 } );
			_shown = false;
		}
		
		public function isShow():Boolean { return _shown; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}