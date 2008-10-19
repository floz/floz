
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package plateau 
{	
	import flash.display.MovieClip;
	import main.Const;
	
	public class PlateauRandom extends Plateau 
	{
		public var cnt:MovieClip;
		
		private var aCells:Array = [];
		
		public function PlateauRandom() 
		{
			super();	
		}
		
		// EVENTS
		
		// PRIVATE
		
		protected override function initPlateauRandom():void
		{
			var c:Cell;
			
			var a:Array = [];
			var status:String = Const.FREE;
			var b1:Boolean;
			var b2:Boolean;
			var b3:Boolean;
			
			var i:int;
			var j:int;
			var n:int = 10;
			for ( i; i < n; i++ )
			{
				a = [];
				status = Const.FREE;
				for ( j; j < n; j++ )
				{
					if ( i == 0 )					
					{
						status = Const.STATUS[ int( Math.random() * Const.STATUS.length ) ];
						if ( j == 1 )
						{
							if ( a[ 0 ].status == Const.FREE ) status = Const.FREE;
						}
						else if ( j == n - 1 )
						{
							if ( a[ n - 2 ].status == Const.FREE ) status = Const.FREE;
						}
					}
					else 
					{
						if ( a[ 0 ] ) 
						{
							b1 = ( a[ j - 1 ].status == Const.FREE ) ? true : false; // Gauche
							b2 = ( aCells[ i - 1 ][ j ].status == Const.FREE ) ? true : false; // Haut
							b3 = ( aCells[ i - 1 ][ j - 1 ].status == Const.FREE ) ? true : false; // Haut gauche
							
							if ( b1 && b2 && b3 ) status =  Const.BLOCKED;
							else if ( b1 && !b2 && b3 ) status = Const.STATUS[ int( Math.random() * Const.STATUS.length ) ];
							else if ( !b1 && b2 && !b3 ) status = Const.STATUS[ int( Math.random() * Const.STATUS.length ) ];
							else if ( !b1 && !b2 && b3 ) status = Const.STATUS[ int( Math.random() * Const.STATUS.length ) ];
							else if ( b1 && !b2 && !b3 ) status = Const.FREE;//status = Const.STATUS[ int( Math.random() * Const.STATUS.length ) ];
							else if ( b1 && b2 && !b3 ) status = Const.FREE;
							else if ( !b1 && b2 && b3 ) status = Const.FREE;
							else if ( !b1 && !b2 && !b3 ) status = Const.FREE;
							else
							{
								trace ( "couille" );
								trace( "b1 : " + b1 );
								trace( "b2 : " + b2 );
								trace( "b3 : " + b3 );
							}
						}
						else 
						{
							status = Const.STATUS[ int( Math.random() * Const.STATUS.length ) ];
						}
						
					}
					
					c = new Cell( 50, status );
					c.x = c.width * j;
					c.y = c.width * i;
					cnt.addChild( c );
					
					a.push( c );
				}
				aCells.push( a );
				j = 0;
			}
		}
		
		// PUBLIC
		
	}
	
}