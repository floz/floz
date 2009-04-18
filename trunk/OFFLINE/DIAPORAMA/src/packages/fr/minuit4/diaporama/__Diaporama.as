
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.diaporama 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	import fr.minuit4.utils.UBit;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class Diaporama extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _width:Number;
		private var _height:Number;
		private var _transition:Boolean;
		private var _imageHolder:BitmapData;
		private var _mask:Shape;
		private var _image:BitmapData;
		private var _initEvent:Event;
		private var _changeEvent:Event;
		private var _completeEvent:Event;
		
		private var _timer:Timer;
		
		protected var _images:Array;
		protected var _currentId:int;
		protected var _nextId:int;
		
		private var _tmpImage:BitmapData;
		
		private var _activated:Boolean;		
		private var _transValues:Object;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Diaporama( width:Number = -1, height:Number = -1, transition:Boolean = false ) 
		{
			this._width = width == -1 ? this.width : width;
			this._height = height == -1 ? this.height : height;
			this._transition = transition;
			
			_imageHolder = new BitmapData( _width, _height, true, 0x00 );
			var bImageHolder:Bitmap = new Bitmap( _imageHolder, PixelSnapping.AUTO, true );
			addChild( bImageHolder );
			
			_mask = new Shape();
			_mask.graphics.beginFill( 0x00, 1 );
			_mask.graphics.drawRect( 0, 0, _width, _height );
			_mask.graphics.endFill();
			addChild( _mask );
			
			bImageHolder.mask = _mask;
			
			_image = new BitmapData( _width, _height, true, 0x00 );
			_initEvent = new Event( Event.INIT );
			_changeEvent = new Event( Event.CHANGE );
			_completeEvent = new Event( Event.COMPLETE );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			_image.dispose();
			_image = null;
			
			_tmpImage.dispose();
			_tmpImage = null;
			
			_imageHolder.dispose();
			_imageHolder = null;
			
			_initEvent =
			_completeEvent = null;
			
			_images = null;
			
			_transValues = null;
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			_timer = new Timer( 1000, 0 );
			_timer.addEventListener( TimerEvent.TIMER, onTimer );
			
			_activated = true;
			_transValues = { vx: 0 };
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			next();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function show():void
		{
			dispatchEvent( _initEvent );
			
			if ( _tmpImage ) _tmpImage.dispose();
			if ( totalCount )
			{
				_tmpImage = new BitmapData( _images[ _currentId ].width, _images[ _currentId ].height, true, 0x00 )
				_tmpImage.draw( _images[ _currentId ] );
			}
			else _tmpImage = new BitmapData( _width, _height, false, 0x000000 );
			
			_image.draw( UBit.resize( _tmpImage, _width, _height, true, false, false ) );
			
			if ( _transition )
			{
				_activated = false;
				_transValues.vx = _width;
				TweenLite.to( _transValues, .5, { vx: 0, ease: Quad.easeOut, onUpdate: draw, onComplete: drawComplete } );
			}
			else 
			{
				_imageHolder.draw( _image );
			}
		}
		
		private function draw():void
		{
			_imageHolder.lock();
			_imageHolder.draw( _image, new Matrix( 1, 0, 0, 1, _transValues.vx, 0 ) );
			_imageHolder.unlock();
		}
		
		private function drawComplete():void
		{
			_activated = true;
			dispatchEvent( _completeEvent );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function init():void
		{
			show();
		}
		
		public function addImage( image:DisplayObject, clean:Boolean = false ):void
		{
			if ( clean || !_images )
				_images = [];
			
			_images.push( image );
		}
		
		public function addImages( images:Array, clean:Boolean = false ):void
		{
			if ( clean )
			{
				_images = images;
				return;
			}
			if ( !_images ) _images = [];
			
			var n:int = images.length;
			for ( var i:int; i < n; ++i )
			{
				if ( !( images[ i ] is DisplayObject ) )
					throw new TypeError( "The array must only contain DisplayObject" );
				_images.push( images[ i ] );
			}
		}
		
		public function clearImages():void
		{
			_images = [];
			_currentId = 0;
			show();
		}
		
		public function next():void
		{
			if ( !totalCount || !_activated ) return;
			_nextId = _currentId == int( getImagesCount() - 1 ) ? 0 : _currentId + 1;
			show();
		}
		
		public function previous():void
		{
			if ( !totalCount  || !_activated ) return;
			_nextId = !_currentId ? int( getImagesCount() - 1 ) : _currentId-1;
			show();
		}
		
		public function to( id:int ):void
		{
			if ( !_activated )
			{
				trace( "A transition is already performing, please wait." )
				return;
			}
			_nextId = id;
			show();
		}
		
		public function startDiaporamaMode( delay:Number = 2500 ):void
		{
			_timer.delay = delay;
			_timer.start();
		}
		
		public function stopDiaporamaMode():void
		{
			_timer.stop();
			_timer.reset();
		}
		
		public function getCurrentImageId():int
		{
			return _currentId;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get totalCount():int { return _images.length; }
		
	}
	
}