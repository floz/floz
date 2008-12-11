
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package portrait 
{
	import com.carlcalderon.arthropod.Debug;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Portrait extends MovieClip 
	{
		public var sketch:Sketch;
		public var menuCtrl:MenuCtrl;
		public var bibliotheque:Bibliotheque;
		public var confirmation:Confirmation;
		public var zErase:SimpleButton;
		public var zEraseAll:SimpleButton;
		public var zValid:SimpleButton;
		
		private var datas:Datas;
		
		private var sexe:String;
		private var categorie:String;
		
		public function Portrait() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			menuCtrl.removeEventListener( MenuCtrl.SEXE_SELECTED, onSexeSelected );
			menuCtrl.removeEventListener( MenuCtrl.SEXE_CONFIRMATION, onSexeConfirmation );
			menuCtrl.removeEventListener( MenuCtrl.CATEGORIE_SELECTED, onCategorieSelected );
			
			zValid.removeEventListener( MouseEvent.CLICK, onClick );
			zEraseAll.removeEventListener( MouseEvent.CLICK, onClick );
			confirmation.removeEventListener( Confirmation.YES, onRespond );
			confirmation.removeEventListener( Confirmation.NO, onRespond );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			datas = new Datas( "xml/portrait.xml" );
			datas.addEventListener( Event.COMPLETE, onDatasComplete );
			datas.load();
		}
		
		private function onDatasComplete(e:Event):void 
		{
			sexe = ItemSexe.HOMME;
			categorie = ItemCategorie.GABARIT;
			
			bibliotheque.load();
			bibliotheque.addEventListener( Vignette.VIGNETTE_SELECTED, onVignetteSelected, true );
			
			menuCtrl.init( sexe, categorie );			
			menuCtrl.addEventListener( MenuCtrl.SEXE_SELECTED, onSexeSelected );
			menuCtrl.addEventListener( MenuCtrl.SEXE_CONFIRMATION, onSexeConfirmation );
			menuCtrl.addEventListener( MenuCtrl.CATEGORIE_SELECTED, onCategorieSelected );
			
			zValid.addEventListener( MouseEvent.CLICK, onClick );
			zErase.addEventListener( MouseEvent.CLICK, onClick );
			zEraseAll.addEventListener( MouseEvent.CLICK, onClick );
			confirmation.addEventListener( Confirmation.YES, onRespond );
			confirmation.addEventListener( Confirmation.NO, onRespond );
			
			sketch.init();
		}
		
		private function onVignetteSelected(e:Event):void 
		{
			sketch.selectItem( Vignette( e.target ).getBitmapData() );
		}
		
		private function onSexeSelected(e:Event):void 
		{
			var sexeItem:SexeItem = menuCtrl.getSexeSelected();
			sexe = sexeItem.sexe;
			
			bibliotheque.load();
		}
		
		private function onSexeConfirmation(e:Event):void 
		{
			confirmation.show( Confirmation.CHANGEMENT_SEXE );
		}
		
		private function onCategorieSelected(e:Event):void 
		{
			var menuItem:MenuItem = menuCtrl.getCategorieSelected();
			categorie = menuItem.categorie;
			
			bibliotheque.load();
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case zValid : confirmation.show( Confirmation.VALIDATION ); break;
				case zErase : sketch.cleanItemSelected(); break;
				case zEraseAll : confirmation.show( Confirmation.SUPPRESSION ); break;
			}
		}
		
		private function onRespond(e:Event):void 
		{
			if ( e.type == Confirmation.YES )
			{
				switch( confirmation.state )
				{
					case Confirmation.VALIDATION : trace( "validation du portrait" ); break;
					case Confirmation.SUPPRESSION : sketch.clean(); break;
					case Confirmation.CHANGEMENT_SEXE : sketch.clean(); menuCtrl.validSexe(); break;
				}
			}
			
			confirmation.hide();
		}
		
		// PRIVATE	
		
		// PUBLIC
		
		// GETTERS & SETTERS
		
		public function getInfos():Array
		{
			return datas.getInfos( sexe, categorie );
		}
		
		public function getCategorie():String { return categorie; }
		
	}
	
}