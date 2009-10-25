
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package navigation 
{
	import assets.GMenuTooltip;
	import aze.motion.Eaze;
	import elive.utils.EliveUtils;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	public class NavItem extends MovieClip
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _filter:GlowFilter;
		private var _skin:MovieClip;
		
		private var _cntIcon:Sprite;
		private var _cntToolTip:Sprite;
		
		private var _toolTip:GMenuTooltip;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var id:String;
		public var title:String;
		public var url:String;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function NavItem( id:String, title:String, url:String ) 
		{
			this.id = id;
			this.title = title;
			this.url = url;
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_cntIcon = new Sprite();
			addChild( _cntIcon );
			
			_cntToolTip = new Sprite();
			_cntToolTip.x = -80;
			_cntToolTip.y = -55;
			addChild( _cntToolTip );
			
			_toolTip = new GMenuTooltip();
			EliveUtils.configureText( _toolTip.tf, "tooltip_menu", title );
			_cntToolTip.alpha = 0;
			_cntToolTip.addChild( _toolTip );
			
			_filter = new GlowFilter( 0xffffff, .5, 0, 0 );
			
			this.mouseChildren = false;
		}
		
		private function showToolTip():void
		{
			Eaze.to( _cntToolTip, .25, { alpha: 1, y: -45 } );
		}
		
		private function hideToolTip():void
		{
			Eaze.to( _cntToolTip, .15, { alpha: 0, y: -55 } );
		}
		
		private function setFilter():void
		{
			_cntIcon.filters = [ _filter ];
			if ( _filter.blurX <= 6 ) _cntIcon.filters = [];
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function over():void
		{
			_filter.blurX = 8;
			_filter.blurY = 8;
			Eaze.to( _filter, .25, { blurX: 20, blurY: 20 } ).onUpdate( setFilter );
			
			_skin.gotoAndStop( 2 );
			
			showToolTip();
		}
		
		public function out():void
		{
			deselect();
			hideToolTip();
		}
		
		public function select():void
		{
			_filter.blurX = 
			_filter.blurY = 20;
			setFilter();
			
			hideToolTip();
		}
		
		public function deselect():void
		{
			Eaze.to( _filter, .25, { blurX: 6, blurY: 6 } ).onUpdate( setFilter );
			_skin.gotoAndStop( 1 );
		}
		
		public function setSkin( skin:MovieClip ):void
		{
			_skin = MovieClip( _cntIcon.addChild( skin ) );
			_skin.gotoAndStop( 1 );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}