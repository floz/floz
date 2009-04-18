
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 * 
 * Version log :
 * 
 * 18.04.09		0.1		Floz		+ Première version
 */
package fr.minuit4.diaporama.types 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import fr.minuit4.diaporama.Diaporama;
	import fr.minuit4.utils.UBit;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class SlidingDiaporama extends Diaporama
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _toColor:uint;
		private var _transitionTime:Number;
		
		private var _imgHolder:BitmapData;
		private var _imgs:Bitmap;
		private var _fadingImg:BitmapData;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Creates a diaporama which will perform transition by sliding the images.
		 * @param	width	Number	The width of the diaporama.
		 * @param	height	Number	The height of the diaporama.
		 * @param	toColor	uint	The fading color.
		 * @param	transitionTime	Number	The transition time, in seconds.
		 */
		public function SlidingDiaporama( width:Number = -1, height:Number = -1, toColor:uint = 0x000000, transitionTime:Number = .5 ) 
		{
			this._toColor = toColor;
			this._transitionTime = transitionTime;
			super( width, height );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		/** Method called to perform the transistions */
		final override protected function show():void
		{
			dispatchEvent( _initEvent );
			TweenLite.to( _diaporamaCnt, _transitionTime, { x: -_width * _nextId, ease: Quad.easeOut, onComplete: finalStep } );
			_currentId = _nextId;
		}
		
		private function finalStep():void
		{
			dispatchEvent( _changeEvent );
		}
		
		/** Method called after the EVENT.REMOVED_FROM_STAGE event to clean the memory */
		final override protected function destroy():void 
		{
			TweenLite.killTweensOf( _diaporamaCnt );
			
			_images = null;
			_imgHolder.dispose();
			_imgHolder = null;
			_imgs.bitmapData.dispose();
			_imgs = null;
			_fadingImg.dispose();
			_fadingImg = null;
		}
		
		private function draw():void
		{
			var cnt:Sprite = new Sprite;
			
			var vx:Number = 0;
			var bmpd:BitmapData;
			var b:Bitmap;
			var i:int
			var n:int = _images.length;
			for ( i; i < n; ++i )
			{
				bmpd = new BitmapData( _images[ i ].width, _images[ i ].height, true, 0x00 );
				bmpd.draw( _images[ i ] );
				
				b = new Bitmap( UBit.resize( bmpd, _width, _height ), PixelSnapping.AUTO, true );
				b.x = vx;
				cnt.addChild( b );
				
				bmpd.dispose();
				
				vx += _width;
			}
			
			// memory optimization ?
			var s:Sprite;
			while ( _diaporamaCnt.numChildren )
			{
				s = _diaporamaCnt.getChildAt( 0 ) as Sprite;
				n = s.numChildren;
				for ( i = 0; i < n; ++i )
					Bitmap( s.getChildAt( i ) ).bitmapData.dispose();
				
				_diaporamaCnt.removeChildAt( 0 );
			}
			
			_diaporamaCnt.addChild( cnt );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Add one image to the diaporama.
		 * To add more than one image per one image, use the addImages method.
		 * @param	image	DisplayObject	The displayobject to add into the diaporama's list of images.
		 * @param	clean	Boolean	If this param is passed on true, the list of images previously add will be delete, and a new one will be created.
		 */
		final override public function addImage( image:DisplayObject, clean:Boolean = false ):void
		{
			super.addImage( image, clean );
			draw();
		}
		
		/**
		 * Add images to the diaporama.
		 * @param	image	Array	A list of displayobject that will be show in the diaporama.
		 * @param	clean	Boolean	If this param is passed on true, the list of images previously add will be delete, and a new one will be created.
		 */
		final override public function addImages( images:Array, clean:Boolean = false ):void
		{
			super.addImages( images, clean );
			draw();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}