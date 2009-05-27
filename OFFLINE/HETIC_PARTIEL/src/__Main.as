
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
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	
	[SWF( backgroundColor='0x000000', frameRate='30', width='400', height='400')]
	public class Main extends Sprite
	{
		
		// - STATIC ----------------------------------------------------------------------
		
		public static const NUM_PARTICLES:int = 500;
		public static const CMF:ColorMatrixFilter = new ColorMatrixFilter( [ 1, 0, 0, 0, 0,
																			0, 1, 0, 0, 0,
																			0, 0, 1, 0, 0,
																			0, 0, 0, .9, 0 ] );
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		[Embed(source = '../assets/boards.mp3')]
		private var SongAssets:Class;
		private var _song:Sound;
		private var _bytes:ByteArray;	
		private var _buffer:Vector.<uint>;
		private var _bufferLength:int;
		private var _spectrum:BitmapData;
		private var _particles:Particle;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			init();
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onFrame(e:Event):void 
		{
			SoundMixer.computeSpectrum( _bytes, false, 0 );
			
			var w:Number = stage.stageWidth;
			var h:Number = stage.stageHeight;
			var value:Number;
			
			var a:Number;
			var r:Number;
			var bufferIndex:int;
			
			var px:int;
			var py:int;
			
			var particle:Particle = _particles;
			
			var n:int = _bufferLength;
			while ( --n > -1 ) _buffer[ n ] = 0x11000000;
			
			while ( particle )
			{
				value = _bytes.readFloat();
				
				a = toRadians( Math.random() * 360 );
				r = value * 300;
				
				px = particle.px + r * Math.cos( a );
				py = particle.py + r * Math.sin( a );
				bufferIndex = int( px + int( py * 400 ) );
				if ( bufferIndex > 0 && bufferIndex < _bufferLength )
					_buffer[ bufferIndex ] = 0xffffff;
				
				particle = particle.next;
			}
			
			_spectrum.lock();
			_spectrum.setVector( _spectrum.rect, _buffer );
			_spectrum.unlock();
			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_song = Sound( new SongAssets() );
			_song.play();
			
			_bytes = new ByteArray();
			_buffer = new Vector.<uint>( stage.stageWidth * stage.stageHeight, true );
			_bufferLength = _buffer.length;
			
			var n:int = _bufferLength;
			while ( --n > -1 ) _buffer[ n ] = 0x000000;
			
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