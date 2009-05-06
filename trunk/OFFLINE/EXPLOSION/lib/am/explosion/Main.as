package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	[SWF( backgroundColor='0x10101a', frameRate='44', width='384', height='384')]

	public class Main extends Sprite
	{
		private const WIDTH: int = 384;
		private const HEIGHT: int = 384;
		
		private const ORIGIN: Point = new Point();
		
		//-- APPEARANCE
		private const EXPLOSION_BLUR_STRENGTH: int = 2;
		private const EXPLOSION_BLUR_QUALITY: int = 1;
		
		private var blur: BlurFilter;
		
		private var buffer: BitmapData;
		private var output: BitmapData;
		
		private var explosions: Array;
		private var fireColors: Array;
		
		[Embed(source='bin/explosion.mp3')]
		private var ExplosionSoundAsset: Class;
		private var explosionSound: Sound;
	
		public function Main()
		{
			init();
		}
		
		private function init(): void
		{
			buffer = new BitmapData( WIDTH, HEIGHT, false, 0 );
			output = new BitmapData( WIDTH, HEIGHT, false, 0 );
			
			explosionSound = Sound( new ExplosionSoundAsset() );
			
			blur = new BlurFilter( EXPLOSION_BLUR_STRENGTH, EXPLOSION_BLUR_STRENGTH, EXPLOSION_BLUR_QUALITY );
			
			fireColors = Gradient.getArray
			(
				[ 0, 0, 0x333333, 0xff0000, 0xffff00, 0xffffff ],
				[ 0, 0, 1, 1, 1, 1 ],
				[ 0, 0x22, 0x44, 0x55, 0x88, 0xff ]
			);
			
			addChild( new Bitmap( output ) );
			
			explosions = new Array();
			
			stage.addEventListener( MouseEvent.MOUSE_DOWN, createExplosion );
			stage.addEventListener( Event.ENTER_FRAME, render );
		}
		
		private function createExplosion( event: Event ): void
		{
			var explosion: Explosion = new Explosion( mouseX, mouseY );
			
			explosions.push( explosion );
			
			explosionSound.play();
		}
		
		private function render( event: Event ): void
		{
			var explosion: Explosion;
			var i: int = explosions.length;
			while( --i > -1 )
			{
				explosion = explosions[i];
				explosion.render( buffer );
			}
			
			buffer.applyFilter( buffer, buffer.rect, ORIGIN, blur );			
			output.copyPixels( buffer, buffer.rect, ORIGIN );
			output.paletteMap( output, output.rect, ORIGIN, [], [], fireColors, [] );
		}
	}
}
