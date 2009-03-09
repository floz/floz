
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Main extends MovieClip
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _itemOver:DisplayObjectContainer;
		private var _itemSelected:DisplayObjectContainer;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			var cnt:Sprite = new Sprite();
			
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.beginFill( 0xffffff );
			g.drawRect( 0, 0, 200, 50 );
			g.endFill();
			cnt.addChild( s );
			
			var b:Bitmap = new Bitmap( new BitmapData( 30, 30, true, 0xff00ff00 ) );
			cnt.addChild( b );
			
			addChild( cnt );
			
			addEventListener( MouseEvent.MOUSE_MOVE, onMove );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onMove(e:MouseEvent):void 
		{
			_itemOver = e.target as DisplayObjectContainer;
			
			var a:Array = getChildren();
			var n:int = a.length;
			for ( var i:int; i < n; i++ )
				if ( a[ i ].getRect( stage ).contains( e.stageX, e.stageY ) ) trace( a[ i ] );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function getChildren():Array
		{
			var a:Array = [];
			var n:int = _itemOver.numChildren;
			for ( var i:int; i < n; i++ )
				a.push( _itemOver.getChildAt( i ) );
			
			return a;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		// - END CLASS -------------------------------------------------------------------
		
	}
	
}