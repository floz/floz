
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
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ListeVignettes extends MovieClip 
	{
		public var msk:MovieClip;
		public var cnt:MovieClip;
		public var zUp:SimpleButton;
		public var zDown:SimpleButton;
		
		private var _main:Main;
		
		private var target:Sprite;
		
		public var status:Boolean;
		private var scrollVal:int;
		private var nbrLignes:int = 9;
		private var idxMax:int;
		private var aVignettes:Array;
		
		public function ListeVignettes() 
		{
			this.buttonMode = true;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			//msk.visible = false;
			
			_main = getAncestor( this, Main ) as Main;
			_main.addEventListener( Main.READY, load );
			
			cnt.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			cnt.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			cnt.addEventListener( MouseEvent.MOUSE_OUT, onOut );
			
			zUp.addEventListener( MouseEvent.MOUSE_UP, onUpPressed );
			zDown.addEventListener( MouseEvent.MOUSE_UP, onDownPressed );
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
		
		private function onDownPressed(e:MouseEvent):void 
		{
			if ( scrollVal + 1 <= idxMax ) scrollVal++;
			else return;
			
			affiche( scrollVal );
			setButtonsStatus();
		}
		
		private function onUpPressed(e:MouseEvent):void 
		{
			if ( scrollVal - 1 >= 0 ) scrollVal--;
			else return;
			
			affiche( scrollVal );
			setButtonsStatus();
		}
		
		// PRIVATE
		
		private function load( e:Event = null ):void
		{
			if ( _main.section == Main.CONTACT ) return;
			
			status = true;
			scrollVal = 0;
			aVignettes = [];
			
			var a:Array = ( _main.section == Main.WORKS ) ? _main.works : _main.archives;
			
			var o:Object;
			var v:Vignette;
			var n:int = a.length;
			for ( var i:int; i < n; i++ )
			{
				o = a[ i ];
				v = new Vignette( o.name, o.preview, o.film, o.director, o.production, o.postproduction );
				v.y = -200;
				cnt.addChild( v );
			}
			
			cnt.mask = msk;
			
			nbrLignes = n;
			idxMax = nbrLignes - 9;
			
			affiche( 0 );
			setButtonsStatus();
			
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
		
		private function affiche( idx:int ):void
		{
			var a:Array = [];
			var pos:Array = getPositions( idx );
			
			var v:Vignette;
			
			var i:int;
			var n:int = cnt.numChildren;
			for ( i; i < n; i++ )
			{
				v = cnt.getChildAt( i ) as Vignette;
				if ( pos[ i ] == -200 || pos[ i ] == 525 ) v.y = pos[ i ];
				else Tweener.addTween( v, { y: pos[ i ], time: .3, transition: "easeInOutQuad" } );
			}
		}
		
		private function getPositions( idx:int ):Array
		{				
			//var idxMax:int = Math.max( 0, nbrLignes - 9 );
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
				a.unshift( -198 );
				for ( var i:int; i < int( idxAct - 1 ); i++ ) a.unshift( -200 );
			}
			
			if ( a.length < nbrLignes ) a.push( 520 );
			while ( a.length < nbrLignes ) a.push( 525 );
			
			return a;
		}
		
		private function setButtonsStatus():void
		{
			if ( scrollVal == 0 )
			{
				zUp.alpha = .5;
				zUp.enabled = false;
			}
			else
			{
				zUp.alpha = 1;
				zUp.enabled = true;
			}
			
			if ( scrollVal == idxMax )
			{
				zDown.alpha = .5;
				zDown.enabled = false;
			}			
			else
			{
				zDown.alpha = 1;
				zDown.enabled = true;
			}
		}
		
		private function disable():void
		{
			this.visible = false;
			Tweener.removeTweens( this );
		}
		
		// PUBLIC
		
		public function refresh():void
		{
			while ( cnt.numChildren ) 
			{
				Tweener.removeTweens( cnt.getChildAt( 0 ) );
				cnt.removeChildAt( 0 );
			}
			
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