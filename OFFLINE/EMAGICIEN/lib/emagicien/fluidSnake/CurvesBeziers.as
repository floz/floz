
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package emagicien.fluidSnake 
{
	import flash.geom.Point;
	
	public class CurvesBeziers 
	{
		
		/**
		 * Renvoie le prochain point de bézier d'une courbe, afin d'avoir un nouveau départ curviligne et non droit.
		 * @param	lastAnchor	Point	Le dernier point de la courbe (là où elle s'est arrêtée).
		 * @param	lastBezier	Point	Le dernier point de bézier de la courbe (le point de bézier avant son arrêt, soit celui utilisé pour arrivé à lastAnchor).
		 * @param	distance	Number	Pour donner une distance par rapport à lastAnchor, le point de départ de la nouvelle courbe.
		 * @return	Point
		 */
		public static function getNextBezier( lastAnchor:Point,lastBezier:Point, distance:Number = 100 ):Point
		{
			var p:Point = new Point();
			p.x = lastAnchor.x + ( lastAnchor.x - lastBezier.x );
			p.y = lastAnchor.y + ( lastAnchor.y - lastBezier.y );
			
			var angle:Number = Math.atan2( p.y - lastAnchor.y, p.x - lastAnchor.x );
			p.x = lastAnchor.x + distance * Math.cos( angle );
			p.y = lastAnchor.y + distance * Math.sin( angle );
			
			return p;
		}
		
	}
	
}