package floz.loaders 
{
	import caurina.transitions.Tweener;
	import five3D.display.DynamicText3D;
	import five3D.display.Sprite2D;
	import five3D.display.Sprite3D;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filters.BlurFilter;
	import flash.net.URLRequest;
	import floz.utils.UDis;
	
	public class LoaderSF extends Sprite3D
	{
		public static const LOAD_COMPLETE:String = "loadComplete";
		
		private var letters:Array = [ "[", ">", "{", "/", "=", "v" ];
		private var numbers:Array = [ 0, 0, 0 ]; // type: int & String
		private var url:String;
		private var size:Number;
		private var font:Class;
		private var alphaFond:Number;
		
		private var lueur:Sprite2D;
		private var cntFront:Sprite3D;
		private var cntBack:Sprite3D;
		private var childsFront:Array;
		private var childsBack:Array;
		private var request:URLRequest;
		private var loader:Loader;
		private var eventComplete:Event;
		
		private var i:int;
		private var testTween:Boolean;
		
		private var dixaine:int;
		private var centaine:int;
		private var txt:DynamicText3D;
		
		
		public function LoaderSF() 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			this.alpha = 0;
			
			lueur = new Sprite2D();
			addChild( lueur );
			
			cntFront = new Sprite3D();
			addChild( cntFront );
			
			cntBack = new Sprite3D();
			addChild( cntBack );
			
			childsFront = [];
			childsBack = [];
			request = new URLRequest();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress );
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError);
			
			eventComplete = new Event( LoaderSF.LOAD_COMPLETE );
		}
		
		// EVENTS
		
		private function onRemovedFromStage( e:Event ):void
		{
			Tweener.removeTweens( this );
			
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress );
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError);
			
			while ( this.numChildren > 0 ) this.removeChildAt( 0 );
			
			loader = null;
			numbers = null;
			childsFront = null;
			childsBack = null;
			txt = null;
			i = 0;
			dixaine = 0;
			centaine = 0;
		}
		
		private function onComplete( e:Event ):void 
		{
			lueur.visible = false;
			
			for ( i; i < 3; i++ )
			{
				childsFront[ i ].text = letters[ i ];
				childsBack[ i ].text = letters[ i + 3 ];
				
				Tweener.addTween( this, { alpha: 0, time: 1, transition: "easeInOutQuad", onComplete: function():void { dispatchEvent( eventComplete ), clean(); } } );
				Tweener.addTween( childsFront[ i ], { x: Math.random() * stage.stageWidth - stage.stageWidth/2, y:Math.random() * stage.stageHeight - stage.stageHeight/2, z: Math.random() * 200 + 100, time: 1, rotationX: Math.random() * 360, rotationY: Math.random() * 360, rotationZ: Math.random() * 360, transition: "easeInOutQuad" } );
				Tweener.addTween( childsBack[ i ], { x: Math.random() * stage.stageWidth - stage.stageWidth/2, y:Math.random() * stage.stageHeight - stage.stageHeight/2, z: Math.random()*200 + 100, rotationX: Math.random() * 360, rotationY: Math.random() * 360, rotationZ: Math.random() * 360, time: 1, transition: "easeInOutQuad" } );
			}
		}
		
		private function onIOError( e:IOErrorEvent ):void
		{
			trace( "IOErrorEvent.IO_ERROR >", request.url );
		}
		
		private function onProgress( e:ProgressEvent ):void 
		{
			var n:Number = int( e.bytesLoaded / e.bytesTotal * 100 );
			var t:String = n.toString();
			numbers = t.split( "" );
			while ( numbers.length < 3 ) numbers.unshift( 0 );
			
			if ( dixaine != numbers[ 1 ] ) 
			{
				dixaine = numbers[ 1 ];
				centaine = numbers[ 0 ];
				testTween = true;
			}
			
			for ( i; i < 3; i++ )
			{
				childsFront[ i ].text = numbers[ i ].toString();
				childsBack[ i ].text = numbers[ i ] != 0 ? ( numbers[ i ] - 1 ).toString() : numbers[ i ].toString();
				
				if ( testTween )
				{
					childsFront[ i ].alpha = 0;
					if ( i == 0 && centaine == 1 ) childsFront[ i ].z = -500;
					else if ( i == 1 ) childsFront[ i ].z = -500;
					childsBack[ i ].alpha = 1;
					Tweener.addTween( childsFront[ i ], { z: 0,  alpha: 1, time: .5, transition: "easeInOutQuad" } );
					Tweener.addTween( childsBack[ i ], { alpha: this.alphaFond, time: .5, transition: "easeInOutQuad" } );
				}
			}
			testTween = false;
				
			i = 0;
		}
		
		// PUBLIC
		
		/**
		 * Initialisation du loader.
		 * @param	url			: Url du fichier, String.
		 * @param	font		: Nom de la Font, Class.
		 * @param	size		: Taille du texte, Number.
		 * @param	color		: Couleur, uint.
		 */
		public function initialize( url:String, font:Class, size:Number = 12, color:uint = 0xffffff, alphaFond:Number = .4 ):void
		{
			this.font = font;
			this.size = size;
			this.url = url;
			this.alphaFond = alphaFond;
			
			for ( i; i < 3; i++ )
			{
				txt = new DynamicText3D( font );
				txt.size = size;
				txt.color = color;
				txt.x = i * font.__widths[ "0" ] * size / 100;
				txt.text = numbers[ i ];
				cntFront.addChild( txt );
				
				txt = new DynamicText3D( font );
				txt.size = size;
				txt.color = color;
				txt.x = i * font.__widths[ "0" ] * size / 100;
				txt.text = numbers[ i ];
				txt.alpha = alphaFond;
				cntBack.addChild( txt );
			}
			childsFront = UDis.getChildren( cntFront );
			childsBack = UDis.getChildren( cntBack );
			
			txt = null;
			i = 0;
			
			if ( lueur.visible == false ) lueur.visible = true;
			lueur.graphics.beginFill( color, alphaFond );
			lueur.graphics.drawRect( -10, getHeight()/2, getWidth() + 20, getHeight() / 4 );
			lueur.graphics.endFill();
			
			var filters:Array = [ new BlurFilter( 7, 7, 3 ) ];
			lueur.filters = filters;
		}
		
		/**
		 * Méthode permettant de lancer le chargement.
		 */
		public function load():void
		{
			request.url = url;
			loader.load( request );
			
			Tweener.addTween( this, { alpha: .9, time: .5, transition: "easeInOutQuad" } );
		}
		
		/**
		 * Méthode permettant de clean et réinitialiser le loader.
		 */
		public function clean():void
		{	
			Tweener.removeTweens( this );
			
			childsFront = [];
			childsBack = [];
			numbers = [ 0, 0, 0 ];
			txt = null;
			i = 0;
			dixaine = 0;
			centaine = 0;
			request = new URLRequest();
			loader = new Loader();
		}

		
		// GETTERS & SETTERS
		
		public function getWidth():Number
		{
			return font.__widths[ "0" ] * (size / 100) * 3;
		}
		
		public function getHeight():Number
		{
			return font.__heights * (size / 100);
		}
		
	}
	
}