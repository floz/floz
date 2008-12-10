
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package portrait 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MenuCtrl extends MovieClip
	{
		public static const CATEGORIE_SELECTED:String = "item_selected";
		public static const SEXE_SELECTED:String = "sexe_selected";
		public static const SEXE_CONFIRMATION:String = "sexe_confirmation";
		
		public var sexeH:SexeItem;
		public var sexeF:SexeItem;
		public var item0:MenuItem;
		public var item1:MenuItem;
		public var item2:MenuItem;
		public var item3:MenuItem;
		public var item4:MenuItem;
		public var item5:MenuItem;
		
		private var aItems:Array;
		
		private var oldSexeSelected:SexeItem;
		private var oldCategorieSelected:MenuItem;
		private var _sexeSelected:SexeItem;
		private var _categorieSelected:MenuItem;
		private var sexeWaitForConfirmation:SexeItem;
		
		public function MenuCtrl() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			removeEventListener( MenuItem.CLICK, onMenuItemClick, true );
			removeEventListener( SexeItem.CLICK, onSexeItemClick, true );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			sexeH.init( ItemSexe.HOMME );
			sexeF.init( ItemSexe.FEMME );
			item0.init( ItemCategorie.ACCESSOIRES );
			item1.init( ItemCategorie.CHEVEUX );
			item2.init( ItemCategorie.NEZ );
			item3.init( ItemCategorie.YEUX );
			item4.init( ItemCategorie.BOUCHE );
			item5.init( ItemCategorie.GABARIT );
			
			aItems = [ item0, item1, item2, item3, item4, item5 ];
			
			addEventListener( MenuItem.CLICK, onMenuItemClick, true );
			addEventListener( SexeItem.CLICK, onSexeItemClick, true );
		}
		
		private function onMenuItemClick(e:MouseEvent):void 
		{
			if ( e.target is MenuItem )
			{
				if ( _categorieSelected == e.target ) return;
				
				oldCategorieSelected = _categorieSelected;
				_categorieSelected = e.target as MenuItem;
				
				selection();
				
				dispatchEvent( new Event( MenuCtrl.CATEGORIE_SELECTED ) );
			}
		}
		
		private function onSexeItemClick(e:MouseEvent):void 
		{
			if ( e.target is SexeItem )
			{
				if ( _sexeSelected == e.target ) return;
				
				sexeWaitForConfirmation = e.target as SexeItem;
				
				dispatchEvent( new Event( MenuCtrl.SEXE_CONFIRMATION ) );
			}
		}
		
		// PRIVATE
		
		private function selection():void
		{
			if ( oldSexeSelected ) oldSexeSelected.deselect();
			if ( oldCategorieSelected ) oldCategorieSelected.deselect();
			
			_sexeSelected.select();
			_categorieSelected.select();
		}
		
		private function searchSexe( sexe:String ):SexeItem
		{
			if ( sexe == sexeH.sexe ) return sexeH;
			else if ( sexe == sexeF.sexe ) return sexeF;
			else return null;
		}
		
		private function searchItem( categorie:String ):MenuItem
		{
			var i:int;
			var n:int = aItems.length;
			for ( i; i < n; i++ )
				if ( aItems[ i ].categorie == categorie ) return aItems[ i ];
			
			return null;
		}
		
		// PUBLIC
		
		public function init( sexe:String, categorie:String ):void
		{
			_sexeSelected = searchSexe( sexe );
			_categorieSelected = searchItem( categorie );
			
			selection();
		}
		
		public function validSexe():void
		{
			oldSexeSelected = _sexeSelected;
			_sexeSelected = sexeWaitForConfirmation;
			
			selection();
			
			dispatchEvent( new Event( MenuCtrl.SEXE_SELECTED ) );
		}
		
		// GETTERS & SETTERS
		
		public function getSexeSelected():SexeItem { return _sexeSelected; }
		
		public function getCategorieSelected():MenuItem { return _categorieSelected; }
		
	}
	
}