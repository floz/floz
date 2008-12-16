
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package table 
{
	import accueil.Accueil;
	import caurina.transitions.Tweener;
	import com.carlcalderon.arthropod.Debug;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import fr.minuit4.utils.UBit;
	import main.Main;
	import portrait.ItemSexe;
	
	public class Table extends MovieClip 
	{
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		
		public var zLeft:SimpleButton;
		public var zRight:SimpleButton;
		public var front:MovieClip;
		public var zValid:SimpleButton;
		public var confirmation:Confirmation;
		public var cnt:MovieClip;
		public var gcMenu:GuestsChoiceMenu;
		public var guestsList:GuestsList;
		public var curtain:MovieClip;
		public var endMessage:MovieClip;
		
		private var aCompo:Array;
		
		private var document:Main;		
		private var datas:Datas;
		
		public function Table() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			datas.removeEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			document = getAncestor( this, Main ) as Main;
			
			datas = new Datas( "xml/invites.xml" );
			datas.addEventListener( Event.COMPLETE, onLoadComplete );
			datas.load();
		}
		
		private function onLoadComplete(e:Event):void 
		{
			endMessage.visible = false;
			
			zValid.alpha = .5;
			zValid.enabled = false;
			zValid.useHandCursor = false;
				
			zValid.addEventListener( MouseEvent.CLICK, onClick );
			confirmation.addEventListener( Confirmation.YES, onRespond );
			confirmation.addEventListener( Confirmation.NO, onRespond );
			
			zLeft.addEventListener( MouseEvent.CLICK, onClick );
			zRight.addEventListener( MouseEvent.CLICK, onClick );
			
			curtain.width = stage.width;
			curtain.height = stage.height;
			curtain.alpha = 0;
			curtain.visible = false;
			curtain.buttonMode = true;
			curtain.addEventListener( MouseEvent.CLICK, onCurtainClick );
			
			aCompo = [];
			for ( var i:int; i < 4; i++ ) aCompo.push( null );
			
			guestsList.init();
			guestsList.addEventListener( Event.ACTIVATE, onGuestClick );
			
			setButtonsStatus();
			
			gcMenu.load();
			gcMenu.addEventListener( GuestsChoiceMenu.SELECTION, onSelection );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch ( e.currentTarget )
			{
				case zValid: 
				{
					if ( checkValidation() ) confirmation.show( Confirmation.VALIDATION );					
					break;
				}
				case zLeft: moveTo( Table.LEFT ); break;
				case zRight: moveTo( Table.RIGHT ); break;
			}	
		}
		
		private function onCurtainClick(e:MouseEvent):void { hideGuestMenu(); }
		
		private function onGuestClick(e:Event):void { showGuestMenu(); }
		
		private function onRespond(e:Event):void 
		{
			if ( e.type == Confirmation.YES ) 
				showResult();
			
			confirmation.hide();
		}
		
		private function onSelection(e:Event):void 
		{
			var o:Object = gcMenu.getSelected();
			
			hideGuestMenu();
			gcMenu.desactivate( o.idx );
			guestsList.select( o.mc );
			
			if ( aCompo[ guestsList.getSelectedIdx() - 1 ] ) gcMenu.activate( aCompo[ guestsList.getSelectedIdx() - 1 ].idx );
			aCompo[ guestsList.getSelectedIdx() - 1 ] = o;
			
			if ( checkValidation() )
			{
				zValid.alpha = 1;
				zValid.enabled = true;
				zValid.useHandCursor = true;
			}
		}
		
		private function onEndClick(e:MouseEvent):void 
		{
			trace( "fin !" );
		}
		
		// PRIVATE
		
		private function moveTo( sens:String ):void
		{
			if ( sens == Table.LEFT )
			{
				guestsList.toLeft();
			}
			else
			{
				guestsList.toRight();
			}
			
			setButtonsStatus();
		}
		
		private function setButtonsStatus():void
		{
			var scrollVal:int = guestsList.getScrollValue();
			var idxMax:int = guestsList.getIdxMax();
			
			if ( scrollVal == 0 )
			{
				zLeft.alpha = .5;
				zLeft.enabled = false;
			}
			else
			{
				zLeft.alpha = 1;
				zLeft.enabled = true;
			}
			
			if ( scrollVal == idxMax )
			{
				zRight.alpha = .5;
				zRight.enabled = false;
			}			
			else
			{
				zRight.alpha = 1;
				zRight.enabled = true;
			}
		}
		
		private function showGuestMenu():void
		{
			curtain.visible = true;
			curtain.x = document ? -document.getX() : 0;
			curtain.y = document ? -document.getY() : 0;
			curtain.width = stage.stageWidth;
			curtain.height = stage.stageHeight;
			Tweener.addTween( curtain, { alpha: 1, time: .3, transition: "easeInOutQuad" } );
			gcMenu.show();
		}
		
		private function hideGuestMenu():void
		{
			Tweener.addTween( curtain, { alpha: 0, time: .3, transition: "easeInOutQuad", onComplete: function():void { curtain.visible = false } } );
			gcMenu.hide();
		}
		
		private function checkValidation():Boolean
		{
			var i:int;
			var n:int = aCompo.length;
			for ( i; i < n; i++ ) if ( !aCompo[ i ] ) return false;
			
			return true;
		}
		
		private function showResult():void
		{
			curtain.removeEventListener( MouseEvent.CLICK, onCurtainClick );
			curtain.addEventListener( MouseEvent.CLICK, onEndClick );
			curtain.visible = true;
			curtain.x = document ? -document.getX() : 0;
			curtain.y = document ? -document.getY() : 0;
			curtain.width = stage.stageWidth;
			curtain.height = stage.stageHeight;
			Tweener.addTween( curtain, { alpha: 1, time: .3, transition: "easeInOutQuad" } );
			
			var humourgras:int;
			var cultive:int;
			var decale:int;
			var inclassable:int;
			
			var i:int;
			var n:int = aCompo.length
			for ( i; i < n; i++ ) 
			{
				switch( aCompo[ i ].type )
				{
					case CharType.HUMOURGRAS: humourgras++;
					case CharType.CULTIVE: cultive++;
					case CharType.DECALE: decale++;
					case CharType.INCLASSABLE: inclassable++;
				}
			}
			
			var s:String;
			if ( humourgras == 1 && cultive == 1 && decale == 1 && inclassable == 1 ) 
			{
				s = "Bravo ! Votre table est... Parfaite ! Et votre diner l'est aussi, du coup. \n Peut être viendrez vous voir 'Le diner des illustres' en avant première ?é";
			}
			else
			{			
				var idx:int;
				var type:String;
				if ( humourgras > idx )
				{
					idx = humourgras;
					type = CharType.HUMOURGRAS;
				}
				if ( cultive > idx )
				{
					idx = cultive;
					type = CharType.CULTIVE;
				}
				if ( decale > idx )
				{
					idx = decale;
					type = CharType.DECALE;
				}
				if ( inclassable > idx )
				{
					idx = inclassable;
					type = CharType.INCLASSABLE;
				}
				
				switch ( type )
				{
					case CharType.CULTIVE: s = "Apparemment, vos invités sont trop cultivés pour... Vous. Peut être auriez du faire plus attentifs lors de vos invitations ?"; break;
					case CharType.DECALE: s = "On ne peut dire qu'une chose, c'est que l'humour baigne à cette table. A tel point que vous aussi, vous êtes marrants."; break;
					case CharType.HUMOURGRAS: s = "L'humour noir ou lourd, c'est marrant deux minutes, mais quand toute la table s'y met... On devient vite mauvais public, non ?"; break;
					case CharType.INCLASSABLE: s = "Bravo, vous avez réussi à réunir du bon monde pour le prochain cirque de Zavatta"; break;
				}
			}
			
			endMessage.texte.text = s;
			endMessage.visible = true;
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
		
		public function checkDispo( idx:int ):Boolean
		{
			var i:int;
			var n:int = aCompo.length;
			for ( i; i < n; i++ ) 
			{
				if ( aCompo[ i ] ) 
				{
					if ( aCompo[ i ].idx == idx ) return false;
				}
			}
			return true;
		}
		
		public function getInfos():Array
		{
			return datas.getInfos();
		}
		
		public function getUrls():Array
		{
			return datas.getUrls();
		}
		
		public function getPortrait():Bitmap
		{
			if ( !document ) return new Bitmap( new BitmapData( 261, 297, false, 0xFF0000 ) );
			
			Debug.allowLog = true;
			
			var o:Object = document.getPortraitInfos();
			var b:Bitmap = o.bitmap;
			var bd:BitmapData = b.bitmapData.clone();
			
			var bdPortrait:BitmapData = new BitmapData( 261, 297, true, 0x000000 );
			bdPortrait.draw( o.sexe == ItemSexe.HOMME ? new BusteH( 0, 0 ) : new BusteF( 0, 0 ) );
			bdPortrait.draw( UBit.resize( bd, 250, 170, true  ), new Matrix( 1, 0, 0, 1, -5 ) );
			
			var bPortrait:Bitmap = new Bitmap( bdPortrait );
			
			Debug.bitmap( b );			
			return bPortrait;
		}
		
	}
	
}