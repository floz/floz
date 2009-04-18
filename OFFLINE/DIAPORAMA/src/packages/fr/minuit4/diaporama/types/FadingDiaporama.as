
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 * 
 * Version log :
 * 
 * 18.04.09		0.9		Floz		+ Première version
 */
package fr.minuit4.diaporama.types 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import fr.minuit4.diaporama.Diaporama;
	import fr.minuit4.utils.UBit;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class FadingDiaporama extends Diaporama
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _toColor:uint;
		private var _transitionTime:Number;
		
		private var _imgHolder:BitmapData;
		private var _fadingImg:Bitmap;
		
		private var _imgTmp:BitmapData;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Creates a diaporama which will perform transitions by fading to a color.
		 * @param	width	Number	The width of the diaporama.
		 * @param	height	Number	The height of the diaporama.
		 * @param	toColor	uint	The fading color.
		 * @param	transitionTime	Number	The transition time, in seconds.
		 */
		public function FadingDiaporama( width:Number = -1, height:Number = -1, toColor:uint = 0x000000, transitionTime:Number = .5 ) 
		{
			this._toColor = toColor;
			this._transitionTime = transitionTime;
			super( width, height );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		/** Method called at the end of the constructor */
		final override protected function initDiaporama():void
		{
			_imgHolder = new BitmapData( _width, _height, true, 0x00 );
			_diaporamaCnt.addChild( new Bitmap( _imgHolder, PixelSnapping.AUTO, true ) );
			
			if ( !_fadingImg || !_fadingImg.parent )
			{
				var bmpd:BitmapData = new BitmapData( _width, _height, false, _toColor );
				_fadingImg = new Bitmap( bmpd, PixelSnapping.AUTO, true );
				_fadingImg.alpha = 1;
				_diaporamaCnt.addChild( _fadingImg );
			}
		}
		
		/** Method called to perform the transistions */
		final override protected function show():void
		{
			dispatchEvent( _initEvent );			
			TweenLite.to( _fadingImg, _inited ? _transitionTime * .5 : _transitionTime * .25, { alpha: 1, ease: Quad.easeOut, onComplete: secondStep } );
		}
		
		private function secondStep():void
		{
			if( _imgTmp ) _imgTmp.dispose();
			_imgTmp = new BitmapData( _images[ _nextId ].width, _images[ _nextId ].height, true, 0x00 );
			_imgTmp.draw( _images[ _nextId ] );
			_imgHolder.draw( UBit.resize( _imgTmp, _width, _height, true, false, false ) );
			
			_currentId = _nextId;
			
			TweenLite.to( _fadingImg, _inited ? _transitionTime * .5 : _transitionTime * .25, { alpha: 0, ease: Quad.easeOut, onComplete: finalStep } );
		}
		
		private function finalStep():void
		{
			if ( !_inited ) _inited = true;
			dispatchEvent( _completeEvent );
		}
		
		/** Method called after the EVENT.REMOVED_FROM_STAGE event to clean the memory */
		final override protected function destroy():void
		{
			TweenLite.killTweensOf( _fadingImg );
			
			_imgTmp.dispose();
			_imgTmp = null;
			_imgHolder.dispose();
			_imgHolder = null;
			_fadingImg.bitmapData.dispose();
			_fadingImg = null;
			
			_images = null;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}