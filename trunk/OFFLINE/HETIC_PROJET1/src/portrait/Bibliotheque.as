
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package portrait 
{
	import caurina.transitions.Tweener;
	import com.carlcalderon.arthropod.Debug;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Bibliotheque extends MovieClip
	{
		public var zUp:SimpleButton;
		public var zDown:SimpleButton;
		public var cnt:MovieClip;
		
		private var document:Portrait;
		
		private var aUrls:Array;
		private var small:Boolean;
		private var library:BitmapDataLibrary;
		
		private var idxMax:int;
		private var displayed:Boolean;
		private var nbrLignes:int;
		private var launched:Boolean;
		
		private var scrollVal:int;
		
		public function Bibliotheque() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}		
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			document = getAncestor( this, Portrait ) as Portrait;
			
			zUp.addEventListener( MouseEvent.CLICK, onClick );
			zDown.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			var vMax:int = small ? int( idxMax - 4 ) : int( idxMax - 2 );
			
			switch ( e.currentTarget )
			{
				case zUp:
				{
					if ( scrollVal - 1 >= 0 ) scrollVal--;
					else return;					
					
					break;
				}
				case zDown:
				{
					if ( scrollVal + 1 <= vMax ) scrollVal++;
					else return;
					
					break;
				}
			}
			
			affiche( scrollVal );
		}
		
		private function onBitmapDataLoaded(e:Event):void 
		{
			var v:Vignette = new Vignette( small, library.getLastBitmapData() );
			cnt.addChild( v );
			
			if ( small ) v.y = cnt.numChildren > 4 ? 380 : -200;
			else v.y = cnt.numChildren > 2 ? 380 : -200;
			
			idxMax++;
			
			if ( !displayed ) 
			{
				if ( library.toLoadCount >= ( small ? 4 : 2 ) )
				{
					if ( cnt.numChildren >= ( small ? 4 : 2 ) ) 
					{
						scrollVal = 0;
						affiche( scrollVal );
						displayed = true;
					}
				}
				else
				{
					if ( cnt.numChildren == library.toLoadCount ) 
					{
						scrollVal = 0;
						affiche( scrollVal );
						displayed = true;
					}
				}
			}
			
			setButtonsStatus();
			if ( library.hasNext() ) library.loadNext();
		}
		
		// PRIVATE
		
		private function setButtonsStatus():void
		{
			var vMax:int = small ? int( idxMax - 4 ) : int( idxMax - 2 );
			if ( vMax < 0 ) vMax = 0;
			
			if ( scrollVal == 0 )
			{
				zUp.alpha = .5;
				zUp.enabled = false;
			}
			else
			{
				zUp.alpha = 1;
				zUp.enabled = true;
			}
			
			if ( scrollVal == vMax )
			{
				zDown.alpha = .5;
				zDown.enabled = false;
			}			
			else
			{
				zDown.alpha = 1;
				zDown.enabled = true;
			}
		}
		
		private function removeAllTweens():void
		{
			var i:int;
			var n:int = cnt.numChildren;
			for ( i; i < n; i++ ) Tweener.removeTweens( cnt.getChildAt( i ) );
		}
		
		private function affiche( idx:int ):void
		{
			setButtonsStatus();
			
			var pos:Array = getPositions( idx );
			
			var v:Vignette;
			
			var i:int;
			var n:int = cnt.numChildren;
			for ( i; i < n; i++ )
			{
				v = cnt.getChildAt( i ) as Vignette;
				
				if ( pos[ i ][ 1 ] ) Tweener.addTween( v, { y: pos[ i ][ 0 ], time: .3, transition: "easeInOutQuad" } );
				else v.y = pos[ i ][ 0 ];
			}
		}
		
		private function getPositions( idx:int ):Array
		{
			var idxAct:int = small ? Math.min( idx,  idxMax - 4 ) : Math.min( idx,  idxMax - 2 );
			
			var i:int;
			var a:Array = [];
			if ( small )
			{
				if ( idxMax > 0 ) a.push( [ 0, true ] );
				if ( idxMax > 1 ) a.push( [ 80 + 16, true ] );
				if ( idxMax > 2 ) a.push( [ 160 + 32, true ] );
				if ( idxMax > 3 ) a.push( [ 240 + 48, true ] );
				if ( idxMax > 4 )
				{
					if (idxAct > 0 ) a.unshift( [ -200, true ] );
					for ( i; i < int( idxAct - 1 ); i++ ) a.unshift( [ -200, false ] );
				}
				
				if ( a.length < idxMax ) a.push( [ 380, true ] );
				while ( a.length < idxMax ) a.push( [ 380, false ] );
			}
			else
			{
				if ( idxMax > 0 ) a.push( [ 0, true ] );
				if ( idxMax > 1 ) a.push( [ 190, true ] );
				if ( idxMax > 2 )
				{
					if ( idxAct > 0 ) a.unshift( [ -200, true ] );
					for ( i; i < int( idxAct - 1 ); i++ ) a.unshift( [ -200, false ] );
				}
				
				if ( a.length < idxMax ) a.push( [ 380, true ] );
				while ( a.length < idxMax ) a.push( [ 380, false ] );
			}
			
			return a;
		}
		
		private function getAncestor( child:DisplayObject, type:* ):*
		{
			var d:DisplayObject = child;
			
			while ( d.parent )
			{
				if ( d.parent is type ) return d.parent;
				d = d.parent;
			}
			
			return null;
		}
		
		// PUBLIC
		
		public function load():void
		{
			aUrls = document.getInfos();			
			small = ( document.getCategorie() == ItemCategorie.CHEVEUX || document.getCategorie() == ItemCategorie.GABARIT ) ? false : true;
			
			removeAllTweens();
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			
			displayed =
			launched = false;
			
			idxMax = 0;
			
			if ( library )
			{
				library.dispose();
				library.clear();
				
				library.removeEventListener( BitmapDataLibrary.BITMAPDATA_LOADED, onBitmapDataLoaded );
				library = null;
			}
			
			library = new BitmapDataLibrary();
			library.addEventListener( BitmapDataLibrary.BITMAPDATA_LOADED, onBitmapDataLoaded );
			library.addItems( aUrls );
			
			library.loadNext();
		}
		
	}
	
}