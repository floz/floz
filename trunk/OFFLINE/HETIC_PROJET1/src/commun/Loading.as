
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package commun 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class Loading extends Bitmap
	{
		private const POINT:Point = new Point();
		
		private var color:uint;
		private var distance:Number;
		private var size:Number;
		private var speed:Number;
		private var cmf:ColorMatrixFilter;
		
		private var particule:Shape;
		private var loading:BitmapData;
		private var degres:Number;
		private var radians:Number;
		
		private var i:int;
		
		private var _playing:Boolean;
		
		public function Loading( color:uint = 0xffffff, distance:Number = 8, size:Number = 4, speed:Number = 10, blur:Boolean = true, eraseTime:Number = .9 ) 
		{
			this.color = color;
			this.distance = distance;
			this.size = size;
			this.speed = speed;
			this.cmf = new ColorMatrixFilter( [ 1, 0, 0, 0, 0,
										   0, 1, 0, 0, 0,
										   0, 0, 1, 0, 0,
										   0, 0, 0, eraseTime, 0 ] );
			
			
			this.smoothing = true;
			if ( blur ) this.filters = [ new BlurFilter( 2, 2, 4 ) ];
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			if ( hasEventListener( Event.ENTER_FRAME ) ) removeEventListener( Event.ENTER_FRAME, onFrame );
			
			cmf = null;
			loading.dispose();
			loading = null;
		}		
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			particule = new Shape();
			var g:Graphics = particule.graphics;
			g.beginFill( this.color );
			g.drawCircle( distance, distance, size );
			g.endFill();
			
			distance = distance + particule.width + 1;
			loading = new BitmapData( distance * size, distance * size, true, 0x00ff00ff ); // distance * 2
			this.bitmapData = loading;
			
			degres =
			radians = 0;
		}
		
		private function onFrame(e:Event):void 
		{
			radians = ( Math.PI * degres ) / 180;
			
			for ( i = 0; i < speed; i++ )
			{
				loading.draw( particule, new Matrix( Math.cos( radians ), Math.sin( radians ), -Math.sin( radians ), Math.cos( radians ), distance, distance ) );
				degres++;
			}
			
			loading.applyFilter( loading, loading.rect, POINT, cmf );			
		}
		
		// PRIVATE
		
		// PUBLIC
		
		/**
		 * Lance le visuel de chargement.
		 */
		public function play():void
		{
			degres = 0;
			addEventListener( Event.ENTER_FRAME, onFrame );
			
			_playing = true;
		}
		
		/**
		 * Arrête le visuel de chargement.
		 */
		public function stop():void
		{
			removeEventListener( Event.ENTER_FRAME, onFrame );
			loading.fillRect( loading.rect, 0x00ffffff );
			
			_playing = false;
		}
		
		public function get playing():Boolean { return _playing; }
		
		override public function get width():Number { return ( super.width ? super.width : ( distance * size ) ) };
		override public function get height():Number { return ( super.height ? super.height : ( distance * size ) ) };		
	}
	
}