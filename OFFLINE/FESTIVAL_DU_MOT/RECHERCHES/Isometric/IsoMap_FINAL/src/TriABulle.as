package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Floz
	 */
	public class TriABulle extends Sprite
	{
		
		public function TriABulle() 
		{
			var v:Vector.<Node> = new Vector.<Node>();
			v[ 0 ] = new Node( 3.5 );
			v[ 1 ] = new Node( 2.5 );
			v[ 2 ] = new Node( 1.53 );
			v[ 3 ] = new Node( 7.5 );
			v[ 4 ] = new Node( 2.09 );
			v[ 5 ] = new Node( 237.5 );
			v[ 6 ] = new Node( 123 );
			v[ 7 ] = new Node( 11.32 );
			v[ 8 ] = new Node( 9 );
			v[ 9 ] = new Node( 3.5 );
			
			trace( v );
			
			trace( "-----" );
			sortNodes( v );
			
			trace( v );
		}
		
		private function sortNodes( list:Vector.<Node> ):Vector.<Node>
		{
			var tmp:Node;
			
			var i:int;
			var n:int = list.length - 1;
			
			var sorted:Boolean = false;
			while ( !sorted )
			{
				sorted = true;
				for ( i = 0; i < n; ++i )
				{
					if ( list[ i ].f > list[ i + 1 ].f )
					{
						tmp = list[ i + 1 ];
						list[ i + 1 ] = list[ i ];
						list[ i ] = tmp;
						
						sorted = false;
					}
				}
			}
			
			return list;
		}
		
	}

}

final internal class Node
{
	public var f:Number;
	
	public function Node( f:Number )
	{
		this.f = f;
	}
	
	public function toString():String 
	{
		return "Node[ f : " + f + " ]";
	}
	
}