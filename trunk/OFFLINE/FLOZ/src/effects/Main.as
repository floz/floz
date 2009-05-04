
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package effects
{
	import fl.transitions.Photo;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import fr.minuit4.utils.UBit;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _canvas:BitmapData;
		private var _map:BitmapData;
		private var _photo:BitmapData;
		private var _photoHolder:Bitmap;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var panel:Panel;
		public var cnt:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			_canvas = new BitmapData( 300, 200, false, 0xffffff );
			_map = _canvas.clone();
			
			var b:Bitmap = new Bitmap( _canvas );
			addChild( b );
			
			b = new Bitmap( _map );
			b.x = b.width;
			addChild( b );
			
			_photo = new PhotoBmp( 0, 0 );
			_photoHolder = new Bitmap( _photo.clone(), PixelSnapping.AUTO, true );
			cnt.addChild( _photoHolder );
			
			generate();
			
			panel.addEventListener( Event.CHANGE, onChange );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onChange(e:Event):void 
		{
			generate();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function generate():void
		{
			_canvas.fillRect( _canvas.rect, 0xffffff );
			_map.perlinNoise( Config.baseX, Config.baseY, Config.numOctaves, Config.randomSeed, Config.stitch, Config.fractalNoise, 0, Config.grayScale );
			_canvas.fillRect( _canvas.rect, 0xffffff );
			_canvas.threshold( _map, _map.rect, new Point(), "<", Config.threshold, Config.color, Config.mask, false );
			
			/*var b:BitmapData = _photo.clone();//UBit.resize( _canvas.clone(), 400, 400, false );
			var map:BitmapData = new BitmapData( 400, 400, false, 0x0000ff );
			var m:Matrix = new Matrix();
			m.createBox( 1, 1, 90 * Math.PI / 180, 400 );
			map.draw( b, m );
			b.applyFilter( b, b.rect, new Point(), new DisplacementMapFilter( UBit.resize( _canvas, 400, 400, false ), new Point(), 10, 4, 20, 20, DisplacementMapFilterMode.WRAP, 0x000000, 1 )  );
			_photoHolder.bitmapData = b;*/
			
			var b:BitmapData = UBit.resize( _canvas.clone(), 400, 400, false );
			var map:BitmapData = new BitmapData( 400, 400, false, 0x000000 );
			var m:Matrix = new Matrix();
			m.createBox( 1, 1, 90 * Math.PI / 180, 400 );
			map.draw( b, m );
			map.applyFilter( map, map.rect, new Point(), new DisplacementMapFilter( b, new Point(), BitmapDataChannel.RED, BitmapDataChannel.RED, 20, 20 ) );
			
			var fin:BitmapData = _photo.clone();
			fin.applyFilter( fin, fin.rect, new Point(), new DisplacementMapFilter( map, new Point(), BitmapDataChannel.RED, BitmapDataChannel.RED, 20, 20 ) );
			_photoHolder.bitmapData = fin;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}