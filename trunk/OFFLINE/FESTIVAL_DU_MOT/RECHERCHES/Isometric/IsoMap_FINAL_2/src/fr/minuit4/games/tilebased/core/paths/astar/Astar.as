
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.core.paths.astar
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import fr.minuit4.games.tilebased.core.paths.astar.heuristics.Diagonal;
	import fr.minuit4.games.tilebased.core.paths.astar.heuristics.IHeuristic;
	import fr.minuit4.geom.IntPoint;
	
	public class Astar 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _map:IAstarSearchable;
		private var _datas:Vector.<Vector.<Node>>;
		
		private var _startNode:Node;
		private var _endNode:Node;
		private var _openList:Array;
		private var _closedList:Array;
		private var _width:uint;
		private var _height:uint;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const STRAIGHT_COST:int = 10;
		public static const DIAG_COST:int = 14;
		
		public var heuristic:IHeuristic = new Diagonal();
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Astar( map:IAstarSearchable ) 
		{
			this._map = map;
			initMap();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initMap():void
		{
			_width = _map.width;
			_height = _map.height;
			
			_datas = new Vector.<Vector.<Node>>( _height, true );
			var v:Vector.<Node>;
			
			var node:Node;
			
			var x:int;			
			for ( var y:int; y < _height; ++y )
			{
				v = new Vector.<Node>( _width, true );
				for ( x = 0; x < _width; ++x )
				{
					node = new Node( x, y, _map.isWalkable( x, y ) );
					v[ x ] = node;
				}
				_datas[ y ] = v;
			}			
		}
		
		private function search():Vector.<IntPoint>
		{
			var testNode:Node;
			var node:Node = _startNode;
			
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
				endX = node.x + 1 >= _width ? _width - 1 : node.x + 1;
				endY = node.y + 1 >= _height ? _height - 1 : node.y + 1;
				
				for ( y = startY; y <= endY; ++y )
				{
					for ( x = startX; x <= endX; ++x )
					{
						testNode = _datas[ y ][ x ];
						
						// Autorise ou non le déplacement de diagonal lorsqu'une case proche est "unwakable"
						// _datas[ y ][ node.x ].walkable => plus rapide que _map.isWalkable, tests en moins et référence directe à une variable.
						if ( testNode == node || !testNode.walkable || !_datas[ y ][ node.x ].walkable || !_datas[ node.y ][ x ].walkable )
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
			
			var node:Node = _endNode;
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
			if ( !_map.isWalkable( start.x, start.y ) || !_map.isWalkable( end.x, end.y ) || ( start.x == end.x && start.y == end.y ) ) 
				return null;
			
			_openList = [];
			_closedList = [];
			
			_startNode = _datas[ start.y ][ start.x ];
			_endNode = _datas[ end.y ][ end.x ];
			
			_startNode.g = 0;
			_startNode.f = heuristic.getCost( start.x, start.y, end.x, end.y );
			
			_openList[ 0 ] = _startNode;
			
			return search();
		}
		
		public function update():void
		{
			initMap();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}

internal final class Node
{
	public var x:int;
	public var y:int;
	
	public var f:Number = 0;
	public var g:Number = 0;
	
	public var parent:Node;
	
	public var walkable:Boolean;
	
	public function Node( x:int, y:int, walkable:Boolean )
	{
		this.x = x;
		this.y = y;
		this.walkable = walkable;
	}
}