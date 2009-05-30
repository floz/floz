
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	
	[SWF( backgroundColor='0x000000', frameRate='30', width='400', height='400')]
	public class Main extends Sprite
	{
		
		// - STATIC ----------------------------------------------------------------------
		
		public static const NUM_PARTICLES:int = 0xff;
		public static const RAYON:Number = 400;
		public static const CMF:ColorMatrixFilter = new ColorMatrixFilter( [ 1, 0, 0, 0, 0,
																			0, 1, 0, 0, 0,
																			0, 0, 1, 0, 0,
																			0, 0, 0, .95, 0 ] );
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		[Embed(source = '../assets/boards.mp3')]
		private var SongAssets:Class;
		private var _song:Sound;
		private var _bytes:ByteArray;	
		private var _spectrum:BitmapData;
		private var _particles:Particle;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			init();
			
			stage.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onClick(e:MouseEvent):void 
		{
			if ( hasEventListener( Event.ENTER_FRAME ) )
			{
				SoundMixer.stopAll();				
				_spectrum.fillRect( _spectrum.rect, 0x00 );
				
				removeEventListener( Event.ENTER_FRAME, onFrame );
			}
			else
			{
				_song.play();
				
				addEventListener( Event.ENTER_FRAME, onFrame );
			}
		}
		
		private function onFrame(e:Event):void 
		{
			SoundMixer.computeSpectrum( _bytes, false, 0 );
			
			var value:Number;
			
			var a:Number;
			var r:Number;
			
			var particle:Particle = _particles;
			
			_spectrum.lock();
			while ( particle )
			{
				value = _bytes.readFloat();
				
				a = toRadians( Math.random() * 360 );
				r = value * RAYON;
				_spectrum.setPixel( particle.px + r * Math.cos( a ), particle.py + r * Math.sin( a ), 0xffffff );
				
				particle = particle.next;
			}
			_spectrum.applyFilter( _spectrum, _spectrum.rect, new Point(), CMF );
			_spectrum.unlock();			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_song = Sound( new SongAssets() );
			
			_bytes = new ByteArray();
			
			_spectrum = new BitmapData( stage.stageWidth, stage.stageHeight, false, 0 );
			addChild( new Bitmap( _spectrum, PixelSnapping.NEVER, false ) );
			
			createParticles();
			setParticlesPositions();
		}
		
		private function createParticles():void
		{
			_particles = new Particle();
			
			var currentParticle:Particle = _particles;
			var numParticles:int = NUM_PARTICLES;
			
			while ( --numParticles != 0 )
				currentParticle = currentParticle.next = new Particle();
		}
		
		private function setParticlesPositions():void
		{
			var particle:Particle = _particles;
			
			var px:Number = stage.stageWidth * .5;
			var py:Number = stage.stageHeight * .5;
			
			while ( particle )
			{
				particle.px = px;
				particle.py = py;
				
				particle = particle.next;
			}
		}
		
		private function toRadians( value:Number ):Number
		{
			return ( value * Math.PI / 180 );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}