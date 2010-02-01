
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric.objects 
{
	import flash.display.Sprite;
	import fr.floz.isometric.core.IsoDisplayObject;
	
	public class MobileLayer extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _width:Number;
		private var _height:Number;
		private var _objects:Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MobileLayer( width:Number, heigth:Number ) 
		{
			this._width = width;
			this._height = height;
			
			_objects = [];
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addObject( object:IsoDisplayObject ):Boolean
		{
			var i:int = _objects.length;
			_objects[ i ] = object;
			addChild( object );
			
			return _objects.length != i ? true : false;
		}
		
		public function render():void
		{
			var ido:IsoDisplayObject;
			
			_objects.sortOn( "depth", Array.NUMERIC );
			
			var n:int = _objects.length;
			for ( var i:int; i < n; ++i )
				setChildIndex( _objects[ i ], i );			
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}