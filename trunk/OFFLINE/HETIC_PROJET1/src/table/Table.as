
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package table 
{
	import accueil.Accueil;
	import caurina.transitions.Tweener;
	import fl.motion.Motion;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.net.sendToURL;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import fr.minuit4.utils.UBit;
	import main.Main;
	import portrait.ItemSexe;
	
	public class Table extends MovieClip 
	{
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		
		public static const SUCCES:String = "succes";
		
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
		public var wallpaper:MovieClip;
		public var frontItems:MovieClip;
		public var zRightGrand:MovieClip;
		public var zLeftGrand:MovieClip;
		
		private var aCompo:Array;
		
		private var document:Main;		
		private var datas:Datas;
		
		private var status:String;
		
		private var pos:Array = [ 0, -261, -261 * 2, -261 * 3 ];
		private var pos2:Array = [ 50, 50 - ( 50 + 261 ), 50 - ( 50 * 2 + 261 * 2 ), 50 - ( 50 * 3 + 261 * 3 ) ];
		
		public function Table() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			datas.removeEventListener( Event.COMPLETE, onLoadComplete );
			
			Tweener.removeTweens( curtain );
			
			endMessage.zRetour.removeEventListener( MouseEvent.CLICK, onRetourClick );
			endMessage.succes.saisie.removeEventListener( FocusEvent.FOCUS_OUT, onFocusOut );
			
			Tweener.removeTweens( frontItems );
			Tweener.removeTweens( wallpaper );
			Tweener.removeTweens( endMessage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			document = getAncestor( this, Main ) as Main;
			
			endMessage.visible = false;
			endMessage.succes.visible = false;
			
			zValid.alpha = .5;
			zValid.enabled = false;
			zValid.useHandCursor = false;
			
			UBit.strechIn( new Nappe( 0, 0 ), front, front.width, front.height );
			
			datas = new Datas( document ? document.path_xml + "invites.xml" : "xml/invites.xml" );
			datas.addEventListener( Event.COMPLETE, onLoadComplete );
			datas.load();
		}
		
		private function onLoadComplete(e:Event):void 
		{				
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
			guestsList.addEventListener( GuestsList.SHOW, onGuestClick );
			
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
		
		private function onRetourClick(e:MouseEvent):void 
		{
			if ( status == Table.SUCCES ) 
			{
				if ( !isTextIsMail() ) 
				{
					endMessage.succes.fondSaisie.gotoAndStop( 2 );
					return;
				}
				
				endMessage.succes.fondSaisie.gotoAndStop( 1 );
				
				var s:String = endMessage.succes.saisie.text;
				
				var variables:URLVariables = new URLVariables();
				variables.mail = s;
				
				var request:URLRequest = new URLRequest( document ? document.path_php + "ajoutmail.php" : "inc/ajoutmail.php" );
				request.method = URLRequestMethod.POST;
				request.data = variables;
				
				try
				{
					sendToURL( request );
				}
				catch ( e:Error )
				{
					trace ( "erreur lors de l'envoie" );
				}
				
				dispatchEvent( new Event( Main.STEP_COMPLETE ) );
			}
			else 
			{
				dispatchEvent( new Event( Main.STEP_COMPLETE ) );
			}
		}
		
		private function onFocusOut(e:FocusEvent):void 
		{
			endMessage.succes.fondSaisie.gotoAndStop( isTextIsMail() ? 1 : 2 );
		}
		
		// PRIVATE
		
		private function moveTo( sens:String ):void
		{
			var scrollVal:int = guestsList.getScrollValue();
			
			if ( sens == Table.LEFT )
			{
				if ( guestsList.toLeft() )
				{
					scrollVal--;
					Tweener.addTween( wallpaper, { x: pos[ scrollVal ], time: .5, transition: "linear" } );
					Tweener.addTween( frontItems, { x: pos2[ scrollVal ], time: .5, transition: "linear" } );
				}
			}
			else
			{
				if ( guestsList.toRight() )
				{
					scrollVal++;
					Tweener.addTween( wallpaper, { x: pos[ scrollVal ], time: .5, transition: "linear" } );
					Tweener.addTween( frontItems, { x: pos2[ scrollVal ], time: .5, transition: "linear" } );
				}
			}
			
			setButtonsStatus();
		}
		
		private function setButtonsStatus():void
		{
			var scrollVal:int = guestsList.getScrollValue();
			var idxMax:int = guestsList.getIdxMax();
			
			if ( scrollVal == 0 )
			{
				//zLeft.alpha = .5;
				zLeftGrand.gotoAndStop( 1 );
				zLeft.enabled = false;
			}
			else
			{
				//zLeft.alpha = 1;
				zLeftGrand.gotoAndStop( 2 );
				zLeft.enabled = true;
			}
			
			if ( scrollVal == idxMax )
			{
				//zRight.alpha = .5;
				zRightGrand.gotoAndStop( 1 );
				zRight.enabled = false;
			}			
			else
			{
				//zRight.alpha = 1;
				zRightGrand.gotoAndStop( 2 );
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
			guestsList.removeEventListener( Event.ACTIVATE, onGuestClick );
			gcMenu.removeEventListener( GuestsChoiceMenu.SELECTION, onSelection );
			
			curtain.removeEventListener( MouseEvent.CLICK, onCurtainClick );
			curtain.useHandCursor = false;
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
					case CharType.HUMOURGRAS: humourgras++; break;
					case CharType.CULTIVE: cultive++; break;
					case CharType.DECALE: decale++; break;
					case CharType.INCLASSABLE: inclassable++; break;
				}
			}
			
			var s:String;
			if ( humourgras == 1 && cultive == 1 && decale == 1 && inclassable == 1 ) 
			{
				status = Table.SUCCES;
				
				s = "Bravo ! Votre table est... Parfaite ! Et votre diner l'est aussi, du coup. \n Peut être viendrez vous voir 'Le diner des illustres' en avant première ?";
				endMessage.fond.gotoAndPlay( 2 );
				endMessage.img.gotoAndPlay( 2 );
				endMessage.succes.fondSaisie.gotoAndStop( 2 );
				endMessage.succes.visible = true;
				endMessage.succes.saisie.text = "Saisissez votre mail";
				endMessage.succes.saisie.addEventListener( FocusEvent.FOCUS_OUT, onFocusOut );
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
					case CharType.CULTIVE: s = "On s'ennuie dans votre dîner ! Les livres c'est bien, mais là c'est le réveillon de Noël, il faut s'amuser ! Mettez-y un peu de piment la prochaine fois."; break;
					case CharType.DECALE: s = "A force de vouloir être différent des autres, on finit par ne plus se comprendre du tout. Faites preuve de plus de cohérence dans le choix de vos invités la prochaine fois."; break;
					case CharType.HUMOURGRAS: s = "L'humour noir ou lourd, c'est marrant deux minutes, mais quand toute la table s'y met... On devient vite mauvais public, nan ? Conviez des invités un peu plus fins la prochaine fois."; break;
					case CharType.INCLASSABLE: s = "C'est triste mais certaines personnes ne sont pas intéressantes ou en tout cas ce ne sont pas elles qui animeront les débats du dîner. Pensez à ceux qui pourraient lancer les débats la prochaine fois."; break;
				}
			}
			
			endMessage.texte.text = s;
			endMessage.visible = true;
			Tweener.addTween( endMessage, { y: 40, time: .5, transition: "easeInOutQuad" } );
			
			endMessage.zRetour.addEventListener( MouseEvent.CLICK, onRetourClick );
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
		
		private function isTextIsMail():Boolean
		{
			var s:String = endMessage.succes.saisie.text;
			if ( !s || s == " " ) return false;
			
			var i:int = s.search( /[@]/g );
			if ( i < 0 ) return false;
			
			i = s.search( /[.]/g );
			if ( i < 0 ) return false;
			
			return true;
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
			
			var o:Object = document.getPortraitInfos();
			var b:Bitmap = o.bitmap;
			var bd:BitmapData = b.bitmapData.clone();
			
			var bdPortrait:BitmapData = new BitmapData( 261, 297, true, 0x000000 );
			bdPortrait.draw( o.sexe == ItemSexe.HOMME ? new BusteH( 0, 0 ) : new BusteF( 0, 0 ) );
			bdPortrait.draw( UBit.resize( bd, 250, 170, true  ), new Matrix( 1, 0, 0, 1, -5 ) );
			
			var bPortrait:Bitmap = new Bitmap( bdPortrait );
					
			return bPortrait;
		}
		
	}
	
}