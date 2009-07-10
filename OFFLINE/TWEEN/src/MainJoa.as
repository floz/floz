package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;	

	[SWF(width='550',height='400',frameRate='32',backgroundColor='0x000000')]

	/**
	 * @author Joa Ebert
	 */
	public final class MainJoa extends Sprite 
	{
		private const MAX_PARTICLES: int = 0x400 * 300;
		private const _screen: BitmapData = new BitmapData( 550, 400, false, 0 );
		private const _buffer: Vector.<uint> = new Vector.<uint>( 550 * 400, true );
		private const _matrix: Matrix3D = new Matrix3D();
		private var _particles: Particle;
		private var _focalLength: Number;
		private var _targetX: Number = 0.0;
		private var _targetY: Number = 0.0;
		
		public function MainJoa()
		{
			screenSetup();
			createParticles();
			calculatePositions();

			addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}

		private function screenSetup(): void
		{
			var perspectiveProjection: PerspectiveProjection = new PerspectiveProjection( );
			perspectiveProjection.fieldOfView = 60.0;
			_focalLength = perspectiveProjection.focalLength;
			
			stage.align = StageAlign.TOP_LEFT;
			stage.frameRate = 32.0;
			stage.fullScreenSourceRect = new Rectangle( 0.0, 0.0, 550.0, 400.0 );
			stage.quality = StageQuality.LOW;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			addChild( new Bitmap( _screen, PixelSnapping.NEVER, false ) );
			
			var tf : TextFormat = new TextFormat();
			tf.font = 'arial';
			tf.size = 10;
			tf.color = 0xffffff;
			
			var textField: TextField = new TextField();
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.defaultTextFormat = tf;
			textField.selectable = false;
			textField.text = 'blog.joa-ebert.com : Pushing ' + MAX_PARTICLES + ' particles (pure ActionScript 3).';
			textField.y = 400 - textField.height;
			textField.opaqueBackground = 0x000000;
			addChild( textField );
		}
		
		private function createParticles(): void
		{
			if( 1 > MAX_PARTICLES )
				return;
		
			_particles = new Particle();
			
			var currentParticle: Particle = _particles;
			var numParticles: int = MAX_PARTICLES;
			
			while( --numParticles != 0 )
				currentParticle = currentParticle.next = new Particle();
			
			trace( currentParticle.next );
		}
		
		private function calculatePositions(): void
		{
			var _a:Number = 1.111;
			var _b:Number = 1.479;
			var _f:Number = 4.494;
			var _g:Number = 0.44;
		 	var _d:Number = 0.135;
			var cx:Number = 1;
			var cy:Number = 1;
			var cz:Number = 1;
			var mx:Number = 0;
			var my:Number = 0;
			var mz:Number = 0;
			
			var scale:Number = 40;
			var particle: Particle = _particles;
			
			while( null != particle )
			{
				mx = cx + _d * (-_a * cx - cy * cy - cz * cz + _a * _f);
				my = cy + _d * (-cy + cx * cy - _b * cx * cz + _g);
				mz = cz + _d * (-cz + _b * cx * cy + cx * cz);
				
				cx = mx;
				cy = my;
				cz = mz;
				
				particle.x = mx * scale;
				particle.y = my * scale;
				particle.z = mz * scale;
				
				particle = particle.next;
			}
			trace( "ici : " );
			trace( particle );
		}
		
		private function onEnterFrame( event: Event ): void
		{
			_targetX += ( mouseX - _targetX ) * 0.1;
			_targetY += ( mouseY - _targetY ) * 0.1;
			
			_matrix.identity();
			_matrix.appendRotation( _targetX, Vector3D.Y_AXIS );
			_matrix.appendRotation( _targetY, Vector3D.X_AXIS );
			_matrix.appendTranslation( 0.0, 0.0, 10.0 );
			
			var particle: Particle = _particles;
			
			var x: Number;
			var y: Number;
			var z: Number;
			var w: Number;
			
			var pz: Number;
			
			var xi: int;
			var yi: int;

			var p00: Number = _matrix.rawData[ 0x0 ];
			var p01: Number = _matrix.rawData[ 0x1 ];
			var p02: Number = _matrix.rawData[ 0x2 ];
			var p10: Number = _matrix.rawData[ 0x4 ];
			var p11: Number = _matrix.rawData[ 0x5 ];
			var p12: Number = _matrix.rawData[ 0x6 ];
			var p20: Number = _matrix.rawData[ 0x8 ];
			var p21: Number = _matrix.rawData[ 0x9 ];
			var p22: Number = _matrix.rawData[ 0xa ];
			var p32: Number = _matrix.rawData[ 0xe ];
			
			var bufferWidth: int = 550;
			var bufferMax: int = _buffer.length;
			var bufferMin: int = -1;
			var bufferIndex: int;
			var buffer: Vector.<uint> = _buffer;
			
			var color: uint;
			var colorInc: uint = 0x202020;
			var colorMax: uint = 0xffffff;
			
			var cx: Number = 275.0;
			var cy: Number = 200.0;
			var minZ: Number = 0.0;

			var n: int = bufferMax;
			while( --n > -1 ) buffer[ n ] = 0x000000;

			do
			{
				x = particle.x, y = particle.y, z = particle.z;
				pz = _focalLength + x * p02 + y * p12 + z * p22 + p32;
				
				if( minZ < pz )
				{
					xi = int( ( w = _focalLength / pz ) * ( x * p00 + y * p10 + z * p20 ) + cx );
					yi = int( w * ( x * p01 + y * p11 + z * p21 ) + cy );
					
					if( bufferMin < ( bufferIndex = int( xi + int( yi * bufferWidth ) ) ) && bufferIndex < bufferMax )
						buffer[ bufferIndex ] = ( ( color = buffer[ bufferIndex ] + colorInc ) > colorMax ) ? colorMax : color;
				}
				
				particle = particle.next;
			} while( particle );

			_screen.lock();
			_screen.setVector( _screen.rect, buffer );
			_screen.unlock( _screen.rect );
		}
	}
}
