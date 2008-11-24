package de.popforge.coverflow 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;	

	/**
	 * @author aM
	 */
	public class Cover extends Sprite
	{
		static private const EASE_MULT_X: Number = .10;
		static private const EASE_MULT_Z: Number = .14;
		static private const EASE_MULT_A: Number = .14;

		static public const SIZE: Number = 180.0;
		
		private const _solid: Bitmap = new Bitmap( null, PixelSnapping.ALWAYS, true );
		private const _alpha: Bitmap = new Bitmap( null, PixelSnapping.ALWAYS, true );
		
		private const _colorTransform: ColorTransform = new ColorTransform( 1.0, 1.0, 1.0, 1.0 );
		private const _darkenTransform: ColorTransform = new ColorTransform( .4, .4, .4, 1.0, -8, -8, -8 );
		
		private const _current: CoverDisplace = new CoverDisplace();
		private const _target: CoverDisplace = new CoverDisplace();
		
		private var _bitmapData: BitmapData;
		
		private var _darken: Number;

		public function Cover( bitmapData: BitmapData )
		{
			this.bitmapData = bitmapData;
			
			_init( );
		}
		
		public function set bitmapData( bitmapData: BitmapData ): void
		{
			var rt: Number;
			var wd: Number = bitmapData.width;
			var ht: Number = bitmapData.height;
			
			if( wd > ht )
				rt = SIZE / wd;
			else
				rt = SIZE / ht;
			
			wd *= rt;
			ht *= rt;
			
			_alpha.bitmapData =
			_solid.bitmapData = bitmapData;
			_alpha.smoothing =
			_solid.smoothing = true;
			_alpha.x =
			_solid.x = -( wd >> 1 );
			_alpha.y = SIZE * .5 + ht;
			_solid.y = SIZE * .5 - ht;
			_solid.scaleX =
			_solid.scaleY = rt;
			_alpha.scaleX = rt;
			_alpha.scaleY = -rt;

			_bitmapData = bitmapData;
		}

		public function get bitmapData(): BitmapData
		{
			return _bitmapData;
		}
		
		public function get currentDisplace(): CoverDisplace
		{
			return _current;
		}
		
		public function get targetDisplace(): CoverDisplace
		{
			return _target;
		}
		
		public function hardSet(): void
		{
			x = _current.x = _target.x;
			z = _current.z = _target.z;
			rotationY = _current.a = _target.a;
		}
		
		public function easeSet(): Boolean
		{
			var epsilon: Number = .25;
			var complete: Boolean = true;
			var displace: Number;
			
			if( Math.abs( displace = _target.x - _current.x ) > epsilon )
				complete = false;

			_current.x += displace * EASE_MULT_X;
			
			if( Math.abs( displace = _target.z - _current.z ) > epsilon )
				complete = false;

			_current.z += displace * EASE_MULT_Z;
			
			if( Math.abs( displace = _target.a - _current.a ) > epsilon )
				complete = false;

			_current.a += displace * EASE_MULT_A;
			
			x = _current.x;
			z = _current.z;
			rotationY = _current.a;
			
			return complete;
		}
		
		public function set darken( darken: Number ): void
		{
			_colorTransform.redMultiplier = 
			_colorTransform.greenMultiplier = 
			_colorTransform.blueMultiplier = darken;

			transform.colorTransform = _colorTransform;
			
			_darken = darken;
		}
		
		public function get darken(): Number
		{
			return _darken;
		}

		private function _init(): void
		{
			_alpha.transform.colorTransform = _darkenTransform;
			
			addChild( _solid );
			addChild( _alpha );
		}
	}
}
