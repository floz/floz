package interfaceSite 
{
	import caurina.transitions.Tweener;
	import five3D.display.Sprite3D;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	
	public class Feuille extends Sprite3D
	{
		//static public const CREATE:String = "create";
		static public const DELETE:String = "delete";
		
		private var larg:Number = 700;
		private var haut:Number = 400;
		private var color:uint = 0x000000;
		
		//private var eventCreate:Event;
		private var eventDelete:Event;
		
		private var nbrW:int;
		private var nbrH:int;
		private var background:Sprite3D;
		
		public function Feuille() 
		{	
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			Tweener.removeTweens( this );
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			eventDelete = new Event( Feuille.DELETE );
			
			create();
		}
		
		// PRIVATE
		
		private function create():void
		{
			background = new Sprite3D();
			addChild( background );
			
			nbrW = int( larg / 100 );
			nbrH = int( haut / 100 );
			
			var t:Tile;
			var i:int;
			var j:int;
			for ( i; i < nbrH; i++ )
			{
				for ( j; j < nbrW; j++ )
				{
					t = new Tile( color );
					background.addChild( t );
					
					t.x = larg / 2;
					t.y = haut / 2;
					
					Tweener.addTween( t, { x: j * 100, y: i * 100, z:0, rotationX: 0, rotationY: 0, rotationZ: 0, alpha: 1, time: 1, delay: (j + i) * .1, transition: "easeInOutQuad" } );
				}				
				j = 0;
			}
		}
		
		// PUBLIC
		
		public function erase():void
		{
			var t:Tile;
			var i:int;
			var j:int;
			for ( i; i < nbrH; i++ )
			{
				for ( j; j < nbrW; j++ )
				{
					if ( j != nbrW - 1 && i != nbrH-1 ) Tweener.addTween( background.getChildAt( j + nbrW * i ), { x:  0, y:  0, z:  0, rotationX: Math.random() * 360, rotationY: Math.random() * 360, rotationZ: Math.random() * 360, alpha: 0, time: 1, delay: .5, transition: "easeInOutQuad" } ); 
						else Tweener.addTween( background.getChildAt( j + nbrW * i ), { x: 0, y:  0, z:  0, rotationX: Math.random() * 360, rotationY: Math.random() * 360, rotationZ: Math.random() * 360, alpha: 0, time: 1, delay: .5, transition: "easeInOutQuad", onComplete: function():void { dispatchEvent( eventDelete ); } } ); 
				}
				j = 0;
			}
		}
		
	}
	
}