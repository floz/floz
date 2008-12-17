
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package portrait 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import fr.minuit4.utils.UBit;
	
	public class Sketch extends MovieClip
	{
		public var cnt:MovieClip;
		
		private var document:Portrait;
		private var strk:Shape;
		private var empty:Boolean;
		private var cntAccessoires:MovieClip;
		private var cntCheveux:MovieClip;
		private var cntNez:MovieClip;
		private var cntYeux:MovieClip;
		private var cntBouche:MovieClip;
		private var cntGabarit:MovieClip;
		
		private var small:Boolean;
		private var inited:Boolean;
		
		private var dragging:Boolean;
		private var itemToSelect:MovieClip;
		private var itemSelected:MovieClip;
		private var baseX:Number;
		private var baseY:Number;
		
		private var bitmap:Bitmap;
		
		public function Sketch() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			removeEventListener( MouseEvent.MOUSE_MOVE, onMove );
			removeEventListener( MouseEvent.MOUSE_OUT, onOut );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onStageMove );
			
			var i:int;
			var n:int = cnt.numChildren
			for ( i; i < n; i++ ) MovieClip( cnt.getChildAt( i ) ).removeEventListener( MouseEvent.MOUSE_DOWN, onDown );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			document = getAncestor( this, Portrait ) as Portrait;
			
			empty = true;
			
			strk = new Shape();
			strk.graphics.lineStyle( 2, 0x333333 );
			strk.graphics.beginFill( 0, 0 );
			strk.graphics.drawRect( 0, 0, 360, 360 );
			strk.graphics.endFill();			
			addChild( strk );
			
			strk.visible = false;
			
			cntAccessoires = cnt.accessoires;
			cntAccessoires.x = 21; cntAccessoires.y = 131;
			cntCheveux = cnt.cheveux;
			cntCheveux.x = 16; cntCheveux.y = 1;
			cntNez = cnt.nez;
			cntNez.x = 21; cntNez.y = 150;
			cntYeux = cnt.yeux;
			cntYeux.x = 16; cntYeux.y = 99;
			cntBouche = cnt.bouche;
			cntBouche.x = 20; cntBouche.y = 203;
			cntGabarit = cnt.gabarit;
			cntGabarit.x = 19; cntGabarit.y = 19;
			
			addEventListener( MouseEvent.MOUSE_MOVE, onMove );
			addEventListener( MouseEvent.ROLL_OUT, onOut );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			if ( dragging ) return;
			setOutState();			
		}
		
		private function onMove(e:MouseEvent):void 
		{
			if ( dragging ) return;
			if ( empty ) return;
			
			// on récupère les différents enfants "apte à être étudiés"
			var a:Array = getChildrenAvailable();
			if ( !a.length ) return;
			
			var b:Array = [];
			a.forEach( function( e ) 
				{
					b.push( getMiddleRectPoint( e.getRect( stage ) ) );
				});
			
			var idx:int
			var ct:int;
			var c:Array = [];
			var i:int;
			var n:int = a.length;
			for ( i; i < n; i++ ) 
			{
				if ( isMouseOver( a[ i ] ) ) c.push( a[ i ] );
				if ( a[ i ] == cntCheveux || a[ i ] == cntGabarit ) ct++;
			}
			
			if ( c.length == 1 ) // si juste gabarit sous la souris
			{
				itemToSelect = c[ 0 ];
			}
			else if ( c.length == ct && c.length != 1 ) // Différence cheveux/gabarit
			{
				n = c.length;
				if ( e.localY > 235 )
				{
					for ( i = 0; i < n; i++ ) if ( c[ i ] == cntGabarit ) idx = i;
				}
				else
				{
					for ( i = 0; i < n; i++ ) if ( c[ i ] == cntCheveux ) idx = i;
				}
				
				itemToSelect = c[ idx ];
			}
			else
			{
				// on va chercher le point central des éléments, le plus proche de la souris
				idx = getClosetPoint( b, stage.mouseX, stage.mouseY );
				
				// closest element
				var ce:MovieClip = MovieClip( a[ idx ] );
				if ( itemToSelect == null ) itemToSelect = new MovieClip();
				if ( ce != itemToSelect )
				{
					// nouvelle vérification afin de savoir si l'élément est bien celui le plus proche
					var r:Rectangle = itemToSelect.getRect( stage );
					
					c = [ getMiddleRectPoint( ce.getRect( stage ) ),
									new Point( r.x, r.y ),
									new Point( r.right, r.y ),
									new Point( r.x, r.top ),
									new Point( r.x, r.bottom ) ];
					
					var idx2:int = getClosetPoint( c, stage.mouseX, stage.mouseY );
					
					if ( idx2 == 0 )
					{
						itemToSelect = ce;
						//setOverState();
					}
				}
			}
			
			//
			
			if ( dragging || !a.length ) return;
			
			b = [];
			n = a.length;
			for ( i = 0; i < n; i++ ) if ( isMouseOver( a[ i ] ) ) b.push( a[ i ] );
			
			if ( b.length )	setOverState();
			else setOutState();
		}
		
		private function onDown(e:MouseEvent):void 
		{
			dragging = true;
			itemSelected = itemToSelect;
			
			if ( itemSelected )
			{
				baseX = e.stageX - this.x - cnt.x - itemSelected.x;
				baseY = e.stageY - this.y - cnt.y - itemSelected.y;
			}
			
			stage.addEventListener( MouseEvent.MOUSE_UP, onUp );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onStageMove );
		}
		
		private function onUp(e:MouseEvent):void 
		{
			dragging = false;
			//setOutState();
			
			stage.removeEventListener( MouseEvent.MOUSE_UP, onUp );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onStageMove );
		}
		
		private function onStageMove(e:MouseEvent):void 
		{
			var temp:Number = e.stageX - cnt.x - this.x - baseX;
			if ( temp >= 0 && ( temp + itemSelected.width ) <= 392 ) itemSelected.x = temp;
			//else setOutState();
			temp = e.stageY - cnt.y - this.y - baseY
			if ( temp >= 0 && ( temp + itemSelected.height ) <= 446 ) itemSelected.y = temp;
			//else setOutState();
			
			strk.x = cnt.x + itemSelected.x;
			strk.y = cnt.y + itemSelected.y;			
			
			e.updateAfterEvent();
		}
		
		// PRIVATE
		
		private function setOverState():void
		{
			strk.visible = true;
			strk.x = cnt.x + itemToSelect.x
			strk.y = cnt.y + itemToSelect.y;
			strk.width = itemToSelect.width;
			strk.height = itemToSelect.height;
			
			darken();
		}
		
		private function setOutState():void
		{
			strk.visible = false;
			itemToSelect = null;
			
			lighten();
		}
		
		private function lighten():void
		{
			var a:Array = getChildrenAvailable();
			var i:int;
			var n:int = a.length;
			for ( i; i < n; i++ ) a[ i ].alpha = 1;
		}
		
		private function darken():void
		{
			var a:Array = getChildrenAvailable();
			var i:int;
			var n:int = a.length;
			for ( i; i < n; i++ )
			{
				if ( a[ i ] == itemToSelect ) a[ i ].alpha = 1;
				else a[ i ].alpha = .3;
			}
		}
		
		private function cleanContainer( m:MovieClip ):void
		{
			while ( m.numChildren ) m.removeChildAt( 0 );
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
		
		private function getChildrenAvailable():Array
		{
			var a:Array = [];
			
			var i:int;
			var n:int = cnt.numChildren;
			for ( i; i < n; i++ ) if ( MovieClip( cnt.getChildAt( i ) ).numChildren ) a.push( cnt.getChildAt( i ) );
			
			return a;
		}
		
		private function isMouseOver( child:DisplayObject ):Boolean
		{
			return child.getRect( stage ).contains( stage.mouseX, stage.mouseY );
		}
		
		private function setValidState():void
		{
			if ( cntGabarit.numChildren && cntBouche.numChildren && cntYeux.numChildren && cntNez.numChildren ) document.setValidStatus( true );
			else document.setValidStatus( false );
		}
		
		// PUBLIC
		
		public function init():void
		{
			clean();
			
			if ( !inited )
			{
				var m:MovieClip;
				
				var i:int;
				var n:int = cnt.numChildren;
				for ( i; i < n; i++ )
				{
					m = MovieClip( cnt.getChildAt( i ) );
					m.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
					//m.addEventListener( MouseEvent.ROLL_OVER, onOver );
					//m.addEventListener( MouseEvent.ROLL_OUT, onOut );
					m.buttonMode = true;
				}
				
				inited = true;
			}
		}
		
		public function clean():void
		{
			var i:int;
			var n:int = cnt.numChildren;
			for ( i; i < n; i++ ) cleanContainer( MovieClip( cnt.getChildAt( i ) ) );
			
			empty = true;
			
			setOutState();
		}
		
		public function cleanItemSelected():void
		{
			if ( !itemSelected ) return;
			cleanContainer( itemSelected );
			
			setValidState();
		}
		
		public function saveAsBitmap():void
		{
			setOutState();
			
			var bd:BitmapData = new BitmapData( cnt.width, cnt.height, true, 0xff00ff );
			bd.draw( cnt );
			
			bitmap = new Bitmap( bd );
		}
		
		public function selectItem( bd:BitmapData ):void
		{
			small = ( document.getCategorie() == ItemCategorie.CHEVEUX || document.getCategorie() == ItemCategorie.GABARIT ) ? false : true;
			var b:Bitmap = small ? new Bitmap( UBit.resize( bd, 360, 160, true, true ) ) : new Bitmap( UBit.resize( bd, 360, 360, true, true ) );
			
			switch( document.getCategorie() )
			{
				case ItemCategorie.ACCESSOIRES : 
					cleanContainer( cntAccessoires ); 
					cntAccessoires.addChild( b );
					
					break;
				case ItemCategorie.CHEVEUX : 
					cleanContainer( cntCheveux ); 
					cntCheveux.addChild( b ); 
					
					break;
				case ItemCategorie.NEZ : 
					cleanContainer( cntNez ); 
					cntNez.addChild( b ); 
					
					break;
				case ItemCategorie.YEUX : 
					cleanContainer( cntYeux );
					cntYeux.addChild( b ); 
					
					break;
				case ItemCategorie.BOUCHE : 
					cleanContainer( cntBouche ); 
					cntBouche.addChild( b );
					
					break;
				case ItemCategorie.GABARIT : 
					cleanContainer( cntGabarit );
					cntGabarit.addChild( b ); 
					
					break;
			}
			
			setValidState();
			empty = false;
		}
		
		// GETTERS & SETTERS
		
		public function getBitmap():Bitmap
		{
			return bitmap;
		}
		
		private function getMiddleRectPoint( rect:Rectangle ):Point
		{
			return new Point( rect.x + rect.width * .5, rect.y + rect.height * .5 );
		}
		
		private function getClosetPoint( points:Array, px:Number, py:Number ):int
		{
			var d:Number = Number.MAX_VALUE;
			var idx = -1;
			
			var t:Number;
			var i:int;
			var n:int = points.length;
			for ( i; i < n; i++ )
			{
				t = Math.sqrt( ( px - points[ i ].x ) * ( px - points[ i ].x ) + ( py - points[ i ].y ) * ( py - points[ i ].y ) );
				if ( t < d )
				{
					d = t;
					idx = i;
				}
			}
			
			return idx;
		}
		
	}
	
}