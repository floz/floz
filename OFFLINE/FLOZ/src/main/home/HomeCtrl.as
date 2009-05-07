
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
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onLastProjectOver(e:Event):void 
		{
			var i:int = Config.cntMain.numChildren;
			var lpc:LastProjectContainer;
			while ( --i > -1 )
			{
				lpc = Config.cntMain.getChildAt( i ) as LastProjectContainer;
				if ( lpc == e.currentTarget ) lpc.lastProject.hideBorders()
				else lpc.lastProject.darken();
			}
		}
		
		private function onLastProjectOut(e:Event):void 
		{
			var i:int = Config.cntMain.numChildren;
			var lpc:LastProjectContainer;
			while ( --i > -1 )
			{
				lpc = Config.cntMain.getChildAt( i ) as LastProjectContainer;
				if ( lpc == e.currentTarget ) lpc.lastProject.showBorders()
				else lpc.lastProject.lighten();
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
			
			aw =
			al = null;
			
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
			
			var lpc:LastProjectContainer;
			var a:Array = sortProjects();
			var n:int = a.length;
			var px:Number = -10;
			for ( var i:int; i < n; ++i )
			{
				lpc = new LastProjectContainer();
				lpc.lastProject.linkToProject( a[ i ].title, a[ i ].preview, a[ i ].section );
				lpc.x = px;
				px += 322;
				Config.cntMain.addChild( lpc );
				
				lpc.addEventListener( LastProject.OVER, onLastProjectOver, true );
				lpc.addEventListener( LastProject.OUT, onLastProjectOut, true );
			}
		}
		
		public function deactivate():void
		{
			var i:int = Config.cntMain.numChildren;
			while ( --i > -1 )
				LastProjectContainer( Config.cntMain.getChildAt( i ) ).kill( i );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}