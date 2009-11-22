package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class Main extends Sprite 
	{
		private var phase:int;
		private var event:Event = new Event( Event.COMPLETE );
		private var array:/*Class2*/Array = [];
		
		public function Main():void 
		{
			createClassListeners();
			createClassManually();
			
			stage.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick( e:Event ):void
		{
			var f:Function;
			if ( phase == 0 ) 
			{
				f = ppi;
				trace( "addEventListener" );
			}
			else if ( phase == 1 )
			{
				f = ipp;
				trace( "Update manually" );
			}					
			
			var debut:Number = 0;
			var compteur:int;
			for ( var i:int; i < 10000; i++ )
			{
				debut = getTimer();
				f();
				compteur += getTimer() - debut;
			}
			trace ( compteur );
			
			phase = phase == 1 ? phase = 0 : phase + 1;
		}
		
		private function createClassListeners():void
		{
			for ( var i:int; i < 1000; ++i )
				addChild( new Class1() );
		}
		
		private function createClassManually():void
		{
			for ( var i:int; i < 1000; ++i )
				array.push( addChild( new Class2() ) as Class2 );
		}
		
		private function ppi():void
		{
			dispatchEvent( event );
		}
		
		private function ipp():void
		{
			var l:int = array.length;
			while ( --l > -1 )
				array[ l ].update();
		}
		
	}
	
}