
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
	import gs.easing.Back;
	import gs.easing.Expo;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class Vignette extends Sprite
	{
		public static const VIGNETTE_OVER:String = "vignette_over";
		public static const VIGNETTE_OUT:String = "vignette_out";
		public static const VIGNETTE_CLICK:String = "vignette_click";
		public static const VIGNETTE_TO_FRONT:String = "vignette_to_front";
		public static const VIGNETTE_TO_BACK:String = "vignette_to_back";
		
		private var preview:BitmapData;
		private var flv:String;
		private var title:String;
		private var director:String;
		private var sound:String;
		private var size:Number;
		//
		private var normalSize:Number;
		private var enlargedSize:Number;
		
		private var index:int;
		
		private var ready:Boolean;
		private var dispatchable:Boolean;
		
		public function Vignette( preview:BitmapData, flv:String, title:String, director:String, sound:String, size:Number = 50 )
		{			
			this.preview = preview;
			this.flv = flv;
			this.title = title;
			this.director = director;
			this.sound = sound;
			this.size = size;
			
			var g:Graphics = this.graphics;
			g.beginFill( 0x000000 );
			g.drawCircle( 0, 0, size );
			g.endFill();
			
			var b:Bitmap = new Bitmap( UBit.resize( preview, size * 3, size * 3, true ), PixelSnapping.ALWAYS, true );
			b.x = - size - size * .5 + 10;
			b.y = - size - size * .5;
			
			var ns:Number = randRange( size - size / 4, size- size / 5 );
			var dist:Number = size - ns - 5; // -5 pour corriger le placement
			
			var msk:Sprite = new Sprite();
			var px:Number = randRange( -dist, dist );
			var py:Number = randRange( -dist, dist );
			g = msk.graphics;
			g.beginFill( 0xFF0000 );
			g.drawCircle( px, py, ns );
			g.endFill();
			
			var t:int = int( Math.random() * 2 );
			if ( t )
			{
				var s:Shape = new Shape();
				var vx:Number = randRange( 0, 3 );
				var vy:Number = randRange( 0, 3 );
				g = s.graphics;
				g.beginFill( Const.COLORS[ int( Math.random() * Const.COLORS.length ) ] );
				g.drawCircle( px < 0 ? px + vx : px - vx, py < 0 ? py + vy : py - vy, ns + randRange( 0, 7.5 ) );
				g.endFill();
				
				addChild( s );
			}
			
			addChild( b );
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
			
			//Tweener.removeTweens( this );
			TweenLite.killTweensOf( this );
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
			if ( !ready ) return;
			
			enlarge();
			dispatchEvent( new Event( Vignette.VIGNETTE_OVER, true ) );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			if ( !ready ) return;
			
			normalize();
			dispatchEvent( new Event( Vignette.VIGNETTE_OUT, true ) );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if ( !ready ) return;
			
			dispatchEvent( new Event( Vignette.VIGNETTE_CLICK, true ) );
		}
		
		// PRIVATE
		
		private function setReadyOn():void { this.ready = true; dispatchable = true; }
		
		private function setReadyOff():void { this.ready = false; this.parent.removeChild( this ); }
		
		private function onUpdateTween( firstStep:Boolean ):void
		{
			if ( firstStep )
			{
				if ( this.width >= ( normalSize + ( enlargedSize - normalSize ) * .5 ) && dispatchable )
				{
					dispatchable = false;
					dispatchEvent( new Event( Vignette.VIGNETTE_TO_FRONT, true ) );
				}
			}
			else
			{
				if ( this.width <= ( normalSize + ( enlargedSize - normalSize ) * .5 ) && !dispatchable ) 
				{
					dispatchable = true;
					dispatchEvent( new Event( Vignette.VIGNETTE_TO_BACK, true ) );
				}
			}
		}
		
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
			Tweener.addTween( this, { scaleX: 0, scaleY: 0, time: .35, transition: "easeInOutQuad", onComplete: setReadyOff } );
		}
		
		public function enlarge():void
		{
			//Tweener.addTween( this, { width: enlargedSize, height: enlargedSize, time: .3, transition: "easeInOutExpo", onUpdate: onUpdateTween, onUpdateParams: [ true ] } );
			TweenLite.to( this, .3, { width: enlargedSize, height: enlargedSize, ease: Expo.easeInOut, onUpdate: onUpdateTween, onUpdateParams: [ true ] } );
		}
		
		public function normalize():void
		{
			//Tweener.addTween( this, { width: normalSize, height: normalSize, time: .3, transition: "easeInOutBack", onUpdate: onUpdateTween, onUpdateParams: [ false ] } );
			TweenLite.to( this, .3, { width: normalSize, height: normalSize, ease: Back.easeInOut, onUpdate: onUpdateTween, onUpdateParams: [ false ] } );
		}
		
		public function setIndex( index:int ):void { this.index = index };
		public function getIndex():int { return this.index; }		
		public function getTitle():String { return this.title; }
		public function getDirector():String { return this.director; }
		public function getSound():String { return this.sound; }
		public function getFLV():String { return this.flv; }
	}
	
}