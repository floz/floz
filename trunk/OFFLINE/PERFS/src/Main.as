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
			var a:Array = [];
			while (a.length < 10) a.push( "toto" );
			var test:Number = 2000;			
			
			var debut:Number = 0;
			var compteur:int;
			var j:int;
			var n:int = a.length;
			for ( var i:int; i < 10000; i++ )
			{
				debut = getTimer();
				for ( j = 0; j < 100; j++ )
				{
					for ( var k:int; k < n; k++ )
					{
						a[ k ];
					}
				}
				compteur += getTimer() - debut;
			}
			trace ( compteur );
		}
		
	}
	
}