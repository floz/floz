
/**
* Written by :
* @author : Floz - Florian Zumbrunn
* Version log :
* 
* 05.03.09		1.1		Floz		+ Ajout de la méthode setGradientTransparent
* 03.01.09		1.0.1	Floz		+ Modification de resize : renvoie d'un BitmapData transparent (possibilité de désactiver la transparence);
* 28.08.08		1.0		Floz		+ Première version
*/
package fr.minuit4.utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * Classe de méthodes en rapport avec la manipulation de Bitmap/BitmapData et donc d'images.
	 */
	public class UBit 
	{		
		/**
		 * Resize l'image en conservant, ou non, l'aspect initial. 
		 * @param	bmpd	BitmapData	L'image à resizer.
		 * @param	width	Number		La largeur après resize.
		 * @param	height	Number		La hauteur après resize.
		 * @param	keepAspectRatio	Boolean	Si oui ou non l'aspect de l'image est conservé.
		 * @param	pixel	Boolean		Si oui ou non les pixels grossissent, et donc que l'image est déformée lorsque la largeur et la hauteur voulue sont plus grandes que la taille de l'image.
		 * @param	transparent	Boolean	Si oui, le BitmapData renvoyé sera transparent.
		 */
		public static function resize( bmpd:BitmapData, width:Number, height:Number, keepAspectRatio:Boolean = true , pixel:Boolean = false, transparent:Boolean = true ):BitmapData
		{
			var m:Matrix;
			
			if ( keepAspectRatio )
			{
				var s:Number = Math.min( width/bmpd.width, height/bmpd.height );
				if ( s > 1 && !pixel ) s = 1;
				
				m = new Matrix( s, 0, 0, s );
				m.translate( int( ( width - s * bmpd.width ) / 2 ), int( ( height - s * bmpd.height ) /2 ) );
			}
			else
			{
				m = new Matrix( width/bmpd.width, 0, 0, height/bmpd.height );
			}
			
			var bd:BitmapData = transparent ? new BitmapData( width, height, true, 0xff00ff ) : new BitmapData( width, height );
			bd.draw( bmpd, m );
			
			return bd;
		}
		
		/**
		 * Etend (ou réplique... ) l'image sur la zone indiquée.
		 * @param	bmpd	Image à étendre/répliquer.
		 * @param	width	Largeur de la zone.
		 * @param	height	Hauteur de la zone.
		 */
		public static function strech( bmpd:BitmapData, width:Number, height:Number ):BitmapData
		{
			var b:BitmapData = new BitmapData( width, height );
			
			var bmpdWidth:Number = bmpd.width;
			var bmpdHeight:Number = bmpd.height;
			
			var j:int;
			var n:int = width / bmpdWidth;
			var m:int = height / bmpdHeight;
			for ( var i:int; i < n; i++ )
			{
				for ( j; j < m; j++ )
				{
					b.copyPixels( bmpd, bmpd.rect, new Point( i * bmpdWidth, j * bmpdHeight ) );
				}
				j = 0;
			}
			
			return b;
		}
		
		/**
		 * Etend (ou réplique... ) l'image sur la zone indiquée, dans un conteneur.
		 * @param	bmpd	Image à étendre/répliquer.
		 * @param	cont	Conteneur dans lequel l'image est contenu.
		 * @param	width	Largeur de la zone.
		 * @param	height	Hauteur de la zone.
		 */
		public static function strechIn( bmpd:BitmapData, cont:DisplayObjectContainer, width:Number, height:Number ):void
		{
			var s:Shape = new Shape();
			s.graphics.clear();
			s.graphics.beginBitmapFill( bmpd, null, true );
			s.graphics.drawRect( 0, 0, width, height );
			
			cont.addChild( s );
		}
		
		/**
		 * Etend (ou réplique... ) l'image sur la zone indiquée, dans un conteneur.
		 * @param	bmpd	Image à étendre/répliquer.
		 * @param	width	Largeur de la zone.
		 * @param	height	Hauteur de la zone.
		 * @return	Shape
		 */
		public static function strechShape( bmpd:BitmapData, width:Number, height:Number ):Shape
		{
			var s:Shape = new Shape();
			s.graphics.clear();
			s.graphics.beginBitmapFill( bmpd, null, true );
			s.graphics.drawRect( 0, 0, width, height );
			
			return s;
		}
		
		/**
		 * Applique un dégradé vers le transparent sur une image (BitmapData), sans déformation d'image de quelconque sorte.
		 * @param	image	BitmapData	L'image sur laquelle on veut appliquer le dégradé.
		 * @param	rotation	Number	L'angle de rotation (en radians) à appliquer au dégradé.
		 * @return	BitmapData	Le BitmapData de l'image avec le dégradé appliqué.
		 */
		public static function setGradientTransparent( image:BitmapData, rotation:Number = 0 ):BitmapData
		{
			var m:Matrix = new Matrix();
			m.createGradientBox( image.width, image.height, rotation );
			
			var gradient:Shape = new Shape();
			var g:Graphics = gradient.graphics;
			g.beginGradientFill( GradientType.LINEAR, [ 0xffffff, 0xffffff ], [ 1, 0 ], [ 0, 255 ], m, SpreadMethod.PAD );
			g.drawRect( 0, 0, image.width, image.height );
			g.endFill();
			
			var gradientBmpd:BitmapData = new BitmapData( image.width, image.height, true, 0x00 );
			gradientBmpd.draw( gradient );
			gradient = null;
			
			var result:BitmapData = new BitmapData( image.width, image.height, true, 0x00 );
			result.copyPixels( image, result.rect, new Point(), gradientBmpd, new Point(), true );
			
			image.dispose();
			image = result;
			
			return image;
		}
	}
	
}