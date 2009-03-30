
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
	import flash.events.ProgressEvent;
	import fr.minuit4.tools.loaders.types.ImageLoader;
	import fr.minuit4.tools.loaders.types.TextLoader;
	import fr.minuit4.tools.Loading;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class Main extends MovieClip
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _loading:Loading;
		private var _xml:XML;
		private var _xmlLoader:TextLoader;
		private var _masksToLoad:Array;
		private var _loadIdx:int;
		private var _imageLoader:ImageLoader;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var masksPanel:MasksPanel;
		public var controlPanel:ControlPanel;
		public var settingsPanel:SettingsPanel;
		public var loadingPanel:LoadingPanel;
		public var beatlizer:Beatlizer;
		public var form:Form;
		public var curtain:MovieClip;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			_loading = new Loading();
			_loading.x = 980 * .5 - _loading.width * .5;
			_loading.y = 560 * .5 - _loading.height * .5;
			addChild( _loading );
			_loading.play();
			
			masksPanel.visible = 
			controlPanel.visible =
			settingsPanel.visible =
			loadingPanel.visible =
			beatlizer.visible =
			form.visible = 
			curtain.visible = false;
			
			_xmlLoader = new TextLoader();
			_xmlLoader.addEventListener( Event.COMPLETE, onXMLComplete );
			_xmlLoader.load( path_xml + "datas.xml" );
		}
		
		private function onXMLComplete(e:Event):void 
		{
			_xml = XML( _xmlLoader.getItemLoaded() );
			_masksToLoad = getXMLDatas();
			_xmlLoader.destroy();
			
			_imageLoader = new ImageLoader();
			_imageLoader.addEventListener( Event.COMPLETE, onImgComplete );
			_imageLoader.load( Model.PATH_MASKS + _masksToLoad[ _loadIdx ] );
		}
		
		private function onImgComplete(e:Event):void 
		{
			Model.MASKS.push( Bitmap( _imageLoader.getItemLoaded() ).bitmapData.clone() );
			
			if ( _loadIdx++ < _masksToLoad.length - 1)
			{
				_imageLoader.load( Model.PATH_MASKS + _masksToLoad[ _loadIdx ] );
				return;
			}
			init();
			_imageLoader.destroy();
		}
		
		private function onUpload(e:Event):void 
		{
			if ( Model.initialized )
			{
				curtain.visible = true;
				curtain.alpha = 0;
				TweenLite.to( curtain, .4, { alpha: .8, ease: Quad.easeOut } );
			}
			
			Model.enable = false;
			loadingPanel.upload();
		}
		
		private function onValidBeatles(e:Event):void 
		{
			form.display();
			
			curtain.visible = true;
			curtain.alpha = 0;
			TweenLite.to( curtain, .4, { alpha: .8, ease: Quad.easeOut } );
		}
		
		private function onCancel(e:Event = null):void 
		{
			if( Model.initialized ) TweenLite.to( curtain, .4, { alpha: 0, ease: Quad.easeOut, onComplete: killCurtain } );
		}
		
		private function onSelect(e:Event):void 
		{
			swapChildren( curtain, controlPanel );
		}
		
		private function onLoadComplete(e:Event):void 
		{
			if ( !Model.initialized )
			{
				controlPanel.init();
				masksPanel.init();
				settingsPanel.init();
				beatlizer.setMask();
				
				Model.initialized = true;
			}
			settingsPanel.resetSaturation();
			beatlizer.setPhoto();
		}
		
		private function onMaskSelected(e:Event):void 
		{
			beatlizer.setMask();
		}
		
		private function onValueChange(e:Event):void 
		{
			beatlizer.setPhotoSaturation();
			beatlizer.setPhotoScale();
			beatlizer.setRotation();
		}
		
		private function onStepBack(e:Event):void 
		{
			form.hide();
			onCancel();
		}
		
		private function onEnd(e:Event):void 
		{
			trace( "this is the end" );
		}
		
		private function onResize(e:Event = null):void 
		{
			curtain.x = -( stage.stageWidth * .5 - 980 * .5 );
			curtain.y = -( stage.stageHeight * .5 - 560 * .5 );
			curtain.width = stage.stageWidth;
			curtain.height = stage.stageHeight;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function killCurtain():void
		{
			curtain.visible = false;
			curtain.alpha = 0;
		}
		
		private function init():void
		{
			Model.PATH_PHP = path_php;
			Model.enable = true;
			
			_loading.stop();
			removeChild( _loading );
			_loading = null;
			
			curtain.alpha = 0;
			swapChildren( curtain, controlPanel );
			
			masksPanel.visible = 
			controlPanel.visible =
			settingsPanel.visible =
			beatlizer.visible =
			form.visible = 
			curtain.visible = true;
			
			TweenLite.to( curtain, .4, { alpha: .8, ease: Quad.easeOut } );
			
			form.visible = false;
			
			controlPanel.addEventListener( ControlPanel.UPLOAD, onUpload );
			controlPanel.addEventListener( ControlPanel.VALID_BEATLES, onValidBeatles );
			
			loadingPanel.addEventListener( Event.CANCEL, onCancel );
			loadingPanel.addEventListener( Event.SELECT, onSelect );
			loadingPanel.addEventListener( Event.COMPLETE, onLoadComplete );
			
			masksPanel.initBeatlesHolders();
			masksPanel.addEventListener( MasksPanel.MASK_SELECTED, onMaskSelected );
			
			settingsPanel.addEventListener( SettingsPanel.VALUE_CHANGE, onValueChange );
			
			form.addEventListener( Form.STEP_BACK, onStepBack );
			form.addEventListener( Form.END, onEnd );
			
			stage.addEventListener( Event.RESIZE, onResize );
			onResize();
		}
		
		private function getXMLDatas():Array
		{
			var x:XML;
			
			Model.PATH_MASKS = _xml.path.@masks;

			
			var a:Array = [];
			for each( x in _xml[ "mask" ] ) a.push( x.@img );
			
			return a;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get path_php():String { return loaderInfo.parameters[ "path_php" ] || "http://localhost/BEATLIZER/bin/assets/php/"; }
		public function get path_xml():String { return loaderInfo.parameters[ "path_xml" ] || "assets/xml/"; }
		
	}
	
}