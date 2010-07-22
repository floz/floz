package com.gobzlite.utils 
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	/**
	 * Provide function for manage color
	 * 
	 * -------------------------
	 * + usage
	 * -------------------------
	 * 
	 * Color.COLOR // current colors constante
	 * Color.drawRect( graphics, width,  height );
	 * Color.drawRect( graphics, width,  height, color = 0, alpha = 1 );
	 * Color.drawBackground( ( sprite||shape ), color, alpha ); 
	 * Color.gradient( graphics, width, height, colors:Array
	 * Color.gradient( graphics, width, height, colors:Array, [ rotation:int(degree)=90, alphas:Array=null, x=0, y=0 ] );
	 * 
	 * @version 0.2 : change in gradient -> rotation : radian to degree
	 * @version 0.1 : first implementation
	 * 
	 * @author David Ronai
	 */
	public class Color 
	{
		
		public static const BLACK:int = 0x000000;
		public static const WHITE:int = 0xFFFFFF;
		public static const RED:int = 0xFF0000;
		public static const BLUE:int = 0x0000FF;
		public static const GREEN:int = 0x00FF00;
		public static const YELLOW:int = 0xFFFF00;
		
		/**
		 * Private Constructor
		 */
		public function Color() 
		{
			throw new Error("You can't create an instance of Color");
		}
		
		/**
		 * Make a gradient of colors
		 * @param	graphics graphics to draw
		 * @param	width width gradient
		 * @param	height height gradient
		 * @param	colors colors array
		 * @param	rotation gradient rotation, 90 to vertical , 0 to horizontal
		 * @param	alpha alpha gradient , all colors have alpha = 1 by default.
		 */
		public static function gradient(graphics:Graphics,width:int, height:int, colors:Array, rotation:Number = 90, alphas:Array = null,x:int=0,y:int=0, ratios:Array = null):void
		{
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width, height,rotation*Math.PI/180,x,y); 
			
			var i:int;
			
			if( alphas == null ){
				var alphas:Array = [];
				for ( i = 0; i < colors.length; i++ ) {
					alphas[i] = 1;
				}
			}
			if ( ratios == null) {
				ratios = [];
				ratios[0] = 0;
				for ( i = 1; i < colors.length-1; i++ ) {
					ratios[i] = Math.floor(255 / colors.length) * i;
				}
				ratios[colors.length - 1] = 255;
			}
			
			graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
			graphics.drawRect(x, y, width, height);
			graphics.endFill();
		}
		
		/**
		 * Draw rectangle on graphics
		 * @param	graphics
		 * @param	color
		 * @param	alpha
		 */
		public static function drawRect(graphics:Graphics, width:uint, height:uint, color:uint = 0, alpha:Number = 1,x:int=0,y:int=0):void 
		{
			graphics.beginFill(color, alpha);
			graphics.drawRect(x, y, width, height);
			graphics.endFill();
		}
		
		/**
		 * Draw background on sprite or shape
		 * @param	d Sprite or Shape object else throw exception
		 * @param	color background color
		 * @param	alpha alpha background, 0 to transparent, 1 to opaque background
		 */
		public static function drawBackground( d:DisplayObject, color:uint = 0 , alpha:Number = 1):void
		{
			if ( d is Sprite ) {
				drawRect((d as Sprite).graphics, d.width, d.height, color, alpha);
			} else if ( d is Shape ) {
				drawRect((d as Shape).graphics, d.width, d.height, color, alpha);
			} else {
				throw new Error("You can only drawBackground on Sprite or Shape");
				return;
			}
		}
		
		public static function drawBorderRect( g:Graphics, width:int, height:int, color:uint = 0, size:int = 1, alpha:Number=1):void
		{
			g.lineStyle(size, color, alpha);
			g.moveTo(0, 0);
			g.lineTo(width, 0);
			g.moveTo(width, 0);
			g.lineTo(width, height);
			g.moveTo(width, height);
			g.lineTo(0, height);
			g.moveTo(0, height);
			g.lineTo(0, 0);
			g.moveTo(0, 0);
			g.endFill();
		}
		
	}
	
}