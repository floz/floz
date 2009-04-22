
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
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import fr.minuit4.tools.loaders.types.ImageLoader;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class ToolTip extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _imageLoader:ImageLoader;
		
		private var _puce:Puce;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var imageHolder:ImageHolder;
		public var text:TextField;
		public var title:TextField;
		public var zClose:SimpleButton;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ToolTip() 
		{
			this.visible = false;
			zClose.visible = false;
			
			zClose.addEventListener( MouseEvent.CLICK, onClick );
			
			_imageLoader = new ImageLoader();
			_imageLoader.addEventListener( Event.COMPLETE, onComplete );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onClick(e:MouseEvent):void 
		{
			this.visible = false;
			Model.mainTooltipVisible = false;
		}
		
		private function onComplete(e:Event):void 
		{
			if ( this.visible )
			{
				imageHolder.setImage( Bitmap( _imageLoader.getItemLoaded() ).bitmapData.clone() );
				_puce.getInfos().img = Bitmap( _imageLoader.getItemLoaded() ).bitmapData.clone();
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function invisible():void { this.visible = false; }
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function show( p:Puce, setOnPuce:Boolean = false ):void
		{
			_puce = p;
			
			if ( !setOnPuce )
			{
				this.x = stage.mouseX + 20;
				this.y = stage.mouseY + 20;
			}
			text.text = p.getInfos().infoText;
			title.text = p.getInfos().title;
			
			if ( _puce.getInfos().img ) 
			{
				imageHolder.setImage( _puce.getInfos().img );
			}
			else
			{
				imageHolder.performLoading();
				if ( !( p.getInfos().imgUrl == "" || p.getInfos().imgUrl == "http://" ) ) _imageLoader.load( Model.path_photos + p.getInfos().imgUrl );
				else imageHolder.setImage( new BitmapData( 200, 200, true, 0x00 ) );
			}
			
			this.visible = true;
			this.alpha = 0;
			TweenLite.to( this, .2, { alpha: 1, ease: Quad.easeOut } );
		}
		
		public function hide():void
		{
			TweenLite.to( this, .2, { alpha: 0, ease: Quad.easeOut, onComplete: invisible() } );
		}
		
		public function setCloseButtonVisible():void
		{
			zClose.visible = true;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}