
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import caurina.transitions.Tweener;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.utils.UBit;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class FakeVignette extends Sprite
	{		
		private var size:Number;
		//
		private var normalSize:Number;
		private var enlargedSize:Number;
		
		private var index:int;
		
		private var ready:Boolean;
		private var dispatchable:Boolean;
		
		public function FakeVignette( size:Number = 50 )
		{
			this.size = size;
			
			var g:Graphics = this.graphics;
			g.beginFill( 0x000000 );
			g.drawCircle( 0, 0, size );
			g.endFill();
			
			var ns:Number = randRange( size - size / 4, size- size / 5 );
			var dist:Number = size - ns - 5; // -5 pour corriger le placement
			var t:int = int( Math.random() * 2 );
			
			var msk:Sprite = new Sprite();
			var px:Number = randRange( -dist, dist );
			var py:Number = randRange( -dist, dist );
			g = msk.graphics;
			g.beginFill( t ? 0x000000 : Const.COLORS[ int( Math.random() * Const.COLORS.length ) ] );
			g.drawCircle( px, py, ns );
			g.endFill();
			addChild( msk );
			
			//this.alpha = .9;
			
			normalSize = this.width;
			enlargedSize = this.width * 1.2;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			//Tweener.removeTweens( this );
			TweenLite.killTweensOf( this );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			this.scaleX =
			this.scaleY = 0;
		}
		
		// PRIVATE
		
		private function setReadyOn():void { this.ready = true; dispatchable = true; }
		
		private function setReadyOff():void { this.ready = false; this.parent.removeChild( this ); }
		
		private function randRange( min:Number, max:Number, plus:Number = 0 ):Number
		{
			var n:Number = ( Math.random() * ( max - min ) + min )
			return  n = ( n < 0 ) ? n - plus : n + plus;
		}
		
		// PUBLIC
		
		public function init():void
		{
			//Tweener.addTween( this, { scaleX: 1, scaleY: 1, time: .35, transition: "easeInOutQuad", onComplete: setReadyOn } );
			TweenLite.to( this, .35, { scaleX: 1, scaleY: 1, ease: Quad.easeInOut, onComplete: setReadyOn } );
		}
		
		public function destroy():void
		{
			ready = false;
			//Tweener.addTween( this, { scaleX: 0, scaleY: 0, time: .35, transition: "easeInOutQuad", onComplete: setReadyOff } );
			TweenLite.to( this, .35, { scaleX: 0, scaleY: 0, ease: Quad.easeInOut, onComplete: setReadyOff } );
		}
	}
	
}