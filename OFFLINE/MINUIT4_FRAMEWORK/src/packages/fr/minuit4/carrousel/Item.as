/**
 * @author 			Arno NICOLAS
 * @version 		0.1
 * Date				Février 2009
 * Description		Item du carrousel implémentant la gestion de l'angle (pour le positionnement sur le carrousel) ainsi qu'un reflet (optionnel)
 */
package fr.minuit4.carrousel 
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class Item extends Sprite
	{
		
		private var _reflect:DisplayObject;
		private var _angle:int;
		
		/**
		 * Constructor
		 * @param	pChild:DisplayObject	Paramètre optionnel - displayObject qu'on souhaite afficher dans l'item
		 */
		public function Item(pChild:DisplayObject = null, pHasReflect:Boolean = true ) 
		{
			if (pChild)
			{
				pChild.x = - pChild.width * .5;
				pChild.y = - pChild.height * .5;
				this.addChild(pChild);
				if(pHasReflect)
					setReflect(pChild);
			}
			else
				Init();
		}
		
		
		/**
		 * Private méthode de dessin de l'item - méthode appelé si aucun DisplayObject n'est indiqué
		 */
		private function Init():void
		{
			var g:Graphics = this.graphics;
			g.beginFill(Math.round(Math.random() * (0xFFFFFF)), 1);
			g.drawRect( -50, -50, 100, 100);
			g.endFill();
		}
		
		
		/**
		 * Private méthode d'ajout d'un reflet sur l'item
		 * @param	pChild
		 */
		private function setReflect(pChild:DisplayObject):void
		{
			var bufferHeight:int = this.height;
			var bd:BitmapData = new BitmapData(this.width, this.height, true, 0x000000);
			bd.draw(pChild);
			_reflect = new Bitmap(bd, PixelSnapping.AUTO, true);
			_reflect.x = - this.width * .5;
			_reflect.scaleY = -1;
			_reflect.y = bufferHeight * 1.5;
			this.addChild(_reflect);
			_reflect.cacheAsBitmap = true;
			
			var masque:Shape = new Shape();
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(200, 100, 0, -100, -50);
			masque.graphics.beginGradientFill(GradientType.RADIAL, [0x000000, 0x000000], [1, 0], [0, 255], matrix);
			masque.graphics.drawRect( - this.width * .5, 0, this.width, 100);
			masque.graphics.endFill();
			masque.y = bufferHeight * .5;
			this.addChild(masque);
			masque.cacheAsBitmap = true;
			_reflect.mask = masque;
		}
		
		/**
		 * GETTER --- SETTER
		 */
		public function get angle():int { return _angle; }
		
		public function set angle(value:int):void 
		{
			_angle = value;
		}
		
	}
}