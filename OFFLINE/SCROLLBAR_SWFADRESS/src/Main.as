package 
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.system.System;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.ui.ContextMenuItem;
	
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
			
			var ctMenu:ContextMenu = new ContextMenu();
			ctMenu.hideBuiltInItems();
			
			ctMenu.customItems.push( new ContextMenuItem( "test1" ) );
			ctMenu.customItems.push( new ContextMenuItem( "Test2", true ) );
			ctMenu.customItems.push( new ContextMenuItem( "Test3" ) );
			ctMenu.customItems.push( new ContextMenuItem( "Test4" ) );
			this.contextMenu = ctMenu;
			
			var n:int = ctMenu.customItems.length;
			for ( var i:int; i < n; i++ )
				ctMenu.customItems[ i ].addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, onMenuItemSelect );
			
			var s:Sprite;
			var g:Graphics;
			n = colors.length;
			for ( i = 0; i < n; i++ )
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
			
			SWFAddress.setTitle( "TESTEST" );
			
			var tempUrl:String = loaderInfo.url;
			trace( "tempUrl : " + tempUrl );
			datasource = tempUrl.indexOf( "file://" ) == -1 ? tempUrl.substr( 0, tempUrl.lastIndexOf( '/' ) + 1 ) + "datasource.php" : "http://localhost/SWADRESS/datasource.php";
			trace( "datasource : " + datasource );
			
			SWFAddress.addEventListener( SWFAddressEvent.CHANGE, onSWFAdressChange );
		}
		
		private function onSWFAdressChange(e:SWFAddressEvent):void 
		{
			trace( e.path );
			
			url = SWFAddress.getBaseURL() + e.value;
			title = "SWFAdress essais";
			for ( var i:int; i < e.pathNames.length; i++ )
				title += " - " + e.pathNames[ i ].substr( 0, 1 ).toUpperCase() + e.pathNames[ i ].substr( 1 );
				
			SWFAddress.setTitle( title );			
		}
		
		private function onMenuItemSelect(e:ContextMenuEvent):void 
		{
			SWFAddress.setValue( "/" + e.currentTarget.caption + "/" );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch( e.currentTarget.name )
			{
				case "0": SWFAddress.setValue( "test1" ); break;
				case "1": SWFAddress.setValue( "Test2" ); break;
				case "2": SWFAddress.setValue( "Test3" ); break;
				case "3": SWFAddress.setValue( "Test4" ); break;
			}
		}
		
	}
	
}