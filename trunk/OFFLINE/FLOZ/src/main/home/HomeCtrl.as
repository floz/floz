
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.home 
{
	import flash.events.Event;
	import main.Config;
	
	public class HomeCtrl
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function HomeCtrl() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onLastProjectOver(e:Event):void 
		{
			var i:int = Config.cntMain.numChildren;
			while ( --i > -1 )
			{
				if ( Config.cntMain.getChildAt( i ) == e.currentTarget ) ( Config.cntMain.getChildAt( i ) as LastProject ).showBorders()
				else ( Config.cntMain.getChildAt( i ) as LastProject ).darken();
			}
		}
		
		private function onLastProjectOut(e:Event):void 
		{
			var i:int = Config.cntMain.numChildren;
			while ( --i > -1 )
			{
				if ( Config.cntMain.getChildAt( i ) == e.currentTarget ) ( Config.cntMain.getChildAt( i ) as LastProject ).hideBorders()
				else ( Config.cntMain.getChildAt( i ) as LastProject ).lighten();
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function sortProjects():Array
		{
			var a:Array = [];
			var aw:Array = copyArray( Config.worksDatas );
			var al:Array = copyArray( Config.labDatas );
			
			while ( a.length < 3 )
			{
				if ( aw[ 0 ].pubdate < al[ 0 ] )
					a.push( al.shift() );
				else
					a.push( aw.shift() );
			}
			
			return a;
		}
		
		private function copyArray( a:Array ):Array
		{
			var copy:Array = [];
			var n:int = a.length;
			for ( var i:int; i < n; ++i )
				copy[ i ] = a[ i ];
			
			return copy;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate():void
		{
			while ( Config.cntMain.numChildren ) Config.cntMain.removeChildAt( 0 );
			
			var lp:LastProject;
			var a:Array = sortProjects();
			var n:int = a.length;
			for ( var i:int; i < n; ++i )
			{
				lp = new LastProject();
				lp.linkToProject( a[ i ].title, a[ i ].preview, a[ i ].section );
				lp.x = 320 * i;
				lp.x += i ? 2 : 0;
				Config.cntMain.addChild( lp );
				
				lp.addEventListener( LastProject.OVER, onLastProjectOver );
				lp.addEventListener( LastProject.OUT, onLastProjectOut );
			}
		}
		
		public function deactivate():void
		{
			while ( Config.cntMain.numChildren ) Config.cntMain.removeChildAt( 0 );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}