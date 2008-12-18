
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package table 
{
	import caurina.transitions.Tweener;
	import com.carlcalderon.arthropod.Debug;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class GuestsChoiceMenu extends MovieClip
	{
		public static const SELECTION:String = "selection";
		
		public var zLeft:SimpleButton;
		public var zRight:SimpleButton;
		public var zValid:SimpleButton;
		public var cnt:MovieClip;
		
		private var document:Table;
		private var desactivateList:Array;
		
		private var currentGuestInfo:GuestInfos;
		
		private var scrollVal:int;
		private var vMax:int;
		
		private var aUrls:Array;
		private var aInfos:Array;
		private var library:ItemsLibrary;
		private var list:Array;
		private var idxMax:int;
		
		public function GuestsChoiceMenu() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			zLeft.removeEventListener( MouseEvent.CLICK, onClick );
			zRight.removeEventListener( MouseEvent.CLICK, onClick );
			zValid.removeEventListener( MouseEvent.CLICK, onClick );
			
			library.dispose();
			library.clear();
			library.removeEventListener( ItemsLibrary.ITEM_LOADED, onItemLoaded );
			library = null;
			
			Tweener.removeTweens( this );
			
			var n:int = list.length;
			for ( var i:int; i < n; i++ ) Tweener.removeTweens( GuestInfos( list[ i ] ) );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			document = getAncestor( this, Table ) as Table;
			
			desactivateList = [];
			
			zLeft.addEventListener( MouseEvent.CLICK, onClick );
			zRight.addEventListener( MouseEvent.CLICK, onClick );
			zValid.addEventListener( MouseEvent.CLICK, onClick );
			
			visible = 
			zValid.enabled = false;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case zLeft:
				{
					if ( scrollVal - 1 >= 0 ) scrollVal--;
					else scrollVal = idxMax - 1; // else return;
					
					break;
				}
				case zRight: 
				{
					if ( scrollVal + 1 < idxMax ) scrollVal++;
					else scrollVal = 0; // else return;
					
					break;
				}
				case zValid:
				{
					if ( !checkDispo() ) return;
					
					currentGuestInfo = list[ scrollVal ];
					dispatchEvent( new Event( GuestsChoiceMenu.SELECTION ) );
					
					break;
				}
			}
			
			affiche( scrollVal );
		}
		
		private function onItemLoaded(e:Event):void 
		{
			var gi:GuestInfos = list[ library.loadedCount - 1 ] as GuestInfos;
			
			gi.display( library.getLastItem() );
			
			if ( library.hasNext() ) library.loadNext();
		}
		
		// PRIVATE
		
		private function affiche( idx:int ):void
		{			
			setButtonStatus();
			
			var pos:Array = getPositions( idx );
			
			var gi:GuestInfos;
			
			var i:int;
			var n:int = list.length;
			for ( i; i < n; i++ )
			{
				gi = list[ i ];
				
				if ( pos[ i ][ 1 ] ) 
				{
					if ( !gi.parent ) cnt.addChild( gi );
					Tweener.addTween( gi, { x:pos[ i ][ 0 ], time: .5, transition: "easeInOutQuad" } );
				}
				else
				{
					if ( gi.parent && gi.loaded && !Tweener.isTweening( gi ) ) cnt.removeChild( gi );
					gi.x = pos[ i ][ 0 ];
				}
			}
		}
		
		private function getPositions( idx:int ):Array
		{
			var idxAct:int = Math.min( idx, idxMax );
			
			var i:int;
			var a:Array = [];
			if ( idxMax > 0 ) a.push( [ 0, true ] );
			if ( idxMax > 1 )
			{
				if ( idxAct > 0 ) a.unshift( [ -700, true ] );
				for ( i; i < int( idxAct - 1 ); i++ ) a.unshift( [ -700, false ] );
			}
			if ( a.length < idxMax ) a.push( [ 700, true ] );
			while ( a.length < idxMax ) a.push( [ 700, false ] );
			
			return a;
		}
		
		private function setButtonStatus():void
		{
			if ( scrollVal == 0 )
			{
				//zLeft.alpha = .5;
				//zLeft.enabled = false;
			}
			else
			{
				//zLeft.alpha = 1;
				//zLeft.enabled = true;
			}
			
			if ( scrollVal == idxMax - 1 )
			{
				//zRight.alpha = .5;
				//zRight.enabled = false;
			}			
			else
			{
				//zRight.alpha = 1;
				//zRight.enabled = true;
			}
			
			if ( checkDispo() )
			{
				zValid.alpha = 1;
				zValid.enabled =
				zValid.useHandCursor = true;
			}
			else
			{
				zValid.alpha = .5
				zValid.enabled =
				zValid.useHandCursor = false;
			}
		}
		
		private function searchAndDrop( idx:int ):void
		{
			var index:int;
			
			var i:int;
			var n:int = desactivateList.length;
			for ( i; i < n; i++ ) 
				if ( desactivateList[ i ] == idx ) index = i;
			
			desactivateList.splice( index, 1 );
		}
		
		private function checkDispo():Boolean
		{
			return document.checkDispo( scrollVal );
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
			aUrls = document.getUrls();
			aInfos = document.getInfos();
			
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			
			if ( library )
			{
				library.dispose();
				library.clear();
				
				library.removeEventListener( ItemsLibrary.ITEM_LOADED, onItemLoaded );
			}
			
			library = new ItemsLibrary();
			library.addEventListener( ItemsLibrary.ITEM_LOADED, onItemLoaded );
			library.addItems( aUrls );
			
			var gi:GuestInfos;
			list = [];
			
			var i:int;
			var n:int = library.toLoadCount;
			for ( i; i < n; i++ )
			{
				gi = new GuestInfos();
				gi.setText( aInfos[ i ].desc );
				gi.setType( aInfos[ i ].type );
				cnt.addChild( gi );
				list.push( gi );
			}
			
			idxMax = n;
			scrollVal = 0;
			affiche( scrollVal );
			
			library.loadNext();
		}
		
		public function show():void
		{
			this.y = 0;
			this.alpha = .6;
			zValid.enabled = true;
			visible = true;
			Tweener.addTween( this, { y: 66, alpha: 1, time: .3, transition: "easeInOutQuad" } );
		}
		
		public function hide():void
		{
			zValid.enabled = false;
			Tweener.addTween( this, { y: 0, alpha: .6, time: .3, transition: "easeInOutQuad", onComplete: function():void { visible = false; } } );
		}
		
		public function desactivate( idx:int ):void
		{
			desactivateList.push( idx );
			
			var gi:GuestInfos = list[ idx ] as GuestInfos;
			gi.alpha = .5;
		}
		
		public function activate( idx:int ):void
		{
			searchAndDrop( idx );
			
			var gi:GuestInfos = list[ idx ] as GuestInfos;
			gi.alpha = 1;
		}
		
		// GETTERS & SETTERS
		
		public function getSelected():Object
		{
			return { mc: currentGuestInfo.getGuest(), type: currentGuestInfo.getType(), idx: scrollVal };
		}
		
	}
	
}