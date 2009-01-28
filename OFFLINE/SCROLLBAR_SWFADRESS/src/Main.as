package 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.system.System;
	import flash.ui.ContextMenu;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Main extends Sprite 
	{
		private var colors:Array = [ 0xFF00FF, 0xFF0000, 0x00FF00, 0x0000FF ];
		
		// custome SWFAdress handling
		private var content:String;
		private var url:String;
		private var title:String;
		private var datasource:String;
		
		public function Main():void 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var s:Sprite;
			var g:Graphics;
			var n:int = colors.length;
			for ( var i:int; i < n; i++ )
			{
				s = new Sprite();
				g = s.graphics;
				g.beginFill( colors[ i ] );
				g.drawRect( 0, 0, 50, 50 );
				g.endFill();
				
				s.x = i * 100 + 100;
				s.y = 200;
				s.name = i.toString();
				
				addChild( s );
				s.addEventListener( MouseEvent.CLICK, onClick );
			}
			
			var tempUrl:String = loaderInfo.url;
			datasource = tempUrl.indexOf( "file://" ) == -1 ? tempUrl.substr( 0, tempUrl.lastIndexOf( '/' ) + 1 ) + "datasource.php" : "http://localhost/swfaddress/samples/seo/datasource.php";
		}
		
		private function onClick(e:MouseEvent):void 
		{
			trace( e.target.name );
		}
		
	}
	
}