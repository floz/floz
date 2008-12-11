
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
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.utils.UBit;
	
	public class Sketch extends MovieClip
	{
		public var cnt:MovieClip;
		
		private var document:Portrait;
		private var strk:Shape;
		private var cntAccessoires:MovieClip;
		private var cntCheveux:MovieClip;
		private var cntNez:MovieClip;
		private var cntYeux:MovieClip;
		private var cntBouche:MovieClip;
		private var cntGabarit:MovieClip;
		
		private var small:Boolean;
		private var inited:Boolean;
		
		private var dragging:Boolean;
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
			
			strk = new Shape();
			strk.graphics.lineStyle( 2 );
			strk.graphics.beginFill( 0, 0 );
			strk.graphics.drawRect( 0, 0, 360, 360 );
			strk.graphics.endFill();
			addChild( strk );
			
			strk.visible = false;
			
			cntAccessoires = cnt.accessoires;
			cntCheveux = cnt.cheveux;
			cntNez = cnt.nez;
			cntYeux = cnt.yeux;
			cntBouche = cnt.bouche;
			cntGabarit = cnt.gabarit;
		}
		
		private function onDown(e:MouseEvent):void 
		{
			dragging = true;
			itemSelected = MovieClip( e.currentTarget );
			
			baseX = e.localX;
			baseY = e.localY;
			
			stage.addEventListener( MouseEvent.MOUSE_UP, onUp );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMove );
		}
		
		private function onUp(e:MouseEvent):void 
		{
			dragging = false;
			
			stage.removeEventListener( MouseEvent.MOUSE_UP, onUp );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMove );
		}
		
		private function onMove(e:MouseEvent):void 
		{
			itemSelected.x = e.stageX - cnt.x - this.x - baseX;
			itemSelected.y = e.stageY - cnt.y - this.y - baseY;
			
			strk.x = cnt.x + itemSelected.x;
			strk.y = cnt.y + itemSelected.y;
			
			e.updateAfterEvent();
		}
		
		private function onOver(e:MouseEvent):void 
		{
			if ( dragging ) return;
			
			strk.visible = true;
			strk.x = cnt.x + e.currentTarget.x;
			strk.y = cnt.y + e.currentTarget.y;
			strk.width = e.currentTarget.width;
			strk.height = e.currentTarget.height;			
		}
		
		private function onOut(e:MouseEvent):void 
		{
			if ( dragging ) return;
			
			strk.visible = false;
		}
		
		// PRIVATE
		
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
					m.addEventListener( MouseEvent.ROLL_OVER, onOver );
					m.addEventListener( MouseEvent.ROLL_OUT, onOut );
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
		}
		
		// GETTERS & SETTERS
		
		public function getBitmap():Bitmap
		{
			return bitmap;
		}
		
	}
	
}