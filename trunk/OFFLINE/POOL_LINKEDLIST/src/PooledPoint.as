
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.geom.Point;
	
	public class PooledPoint extends Point
	{
		public static const GROWTH_RATE:int = 0x10;
		
		private static var _pool:PooledPoint;
		private static var _availableInPool:int;
		
		private var _nextInPool:PooledPoint;
		
		public static function create( x:Number, y:Number ):PooledPoint
		{
			var pooledPoint:PooledPoint;
			
			// S'il n'y a plus d'objets disponibles dans la liste.
			if ( !_availableInPool )
			{
				// Combien d'objet sont crées à chaque nouveau remplissage.
				var n:int = GROWTH_RATE;
				while ( --n > -1 )
				{
					pooledPoint = new PooledPoint();
					
					pooledPoint._nextInPool = _pool;
					_pool = pooledPoint;					
				}
				_availableInPool += GROWTH_RATE;
			}
			
			// On prend le prochain objet disponible, et on le stocke dans pooledPoint. C'est lui que nous allons renvoyer.
			pooledPoint = _pool;
			// Puis on redéfinie le prochain objet qui fera office de PooledPoint.
			_pool = pooledPoint._nextInPool;
			--_availableInPool;
			
			// Attribution des propriétés de l'objet.
			pooledPoint.x = x;
			pooledPoint.y = y;
			
			return pooledPoint;
		}
		
		public static function release( pooledPoint:PooledPoint ):void
		{
			// On attribue le prochain objet qui fera office de PooledPoint à l'objet que l'on veut supprimer.
			// Du coup on ne perd pas "le fil" de notre liste !
			pooledPoint._nextInPool = _pool;
			// Puis on dit que le prochain objet dispo est : l'objet que l'on veut supprimer.
			_pool = pooledPoint;
			
			++_availableInPool;
		}
		
		public function dispose():void
		{
			release( this );
		}
		
	}
	
}