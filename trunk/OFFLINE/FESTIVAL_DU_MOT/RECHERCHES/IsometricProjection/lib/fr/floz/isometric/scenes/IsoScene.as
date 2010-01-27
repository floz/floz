
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric.scenes 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import fr.floz.isometric.core.IsoDisplayObject;
	import fr.floz.isometric.objects.Layer;
	import fr.floz.isometric.objects.MobileLayer;
	
	public class IsoScene extends Sprite implements IIsoScene
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _background:Layer;
		private var _mobileLayer:MobileLayer;
		private var _foreground:Layer;
		
		private var _layout:BitmapData;
		
		private var _showGrid:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var grid:IsoGrid;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoScene( tileWidth:int, width:int, height:int ) 
		{
			grid = new IsoGrid( tileWidth, int( width / ( tileWidth << 1 ) ), int( height / tileWidth - 3 ) );
			addChild( grid );
			
			_background = new Layer( width, height );
			addChild( _background );
			
			_mobileLayer = new MobileLayer( width, height );
			addChild( _mobileLayer );
			
			_foreground = new Layer( width, height );
			addChild( _foreground );
			
			//_layout = new BitmapData( width, height, false, 0xff00ff );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addBackgroundItem( item:IsoDisplayObject ):Boolean
		{
			return _background.addObject( item );
		}
		
		public function addMobile( item:IsoDisplayObject ):Boolean
		{
			return _mobileLayer.addObject( item );
		}
		
		public function addForegroundItem( item:IsoDisplayObject ):Boolean
		{
			return _foreground.addObject( item );
		}
		
		public function render():void
		{
			if ( _background.needRender )
			{
				_background.render();
				_background.needRender = false;
			}
			if (_foreground.needRender )
			{
				_foreground.render();
				_foreground.needRender = false;
			}
			
			_mobileLayer.render();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get showGrid():Boolean { return _showGrid; }
		
		public function set showGrid(value:Boolean):void 
		{
			_showGrid = value;
			grid.visible = false;
		}
		
	}
	
}