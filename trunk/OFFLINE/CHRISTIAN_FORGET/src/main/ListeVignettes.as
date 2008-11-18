
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
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
			trace ( e.target.name + " : UP" );
			if ( e.target is Vignette ) e.target.up();
		}
		
		// PRIVATE
		
		private function load( e:Event = null ):void
		{
			if ( _main.section == Main.CONTACT ) return;
			
			var a:Array = ( _main.section == Main.WORKS ) ? _main.works : _main.archives;
			
			var o:Object;
			var v:Vignette;
			var n:int = a.length;
			for ( var i:int; i < n; i++ )
			{
				o = a[ i ];
				v = new Vignette( o.name, o.preview, o.film );
				v.y = i * 3.63 + v.height * i;
				cnt.addChild( v );
			}
			
			trace (cnt.height );
			trace (cnt.width );
			
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
		
		// PUBLIC
		
		public function refresh():void
		{
			while ( cnt.getChildAt( 0 ) ) cnt.removeChildAt( 0 );
			
			load();
		}
		
	}
	
}