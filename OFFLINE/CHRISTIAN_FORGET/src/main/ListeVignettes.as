
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ListeVignettes extends MovieClip 
	{
		public var msk:MovieClip;
		public var cnt:MovieClip;
		
		private var _main:Main;
		
		private var target:Sprite;
		
		public var status:Boolean;
		private var scrollVal:int;
		private var nbrLignes:int = 9;
		private var aVignettes:Array;
		
		public function ListeVignettes() 
		{
			this.buttonMode = true;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			msk.visible = false;
			
			_main = getAncestor( this, Main ) as Main;
			_main.addEventListener( Main.READY, load );
			
			cnt.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			cnt.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			cnt.addEventListener( MouseEvent.MOUSE_OUT, onOut );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			e.target.over();
		}
		
		private function onOut(e:MouseEvent):void 
		{
			e.target.out();
		}
		
		private function onDown(e:MouseEvent):void 
		{
			e.target.down();
			stage.addEventListener( MouseEvent.MOUSE_UP, onUp );
		}
		
		private function onUp(e:MouseEvent):void 
		{
			if ( e.target is Vignette ) e.target.up();
		}
		
		// PRIVATE
		
		private function load( e:Event = null ):void
		{
			if ( _main.section == Main.CONTACT ) return;
			
			status = true;
			scrollVal = 0;
			
			var a:Array = ( _main.section == Main.WORKS ) ? _main.works : _main.archives;
			aVignettes = [];
			
			var o:Object;
			var v:Vignette;
			var n:int = a.length;
			for ( var i:int; i < n; i++ )
			{
				o = a[ i ];
				v = new Vignette( o.name, o.preview, o.film );
				v.y = i * 3.63 + v.height * i;
				trace( "v.y : " + v.y );
				cnt.addChild( v );
			}
			
			nbrLignes = n;
			
			trace ( getPositions( 0 ) );
			
			o = null;
			a = null;
		}
		
		private function getAncestor( child:DisplayObject, type:* ):*
		{
			var c:DisplayObject = child;
			
			while ( c.parent )
			{
				if ( c.parent is type ) return c.parent;
				c = c.parent;
			}
			
			return null;
		}
		
		private function disable():void
		{
			this.visible = false;
			Tweener.removeTweens( this );
		}
		
		private function getPositions( idx:int ):Array
		{				
			var idxMax:int = Math.max( 0, nbrLignes - 9 );
			var idxAct:int = Math.min( idx, idxMax );
			
			var a:Array = [];
			if ( nbrLignes > 0 ) a.push( 0 );
			if ( nbrLignes > 1 ) a.push( 40.6 );
			if ( nbrLignes > 2 ) a.push( 81.25 );
			if ( nbrLignes > 3 ) a.push( 121.85 );
			if ( nbrLignes > 4 ) a.push( 162.5 );
			if ( nbrLignes > 5 ) a.push( 203.15 );
			if ( nbrLignes > 6 ) a.push( 243.75 );
			if ( nbrLignes > 7 ) a.push( 284.4 );
			if ( nbrLignes > 8 ) a.push( 325 );
			if ( nbrLignes > 9 && idxAct > 0 )
			{
				var i:int;
				for ( i; i < idxAct; i++ ) a.unshift( -200 );
			}
			while ( a.length > nbrLignes ) a.push( 525 );
			
			return a;
		}
		
		// PUBLIC
		
		public function refresh():void
		{
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			
			load();
		}
		
		public function hide():void
		{
			this.status = false;
			
			Tweener.addTween( this, { alpha: .6, transition: "easeInOutQuad", time: .25, onComplete: disable } );
		}
		
		public function show():void
		{
			refresh();
			
			this.alpha = .6;
			this.visible = true;
			
			Tweener.addTween( this, { alpha: 1, transition: "easeInOutQuad", time: .25 } );
		}
		
	}
	
}