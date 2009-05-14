
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 * 
 * Version log :
 * 
 * 18.04.09		0.1		Floz		+ First version
 */
package fr.minuit4.tools.diaporama 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Diaporama extends Sprite
	{
		public static const SWITCH_COMPLETE:String = "diaporama_switch_complete";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _width:Number;
		protected var _height:Number;
		protected var _diaporamaCnt:Sprite;
		private var _mask:Shape;
		protected var _images:Array;
		protected var _initEvent:Event;
		protected var _changeEvent:Event;
		
		private var _timer:Timer;
		private var _playing:Boolean;
		
		protected var _currentId:int;
		protected var _nextId:int;
		
		protected var _inited:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Creates a diaporama object.
		 * @param	width	Number	The width of the diaporama.
		 * @param	height	Number	The height of the diaporama.
		 */
		public function Diaporama( width:Number = -1, height:Number = -1 ) 
		{
			this._width = width == -1 ? this.width : width;
			this._height = height == -1 ? this.height : height;
			
			_diaporamaCnt = new Sprite();
			addChild( _diaporamaCnt );
			
			_mask = new Shape();
			_mask.graphics.beginFill( 0x00, 1 );
			_mask.graphics.drawRect( 0, 0, _width, _height );
			_mask.graphics.endFill();
			addChild( _mask );
			
			_diaporamaCnt.mask = _mask;
			
			_images = [];
			
			_timer = new Timer( 1000, 0 );
			_timer.addEventListener( TimerEvent.TIMER, onTimer );
			
			initDiaporama();
			
			_initEvent = new Event( Event.INIT );
			_changeEvent = new Event( Event.CHANGE );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			_timer.removeEventListener( TimerEvent.TIMER, onTimer );
			
			destroy();
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			next();
			dispatchEvent( new Event( Diaporama.SWITCH_COMPLETE ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		/** Method called at the end of the constructor */
		protected function initDiaporama():void
		{
			// Define the diaporama content into the _diaporamaCnt
		}
		
		/** Method called to perform the transistions */
		protected function show():void
		{
			// Perform the transition between the diaporama images
		}
		
		/** Method called after the EVENT.REMOVED_FROM_STAGE event to clean the memory */
		protected function destroy():void
		{
			// Liberate the memory by killing definitly the diaporama
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Add one image to the diaporama.
		 * To add more than one image per one image, use the addImages method.
		 * @param	image	DisplayObject	The displayobject to add into the diaporama's list of images.
		 * @param	clean	Boolean	If this param is passed on true, the list of images previously add will be delete, and a new one will be created.
		 */
		public function addImage( image:DisplayObject, clean:Boolean = false ):void
		{
			if ( clean )
				_images = [];
			
			_images.push( image );
		}
		
		/**
		 * Add images to the diaporama.
		 * @param	image	Array	A list of displayobject that will be show in the diaporama.
		 * @param	clean	Boolean	If this param is passed on true, the list of images previously add will be delete, and a new one will be created.
		 */
		public function addImages( images:Array, clean:Boolean = false ):void
		{
			if ( clean )
			{
				_images = images;
				return;
			}
			
			var n:int = images.length;
			for ( var i:int; i < n; ++i )
			{
				if ( !( images[ i ] is DisplayObject ) )
					throw new TypeError( "The array must only contain DisplayObject" );
				_images.push( images[ i ] );
			}
		}
		
		/** Put the diaporama on his first state. */
		public function clearImages():void
		{
			_images = [];
			_currentId = 0;
			while ( _diaporamaCnt.numChildren ) _diaporamaCnt.removeChildAt( 0 );
			_diaporamaCnt.x = 0;
		}
		
		/** Display the next image */
		public function next():void
		{
			if ( !totalCount ) return;
			_nextId = _currentId >= int( totalCount - 1 ) ? 0 : _currentId + 1;
			show();
		}
		
		/** Display the previous image */
		public function previous():void
		{
			if ( !totalCount ) return;
			_nextId = _currentId <= 0 ? int( totalCount - 1 ) : _currentId-1;
			show();
		}
		
		/**
		 * Display an image at the position passed by param/
		 * @param	id	int	The index of the image to display.
		 */
		public function to( id:int ):void
		{
			if ( id == _currentId || !totalCount ) return;
			if ( id < 0 ) id = 0;
			if ( id >= totalCount ) id = int( totalCount - 1 );
			
			_nextId = id;
			show();
		}
		
		/**
		 * Launch the diaporama mode. The images will be display one per one.
		 * @param	delay	Number	The delay (in ms) between the switch of image.
		 */
		public function startDiaporamaMode( delay:Number = 5000 ):void
		{
			_playing = true;
			
			if ( _timer.running )
			{
				_timer.reset();
				_timer.stop();
			}
			_timer.delay = delay;
			_timer.start();
		}
		
		/** Stop the diaporama mode */
		public function stopDiaporamaMode():void
		{
			_playing = false;
			
			if ( _timer.running )
			{
				_timer.stop();
				_timer.reset();
			}
		}
		
		public function isPlaying():Boolean { return _playing; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		/** Return the current id of the image displayed */
		public function get currentId():int { return _currentId; }
		
		/** Return the total count of images */
		public function get totalCount():int { return _images.length }
		
	}
	
}