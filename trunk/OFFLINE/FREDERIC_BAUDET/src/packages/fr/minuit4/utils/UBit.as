
/**
* Written by :
* @author : Floz - Florian Zumbrunn
* Version log :
* 
* 03.01.09		1.1		Floz		+ Modification de resize : renvoie d'un BitmapData transparent (possibilité de désactiver la transparence);
* 28.08.08		1.0		Floz		+ Première version
*/
package fr.minuit4.utils 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * Classe de méthodes en rapport avec la manipulation de Bitmap/BitmapData et donc d'images.
	 */
	public class UBit 
	{
		
		// EVENTS
		
		// PRIVATE
		
		// PUBLIC
		
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
			
			var i:int;
			var j:int;
			var n:int = width / bmpdWidth + bmpdWidth;
			var m:int = height / bmpdHeight + bmpdHeight;
			for ( i; i < n; i++ )
			{
				for ( j; j < m; j++ )
					b.copyPixels( bmpd, bmpd.rect, new Point( i * bmpdWidth, j * bmpdHeight ) );
				
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
	}
	
}