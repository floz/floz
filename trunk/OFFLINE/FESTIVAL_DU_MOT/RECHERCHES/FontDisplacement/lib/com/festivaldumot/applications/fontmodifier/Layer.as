
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.festivaldumot.applications.fontmodifier 
{
	import com.festivaldumot.core.Config;
	import com.festivaldumot.display.typo.Letter;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.core.interfaces.IDisposable;
	
	public class Layer extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _container:Sprite;
		
		private var _dragObj:LayerObject;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Layer() 
		{
			_container = new Sprite();
			addChild( _container );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			_dragObj = LayerObject( e.currentTarget );
			_dragObj.startMove();
			
			stage.addEventListener( MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true );
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			_dragObj.stopMove();
			_dragObj = null;
			
			stage.removeEventListener( MouseEvent.MOUSE_UP, mouseUpHandler );
		}
		
		private function rollOverHandler(e:MouseEvent):void 
		{
			var layerObj:LayerObject = LayerObject( e.currentTarget );
			bringToFront( layerObj );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function bringToFront( layerObject:LayerObject ):void
		{
			_container.addChild( layerObject );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addWord( word:String ):void
		{
			var n:int = word.length;
			for ( var i:int; i < n; ++i )
			{
				var letter:Letter = new Letter( word.charAt( i ), Config.TYPOGRAPHY );
			
				var layerObject:LayerObject = new LayerObject( letter.getPath() );
				layerObject.x = 150;
				layerObject.y = 150;
				layerObject.scaleX = 5;
				layerObject.scaleY = 5;
				_container.addChild( layerObject );
				
				layerObject.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true );
			}			
		}
		
		public function clear():void
		{
			var disposable:IDisposable;
			while ( _container.numChildren )
			{
				disposable = IDisposable( _container.getChildAt( 0 ) );
				disposable.dispose();
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}