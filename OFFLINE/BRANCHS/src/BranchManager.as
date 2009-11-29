
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
	import flash.display.Shape;
	import flash.events.Event;
	
	public class BranchManager extends Bitmap
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _branchsColor:uint;
		
		private var _aBranchs:Vector.<Branch>;
		private var _shape:Shape;
		private var _g:Graphics;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function BranchManager( width:Number, height:Number, transparent:Boolean, branchColor:uint, backgroundColor:uint ) 
		{
			this._branchsColor = branchColor;
			
			super( new BitmapData( width, height, transparent, backgroundColor ), PixelSnapping.NEVER, true );
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.ENTER_FRAME, enterFrameHandler, false, 0, true );
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			update();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_aBranchs = new Vector.<Branch>();
			_shape = new Shape();
			_g = _shape.graphics;
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update():void
		{
			var branch:Branch;
			var i:int = _aBranchs.length;
			while ( --i > -1 )
			{
				branch = _aBranchs[ i ];
				
				_g.clear();
				_g.lineStyle( 1, _branchsColor );
				_g.moveTo( branch.x, branch.y ); {
					branch.update();
				} _g.lineTo( branch.x, branch.y );
				
				bitmapData.draw( _shape );
				
				if ( branch.x < 0 || branch.x > stage.stageWidth || branch.y < 0 || branch.y > stage.stageHeight )
					_aBranchs.splice( i, 1 );
			}
		}
		
		public function addBranch( x:Number, y:Number ):void
		{
			_aBranchs.push( new Branch( x, y ) );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}