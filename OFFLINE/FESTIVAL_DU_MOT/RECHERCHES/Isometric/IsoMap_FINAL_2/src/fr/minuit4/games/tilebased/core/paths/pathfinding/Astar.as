
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.core.paths.pathfinding 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import fr.minuit4.games.tilebased.core.maps.Map;
	import fr.minuit4.games.tilebased.core.paths.pathfinding.heuristics.Diagonal;
	import fr.minuit4.games.tilebased.core.paths.pathfinding.heuristics.IHeuristic;
	import fr.minuit4.games.tilebased.core.tiles.TileDatas;
	import fr.minuit4.geom.IntPoint;
	
	public class Astar 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _startNode:TileDatas;
		private var _endNode:TileDatas;
		private var _openList:Array;
		private var _closedList:Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const STRAIGHT_COST:int = 10;
		public static const DIAG_COST:int = 14;
		
		public var map:Map;
		
		public var heuristic:IHeuristic = new Diagonal();
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Astar( map:Map ) 
		{
			this.map = map;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function search():Vector.<IntPoint>
		{
			var testNode:TileDatas;
			var node:TileDatas = _startNode;
			
			var startX:int;
			var startY:int;
			var endX:int;
			var endY:int;
			
			var g:Number;
			var f:Number;
			var cost:Number;
			
			var nodeFound:Boolean;
			
			var x:int, y:int;
			while ( !nodeFound )
			{
				startX = node.x - 1 < 0 ? 0 : node.x - 1;
				startY = node.y - 1 < 0 ? 0 : node.y - 1;
				endX = node.x + 1 >= map.width ? map.width - 1 : node.x + 1;
				endY = node.y + 1 >= map.height ? map.height - 1 : node.y + 1;
				
				for ( y = startY; y <= endY; ++y )
				{
					for ( x = startX; x <= endX; ++x )
					{
						testNode = map.datas[ y ][ x ];
						
						// Autorise ou non le déplacement de diagonal lorsqu'une case proche est "unwakable"
						if ( testNode == node || !testNode.walkable || !map.isWalkable( node.x, y ) || !map.isWalkable( x, node.y ) )
							continue;
						
						// Assigne le coup diagonal ou normal.
						cost = STRAIGHT_COST;
						if ( !( node.x == testNode.x || node.y == testNode.y ) ) // Si le test renvoie faux, alors on est en diagonal.
							cost = DIAG_COST;
						
						g = node.g + cost;
						f = g + heuristic.getCost( testNode.x, testNode.y, _endNode.x, _endNode.y );
						
						if ( _openList.indexOf( testNode ) != -1 || _closedList.indexOf( testNode ) != -1 )
						{
							if ( testNode.f > f )
							{
								testNode.f = f;
								testNode.g = g;								
								testNode.parent = node;
							}
						}
						else
						{
							testNode.g = g;
							testNode.f = f;
							testNode.parent = node;
							
							_openList[ _openList.length ] = testNode;
						}
					}
				}
				_closedList[ _closedList.length ] = node;
				
				if ( _openList.length == 0 ) 
					return null;
				
				// On trie pour récupérer celui avec le "f" le plus grand, en l'enlevant de la liste ouverte.
				_openList.sortOn( "f", Array.NUMERIC );
				node = _openList.shift();
				
				if ( node == _endNode ) 
					nodeFound = true;
			}
			
			return getPath();
		}
		
		private function getPath():Vector.<IntPoint>
		{
			var nodes:Vector.<IntPoint> = new Vector.<IntPoint>();
			
			var p:IntPoint = new IntPoint( _endNode.x, _endNode.y );
			nodes[ 0 ] = p;
			
			var startNodeReached:Boolean;
			
			var node:TileDatas = _endNode;
			while ( !startNodeReached )
			{
				node = node.parent;
				p = new IntPoint( node.x, node.y );
				nodes.unshift( p );
				
				if ( node == _startNode )
					startNodeReached = true;
			}
			
			return nodes;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Renvoie une série de points correspondant aux tiles de la map (et non aux coordonnées)
		 * à emprunter pour arriver à destination.
		 * Le chemin renvoyé est toujours le plus court.
		 * @param	start	Point	Le point de départ.
		 * @param	end	Point	Le point d'arriver.
		 * @return	Vector.<IntPoint>	Le vecteur contenant les points du parcours.
		 */
		public function findPath( start:Point, end:Point ):Vector.<IntPoint>
		{
			if ( !map.isWalkable( start.x, start.y ) || !map.isWalkable( end.x, end.y ) || ( start.x == end.x && start.y == end.y ) ) 
				return null;
			
			_openList = [];
			_closedList = [];
			
			_startNode = map.datas[ start.y ][ start.x ];
			_endNode = map.datas[ end.y ][ end.x ];
			
			_startNode.g = 0;
			_startNode.f = heuristic.getCost( start.x, start.y, end.x, end.y );
			
			_openList[ 0 ] = _startNode;
			
			return search();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}