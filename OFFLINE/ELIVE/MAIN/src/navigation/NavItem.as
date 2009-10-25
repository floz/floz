
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package navigation 
{
	import aze.motion.Eaze;
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
			
			_filter = new GlowFilter( 0xffffff, .5, 0, 0 );
			
			this.mouseChildren = false;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function setFilter():void
		{
			this.filters = [ _filter ];
			if ( _filter.blurX <= 6 ) this.filters = [];
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function over():void
		{
			_filter.blurX = 8;
			_filter.blurY = 8;
			Eaze.to( _filter, .25, { blurX: 20, blurY: 20 } ).onUpdate( setFilter );
		}
		
		public function out():void
		{
			Eaze.to( _filter, .25, { blurX: 6, blurY: 6 } ).onUpdate( setFilter );
		}
		
		public function select():void
		{
			_filter.blurX = 
			_filter.blurY = 20;
			setFilter();
		}
		
		public function deselect():void
		{
			out();
		}
		
		public function setSkin( skin:DisplayObject ):void
		{
			addChild( skin );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}