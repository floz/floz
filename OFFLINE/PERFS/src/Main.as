package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
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
			var d:Dictionary = new Dictionary();
			while (a.length < 10) a.push( "toto" );
			
			var debut:Number = 0;
			var compteur:int;
			var j:int;
			var n:int = a.length;
			for ( var i:int; i < 10000; i++ )
			{
				debut = getTimer();
				for ( j = 0; j < 1000; j++ )
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