package interfaceSite 
{
	import caurina.transitions.Tweener;
	import five3D.display.Sprite3D;
	import flash.events.Event;
	
	public class Feuille extends Sprite3D
	{
		static public const CREATE:String = "create";
		static public const ERASE:String = "erase";
		
		private var larg:Number;
		private var haut:Number;
		private var color:uint;
		private var alph:Number;
		
		private var nbrW:int;
		private var nbrH:int;
		private var background:Sprite3D;
		
		public function Feuille( larg:Number, haut:Number, color:uint, alph:Number = 1 ) 
		{
			this.larg = larg;
			this.haut = haut;
			this.color = color;
			this.alph = alph;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			Tweener.removeTweens( this );
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage )
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
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
					
					t.x = Math.random() * 1000 - 500;
					t.y = Math.random() * 1000 - 500;
					t.z = Math.random() * 500 - 250;					
					
					Tweener.addTween( t, { x: -larg/2 + j * 100, y: -haut/2 + i * 100, z: 0, rotationX: 0, rotationY: 0, rotationZ: 0, alpha: 1, time: 1, delay: (j+i)*.1, transition: "easeInOutQuad" } );
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
					Tweener.addTween( background.getChildAt( j + nbrW * i ), { x:  Math.random() * 1000 - 500, y:  Math.random() * 1000 - 500, z:  Math.random() * 500 - 250, rotationX: Math.random() * 360, rotationY: Math.random() * 360, rotationZ: Math.random() * 360, alpha: 1, time: 1, delay: .5, transition: "easeInOutQuad" } ); 
				}
				j = 0;
			}
			
			dispatchEvent( new Event( Feuille.ERASE ) );
		}
		
	}
	
}