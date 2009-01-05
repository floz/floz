
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
	
	public class Vignette extends Sprite
	{
		public static const VIGNETTE_OVER:String = "vignette_over";
		public static const VIGNETTE_OUT:String = "vignette_out";
		public static const VIGNETTE_CLICK:String = "vignette_click";
		
		private var preview:BitmapData;
		private var flv:String;
		private var title:String;
		private var director:String;
		private var sound:String;
		private var size:Number;
		//
		private var normalSize:Number;
		private var enlargedSize:Number;
		
		private var ready:Boolean;
		private var running:Boolean;
		
		public function Vignette( preview:BitmapData, flv:String, title:String, director:String, sound:String, size:Number = 50 )
		{			
			this.preview = preview;
			this.flv = flv;
			this.title = title;
			this.size = size;
			
			var g:Graphics = this.graphics;
			g.beginFill( 0x000000 );
			g.drawCircle( 0, 0, size );
			g.endFill();
			
			var b:Bitmap = new Bitmap( UBit.resize( preview, size * 3, size * 3, true ), PixelSnapping.ALWAYS, true );
			b.x =
			b.y = - size - size * .5;
			addChild( b );
			
			var ns:Number = randRange( size - size / 4, size- size / 5 );
			var dist:Number = size - ns - 5; // -5 pour corriger le placement
			
			var msk:Sprite = new Sprite();
			g = msk.graphics;
			g.beginFill( 0xFF0000 );
			g.drawCircle( randRange( -dist, dist ), randRange( -dist, dist ), ns );
			g.endFill();
			addChild( msk );
			
			b.mask = msk;
			
			normalSize = this.width;
			enlargedSize = this.width * 1.2;
			
			this.buttonMode = true;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			removeEventListener( MouseEvent.MOUSE_OVER, onOver, true );
			removeEventListener( MouseEvent.MOUSE_OUT, onOut, true );
			removeEventListener( MouseEvent.CLICK, onClick, true );
			
			Tweener.removeTweens( this );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			this.scaleX =
			this.scaleY = 0;
			
			addEventListener( MouseEvent.MOUSE_OVER, onOver );
			addEventListener( MouseEvent.MOUSE_OUT, onOut );
			addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			enlarge();
			dispatchEvent( new Event( Vignette.VIGNETTE_OVER, true ) );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			normalize();
			dispatchEvent( new Event( Vignette.VIGNETTE_OUT, true ) );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			dispatchEvent( new Event( Vignette.VIGNETTE_CLICK, true ) );
		}
		
		// PRIVATE
		
		private function setReadyOn():void { this.ready = true; }
		
		private function setReadyOff():void { this.ready = false; this.parent.removeChild( this ); }
		
		private function randRange( min:Number, max:Number, plus:Number = 0 ):Number
		{
			var n:Number = ( Math.random() * ( max - min ) + min )
			return  n = ( n < 0 ) ? n - plus : n + plus;
		}
		
		// PUBLIC
		
		public function init():void
		{
			Tweener.addTween( this, { scaleX: 1, scaleY: 1, time: .35, transition: "easeInOutQuad", onComplete: setReadyOn } );
		}
		
		public function destroy():void
		{
			Tweener.addTween( this, { scaleX: 0, scaleY: 0, time: .35, transition: "easeInOutQuad", onComplete: setReadyOff } );
		}
		
		public function enlarge():void
		{
			Tweener.addTween( this, { width: enlargedSize, height: enlargedSize, time: .3, transition: "easeInOutExpo" } );
		}
		
		public function normalize():void
		{
			Tweener.addTween( this, { width: normalSize, height: normalSize, time: .3, transition: "easeInOutBack" } );
		}
	}
	
}