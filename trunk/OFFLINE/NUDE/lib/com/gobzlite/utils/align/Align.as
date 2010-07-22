package com.gobzlite.utils.align
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	/**
	 * Fast align displayObject
	 * 
	 * @author David Ronai
	 * @usage Align.all( sprite, Align.RIGHT );
	 *		  Align.vertical( sprite );
	 *		  Align.toStage( sprite, stage, Align.CENTER );
	 * 		  Align.downTo( target, sprite );
	 */
	public class Align
	{
		public static const NONE:int              = 0x000000;
		
		public static const LEFT:int              = 0x000001;
		public static const RIGHT:int             = 0x000002;
		
		public static const TOP:int               = 0x000004;
		public static const BOTTOM:int            = 0x000010;
		
		public static const VERTICAL_CENTER:int   = 0x000020;
		public static const HORIZONTAL_CENTER:int = 0x000040;
		
		public static const CENTER:int            = VERTICAL_CENTER | HORIZONTAL_CENTER;
		public static const CENTER_LEFT:int       = VERTICAL_CENTER | LEFT;
		public static const CENTER_RIGHT:int      = VERTICAL_CENTER | RIGHT;
		
		public static const TOP_LEFT:int          = TOP | LEFT;
		public static const TOP_RIGHT:int         = TOP | RIGHT;
		public static const TOP_CENTER:int        = TOP | HORIZONTAL_CENTER;
		
		public static const BOTTOM_LEFT:int       = BOTTOM | LEFT;
		public static const BOTTOM_RIGHT:int      = BOTTOM | RIGHT;
		public static const BOTTOM_CENTER:int     = BOTTOM | HORIZONTAL_CENTER;
		
		private static var bounds:Rectangle;
		
		/**
		 * Constructor
		 */
		public function Align() 
		{
			throw new Error("You can't create an instance of Align");
		}
		
		/**
		 * Align an element in a container with specified position
		 * 
		 * @param	target element to align
		 * @param	container align target x y regarding container property.
		 * @param	position position where align. Sample: use Align.Center to center an element.
		*/
		internal static function to( target:DisplayObject, container:DisplayObject, position:int, offsetX:Number = 0, offsetY:Number = 0 ):void 
		{
			if ( container is Stage ) 
			{
				toStage( target, container as Stage, position, offsetX, offsetY );
				return;
			}
			
			// fix bottom / right bug
			//target.x = target.y = 0;
			
			//bounds = container.getBounds(container);
			
			if ( position & Align.LEFT )
				target.x = 0;
			else 
			if ( position & Align.RIGHT )
				target.x = container.width - target.width;
			else if ( position & Align.HORIZONTAL_CENTER )
				target.x = ( container.width - target.width ) * .5;
				
			if ( position & Align.TOP)
				target.y = 0;
			else 
			if ( position & Align.BOTTOM )
				target.y = container.height - target.height;
			else if ( position & Align.VERTICAL_CENTER )
				target.y = ( container.height - target.height ) * .5;
			
			target.x += offsetX //+ bounds.x;
			target.y += offsetY //+ bounds.y;
		}
		
		/**
		 * Align an element on stage with specified position
		 * 
		 * @param	target
		 * @param	stage
		 * @param	position
		 */
		internal static function toStage( target:DisplayObject, stage:Stage, position:int, offsetX:Number = 0, offsetY:Number = 0 ):void
		{
			// fix bottom / right bug
			//target.x = target.y = 0;
			if ( position & Align.LEFT )
				target.x = 0;
			else 
			if ( position & Align.RIGHT )
				target.x = stage.stageWidth - target.width;
			else if ( position & Align.HORIZONTAL_CENTER )
				target.x = ( stage.stageWidth - target.width ) * .5;
				
			if ( position & Align.TOP)
				target.y = 0;
			else
			if ( position & Align.BOTTOM )
				target.y = stage.stageHeight - target.height;
			else if ( position & Align.VERTICAL_CENTER )
				target.y = ( stage.stageHeight - target.height ) * .5;
			
			target.x += offsetX;
			target.y += offsetY;
		}
		
		/**
		 * Align all elements of a container in specified position
		 * 
		 * @param	container 
		 * @param	position 
		 */
		internal static function all( container:DisplayObjectContainer, position:int, offsetX:Number = 0, offsetY:Number = 0):void
		{
			if ( container is Stage ) {
				var stage:Stage = container as Stage;
				for ( var i:int = 0; i < container.numChildren; ++i) {
					toStage( container.getChildAt( i ), stage, position, offsetX, offsetY );
				}
			} else {
				for ( i = 0; i < container.numChildren; ++i) {
					to( container.getChildAt( i ), container, position, offsetX, offsetY );
				}
			}
		}
		
		/**
		 * Align all elements of container on vertical axe espace by padding
		 * 
		 * @param	container 
		 * @param	padding padding value, can be negativ
		 */
		internal static function vertical( container:DisplayObjectContainer, padding:int = 0 ):void
		{
			if ( container.numChildren == 0 )
				return;
				
			container.getChildAt( 0 ).y = 0;				
			var y:int = container.getChildAt( 0 ).height + padding;
			
			for ( var i:int = 1; i < container.numChildren; i++) {
				container.getChildAt( i ).y = y;
				y += container.getChildAt( i ).height + padding;
			} 
		}
		
		/**
		 * Align all elements of container on horizontal axe espace by padding
		 * 
		 * @param	container 
		 * @param	padding padding value, can be negativ
		 */
		internal static function horizontal( container:DisplayObjectContainer, padding:int = 0 ):void
		{
			if ( container.numChildren == 0 )
				return;
			
			container.getChildAt( 0 ).x = 0;
			var x:int = container.getChildAt( 0 ).width + padding;
			
			for ( var i:int = 1; i < container.numChildren; i++) {
				container.getChildAt( i ).x = x;
				x += container.getChildAt( i ).width + padding;
			} 
		}
		
		/**
		 * Align target to bottom other target
		 * 
		 * @param	target displayObject to align
		 * @param	to reference target
		 * @param	offsetY add offset to y position
		 * @param	offsetX add offset to x position
		 */
		internal static function underTo( target:DisplayObject, to:DisplayObject, offsetX:Number = 0, offsetY:Number = 0 ):void 
		{
			target.x = to.x +offsetX;
			target.y = to.y + to.height + offsetY;
		}
		
		/**
		 * Align target to top of other target
		 * 
		 * @param	target
		 * @param	to
		 * @param	offsetY
		 * @param	offsetX
		 */
		internal static function upperTo( target:DisplayObject, to:DisplayObject, offsetX:Number = 0, offsetY:Number = 0 ):void 
		{
			target.x = to.x +offsetX;
			target.y = to.y - target.height + offsetY;
		}
		
		/**
		 * Align to left of other target
		 * 
		 * @param	target
		 * @param	to
		 * @param	offsetX
		 * @param	offsetY
		 */
		internal static function rightTo( target:DisplayObject, to:DisplayObject, offsetX:Number = 0, offsetY:Number = 0 ):void 
		{
			target.x = to.x + offsetX + to.width;
			target.y = to.y + offsetY;
		}
		
		/**
		 * Align to right to other target
		 * 
		 * @param	target
		 * @param	to
		 * @param	offsetX
		 * @param	offsetY
		 */
		internal static function leftTo( target:DisplayObject, to:DisplayObject, offsetX:Number = 0, offsetY:Number = 0 ):void 
		{
			target.x = to.x + offsetX - target.width;
			target.y = to.y + offsetY;
		}
	}	
}