
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package portrait 
{
	import com.carlcalderon.arthropod.Debug;
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
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			document = getAncestor( this, Portrait ) as Portrait;
			
			empty = true;
			
			strk = new Shape();
			strk.graphics.lineStyle( 2 );
			strk.graphics.beginFill( 0, 0 );
			strk.graphics.drawRect( 0, 0, 360, 360 );
			strk.graphics.endFill();
			
			strk.graphics.beginFill( 0, 1 );
			strk.graphics.drawCircle( 360/2 - 5, 360/2 - 5, 10 );
			strk.graphics.endFill();
			addChild( strk );
			
			strk.visible = false;
			
			cntAccessoires = cnt.accessoires;
			cntCheveux = cnt.cheveux;
			cntNez = cnt.nez;
			cntYeux = cnt.yeux;
			cntBouche = cnt.bouche;
			cntGabarit = cnt.gabarit;
			
			addEventListener( MouseEvent.MOUSE_MOVE, onMove );
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
			
			var idx:int = getClosetPoint( b, stage.mouseX, stage.mouseY );
			
			// closest element
			var ce:MovieClip = MovieClip( a[ idx ] );
			if ( itemToSelect == null ) itemToSelect = new MovieClip();
			if ( ce != itemToSelect )
			{
				// nouvelle vérification afin de savoir si l'élément est bien celui le plus proche
				var r:Rectangle = itemToSelect.getRect( stage );
				
				var c:Array = [ getMiddleRectPoint( ce.getRect( stage ) ),
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
			
			//
			
			if ( dragging || !a.length ) return;
			
			b = [];
			var i:int;
			var n:int = a.length;
			for ( i; i < n; i++ ) if ( isMouseOver( a[ i ] ) ) b.push( a[ i ] );
			
			if ( b.length )	setOverState();
			else setOutState();
		}
		
		private function onDown(e:MouseEvent):void 
		{
			dragging = true;
			itemSelected = itemToSelect;
			
			baseX = e.localX;
			baseY = e.localY;
			
			stage.addEventListener( MouseEvent.MOUSE_UP, onUp );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onStageMove );
		}
		
		private function onUp(e:MouseEvent):void 
		{
			dragging = false;
			
			stage.removeEventListener( MouseEvent.MOUSE_UP, onUp );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onStageMove );
		}
		
		private function onStageMove(e:MouseEvent):void 
		{
			itemSelected.x = e.stageX - cnt.x - this.x - baseX;
			itemSelected.y = e.stageY - cnt.y - this.y - baseY;
			
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
		}
		
		private function setOutState():void
		{
			strk.visible = false;
			itemToSelect = null;
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
		}
		
		public function cleanItemSelected():void
		{
			if ( !itemSelected ) return;
			cleanContainer( itemSelected );
		}
		
		public function saveAsBitmap():void
		{
			var bd:BitmapData = new BitmapData( cnt.width, cnt.height, true, 0xff00ff );
			bd.draw( cnt );
			
			bitmap = new Bitmap( bd );
			Debug.bitmap( bitmap );
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