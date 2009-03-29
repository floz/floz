
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.Timer;
	import fr.minuit4.tools.loaders.types.ImageLoader;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class LoadingPanel extends MovieClip
	{		
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _request:URLRequest;
		private var _fileReference:FileReference;
		private var _imageLoader:ImageLoader;
		private var _timer:Timer;
		
		private var _loadText:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var loadingBar:MovieClip;
		public var loadingText:TextField;
		public var bg:MovieClip;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function LoadingPanel() 
		{
			this.visible = false;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			this.x = 980 * .5 - this.width * .5
			this.y = 560 * .5 - this.height * .5
			
			_request = new URLRequest();
			_fileReference = new FileReference();
			_fileReference.addEventListener( Event.CANCEL, onCancel );
			_fileReference.addEventListener( Event.SELECT, onSelect );
			_fileReference.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_fileReference.addEventListener( ProgressEvent.PROGRESS, onProgress );
			_fileReference.addEventListener( DataEvent.UPLOAD_COMPLETE_DATA, onUploadComplete );
			
			_imageLoader = new ImageLoader();
			_imageLoader.addEventListener( ProgressEvent.PROGRESS, onProgress );
			_imageLoader.addEventListener( Event.COMPLETE, onLoadComplete );
			
			_timer = new Timer( 1000, 1 );
			_timer.addEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
		}
		
		private function onCancel(e:Event):void 
		{
			Model.enable = true;
			dispatchEvent( new Event( Event.CANCEL ) );
		}
		
		private function onSelect(e:Event):void 
		{
			_fileReference.upload( _request );
			
			this.alpha = 0;
			this.visible = true;
			TweenLite.to( this, .4, { alpha: 1, ease: Quad.easeOut } );
			loadingText.text = "Envoie des données relatives à la photo.";
			_loadText = "Envoie de la photo : ";
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace( "ControlPanel.onIOError > " + _request.url );			
		}
		
		private function onProgress(e:ProgressEvent):void 
		{
			loadingBar.scaleX = e.bytesLoaded / e.bytesTotal;
			loadingText.text = _loadText + e.bytesLoaded * 100 / e.bytesTotal + "%";
		}
		
		private function onUploadComplete(e:DataEvent):void 
		{
			if ( e.data == "0" )
			{
				displayError();
				return;
			}
			_loadText = "Téléchargement de la photo : ";
			_imageLoader.load( Model.PATH_PHP + Model.PHP_UPLOAD_DIR + "/" + e.data );
		}
		
		private function onLoadComplete(e:Event):void 
		{
			loadingText.text = "Chargement effectué.";
			
			Model.userPhoto = Bitmap( _imageLoader.getItemLoaded() ).bitmapData.clone();
			dispatchEvent( new Event( Event.COMPLETE ) );
			
			_timer.reset();
			_timer.start();
		}
		
		private function onTimerComplete(e:TimerEvent):void 
		{
			TweenLite.to( this, .4, { alpha: 0, ease: Quad.easeOut, onComplete: setVisibleFalse } );
			dispatchEvent( new Event( Event.CANCEL ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function displayError():void
		{
			loadingText.text = "Le fichier n'est pas valide.";
			_timer.reset();
			_timer.start();
		}
		
		private function setVisibleFalse():void
		{
			this.visible = false;
			Model.enable = true;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function upload():void
		{
			_request.url = Model.PATH_PHP + Model.PHP_UPLOAD_FILE + "?uploadDir=" + Model.PHP_UPLOAD_DIR;
			_fileReference.browse( [ Model.IMAGE_TYPE ] );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}