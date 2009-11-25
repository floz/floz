
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package emagicien.teams 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Teams 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const RECTANGE_WIDTH:Number = 135;
		public static const RECTANGLE_HEIGHT:Number = 130;
		
		public static const TEAM1:Rectangle = new Rectangle( 816, 87, RECTANGE_WIDTH, RECTANGLE_HEIGHT );
		public static const TEAM2:Rectangle = new Rectangle( 200, 325, RECTANGE_WIDTH, RECTANGLE_HEIGHT );
		public static const TEAM3:Rectangle = new Rectangle( 435, 325, RECTANGE_WIDTH, RECTANGLE_HEIGHT );
		public static const TEAM4:Rectangle = new Rectangle( 682, 325, RECTANGE_WIDTH, RECTANGLE_HEIGHT );
		public static const TEAM5:Rectangle = new Rectangle( 936, 325, RECTANGE_WIDTH, RECTANGLE_HEIGHT );
		public static const TEAM6:Rectangle = new Rectangle( 200, 573, RECTANGE_WIDTH, RECTANGLE_HEIGHT );
		public static const TEAM7:Rectangle = new Rectangle( 435, 573, RECTANGE_WIDTH, RECTANGLE_HEIGHT );
		public static const TEAM8:Rectangle = new Rectangle( 682, 573, RECTANGE_WIDTH, RECTANGLE_HEIGHT );
		public static const TEAM9:Rectangle = new Rectangle( 936, 573, RECTANGE_WIDTH, RECTANGLE_HEIGHT );
		public static const TEAM10:Rectangle = new Rectangle( 200, 810, RECTANGE_WIDTH, RECTANGLE_HEIGHT );
		public static const TEAM11:Rectangle = new Rectangle( 435, 810, RECTANGE_WIDTH, RECTANGLE_HEIGHT );
		public static const TEAM12:Rectangle = new Rectangle( 682, 810, RECTANGE_WIDTH, RECTANGLE_HEIGHT );
		public static const TEAM13:Rectangle = new Rectangle( 936, 810, RECTANGE_WIDTH, RECTANGLE_HEIGHT );
		
		public static const AREA1:Rectangle = TEAM1;
		public static const AREA2:Rectangle = new Rectangle( 200, 325, 871, RECTANGLE_HEIGHT );
		public static const AREA3:Rectangle = new Rectangle( 200, 573, 871, RECTANGLE_HEIGHT );
		public static const AREA4:Rectangle = new Rectangle( 200, 810, 871, RECTANGLE_HEIGHT );
		
		public static const TEAMS_ZONE:Rectangle = new Rectangle( 200, 87, 871, 854 );
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private static function getTeamInArea( point:Point, area:Rectangle ):Rectangle
		{
			if ( area == AREA2 )
			{
				if ( TEAM2.containsPoint( point ) ) return TEAM2;
				if ( TEAM3.containsPoint( point ) ) return TEAM3;
				if ( TEAM4.containsPoint( point ) ) return TEAM4;
				if ( TEAM5.containsPoint( point ) ) return TEAM5;
				return null;
			}
			else if ( area == AREA3 )
			{
				if ( TEAM6.containsPoint( point ) ) return TEAM6;
				if ( TEAM7.containsPoint( point ) ) return TEAM7;
				if ( TEAM8.containsPoint( point ) ) return TEAM8;
				if ( TEAM9.containsPoint( point ) ) return TEAM9;
				return null;
			}
			else if ( area == AREA4 )
			{
				if ( TEAM10.containsPoint( point ) ) return TEAM10;
				if ( TEAM11.containsPoint( point ) ) return TEAM11;
				if ( TEAM12.containsPoint( point ) ) return TEAM12;
				if ( TEAM13.containsPoint( point ) ) return TEAM13;
				return null;
			}
			return null;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function isPointInsideZone( point:Point ):Boolean
		{
			if ( TEAMS_ZONE.containsPoint( point ) ) return true;
			return false;
		}
		
		public static function getPointArea( point:Point ):Rectangle
		{
			if ( isPointInsideZone( point ) )
			{
				if ( AREA1.containsPoint( point ) ) return AREA1;
				if ( AREA2.containsPoint( point ) ) return AREA2;
				if ( AREA3.containsPoint( point ) ) return AREA3;
				if ( AREA4.containsPoint( point ) ) return AREA4;
			}
			return null;
		}
		
		public static function getTeamRectangle( point:Point ):Rectangle
		{
			var rect:Rectangle = getPointArea( point );
			if ( rect != null )
			{
				if ( rect == AREA1 ) return TEAM1;
				else return getTeamInArea( point, rect );
			}
			return null;
		}
		
	}
	
}