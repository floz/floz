
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import assets.GBackground;
	import assets.GBtClose;
	import assets.GRepere;
	import elive.core.users.User;
	import elive.xmls.EliveXML;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeDragManager;
	import flash.desktop.SystemTrayIcon;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.NativeMenu;
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	import flash.text.TextField;
	import fr.minuit4.net.loaders.types.DatasLoader;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			addChild( new GRepere() );
			
			var bg:GBackground = addChild( new GBackground() ) as GBackground;
			bg.y = 20;
			bg.addEventListener( MouseEvent.MOUSE_DOWN, handleBgDown );
			
			bg.btMinimize.addEventListener( MouseEvent.MOUSE_DOWN, handleMinimizeDown );
			bg.btClose.addEventListener( MouseEvent.MOUSE_DOWN, handleBtCloseDown );
			
			bg.addEventListener( NativeDragEvent.NATIVE_DRAG_ENTER, handleDragEnter );
			
			var sysTrayIcon:SystemTrayIcon = NativeApplication.nativeApplication.icon as SystemTrayIcon;
			sysTrayIcon.tooltip = "(e)live";
			sysTrayIcon.addEventListener( MouseEvent.CLICK, handleUndock );
			
			var url:String = "xml/action_sheet.xml";
			var datasLoader:DatasLoader = new DatasLoader( url );
			datasLoader.addEventListener( Event.COMPLETE, handleLoadComplete );
			datasLoader.load();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function handleBgDown(e:MouseEvent):void 
		{
			stage.nativeWindow.startMove();
		}
		
		private function handleBtCloseDown(e:MouseEvent):void 
		{
			NativeApplication.nativeApplication.exit();
		}
		
		private function handleMinimizeDown(e:MouseEvent):void 
		{
			NativeApplication.nativeApplication.icon.bitmaps = [ new BitmapData( 20, 20, false, 0xff00ff ) ];
			stage.nativeWindow.visible = false;
		}
		
		private function handleDragEnter(e:NativeDragEvent):void 
		{
			NativeDragManager.acceptDragDrop( e.currentTarget as MovieClip );
			( e.currentTarget as MovieClip ).addEventListener( NativeDragEvent.NATIVE_DRAG_DROP, handlerBackDrop );
		}
		
		private function handleUndock(e:MouseEvent):void 
		{
			NativeApplication.nativeApplication.icon.bitmaps = [];
			stage.nativeWindow.visible = true;
		}
		
		private function handlerBackDrop(e:NativeDragEvent):void 
		{
			var files:/*File*/Array = e.clipboard.getData( ClipboardFormats.FILE_LIST_FORMAT ) as Array;
			trace( files );
			trace( files[ 0 ].deleteFile() );
		}
		
		private function handleLoadComplete(e:Event):void 
		{
			var datasLoader:DatasLoader = e.currentTarget as DatasLoader;
			var datas:String = datasLoader.getItemLoaded();
			trace( EliveXML.parseChallenges( XML( datas ), true ).length );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}