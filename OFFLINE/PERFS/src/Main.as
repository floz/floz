package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			stage.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick( e:Event ):void
		{
			trace( "Main.onClick > e : " + e );
			//var a:Array = [];
			//while (a.length < 1000) a.push( "toto" );
			var test:Number = 2000;
			
			
			var debut:Number = 0;
			var compteur:int;
			var j:int;
			//var n:int = a.length;
			for ( var i:int; i < 100000; i++ )
			{
				debut = getTimer();
				for ( j = 0; j < 100; j++ )
				{
					test >> 1;
				}
				compteur += getTimer() - debut;
			}
			trace ( compteur );
		}
		
	}
	
}