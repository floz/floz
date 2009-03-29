
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import fr.minuit4.utils.UBit;
	import fr.minuit4.utils.UDis;
	
	public class Beatlizer extends MovieClip
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _photo:Bitmap;
		private var _mask:Bitmap;
		
		private var _px:Number;
		private var _py:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var cnt:MovieClip;
		public var cntMask:MovieClip;
		public var bg:MovieClip;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Beatlizer() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			buttonMode = true;
			useHandCursor = true;
			
			cnt.x = cntMask.x = 410 * .5;
			cnt.y = cntMask.y = 510 * .5;
			
			cntMask.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			addEventListener( MouseEvent.MOUSE_UP, onUp );
		}
		
		private function onDown(e:MouseEvent):void 
		{
			cntMask.addEventListener( MouseEvent.MOUSE_MOVE, onMove );
			_px = e.localX - cnt.x;
			_py = e.localY - cnt.y;
		}
		
		private function onMove(e:MouseEvent):void 
		{ 
			cnt.x = e.localX - _px;
			cnt.y = e.localY - _py;
			
			e.updateAfterEvent();
		}
		
		private function onUp(e:MouseEvent):void 
		{
			cntMask.removeEventListener( MouseEvent.MOUSE_MOVE, onMove );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function getCMF( value:Number ):ColorMatrixFilter
		{
			return new ColorMatrixFilter( [ value, value, value, 0, 0,
									value, value, value, 0, 0,
									value, value, value, 0, 0,
									0, 0, 0, 1, 0 ] );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setMask():void
		{
			_mask = new Bitmap( UBit.resize( Model.MASKS[ Model.maskIdx ].clone(), 400, 500 ) );
			_mask.x = -_mask.width * .5;
			_mask.y = -_mask.height * .5;
			
			while ( cntMask.numChildren ) cntMask.removeChildAt( 0 );
			cntMask.addChild( _mask );
		}
		
		public function setPhoto():void
		{
			cnt.scaleX = cnt.scaleY = 1;
			cnt.filters = [];
			cnt.rotation = 0;
			
			var bd:BitmapData = Model.userPhoto.clone();
			bd.applyFilter( bd, bd.rect, new Point(), getCMF( 1/3 ) );
			
			_photo = new Bitmap( UBit.resize( bd, 400, 500 ) );
			_photo.x = -_photo.width * .5;
			_photo.y = -_photo.height * .5;
			_photo.filters = [ getCMF( .33 ) ];
			
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			cnt.addChild( _photo );		
		}
		
		public function setPhotoSaturation():void
		{
			_photo.filters = [ getCMF( Model.saturationValue ) ];
		}
		
		public function setPhotoScale():void
		{
			cnt.scaleX = Model.scale * Model.mirrorRatio;
			cnt.scaleY = Model.scale;
		}
		
		public function setRotation():void
		{
			cnt.rotation = Model.rotation;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}