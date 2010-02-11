package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class Main extends Sprite 
	{
		private var phase:int;
		private var event:Event = new Event( Event.COMPLETE );
		private var array:/*Class2*/Array = [];
		private var _a:Array = [];
		
		private var p1:Point = new Point( 234.55, 21 );
		private var p2:Point = new Point( 132.1, 98.3 );
		
		public function Main():void 
		{			
			_a.push( false );
			_a.push( true );
			_a.push( true );
			_a.push( false );
			_a.push( false );
			_a.push( true );
			_a.push( false );
			_a.push( true );
			_a.push( true );
			_a.push( true );
			_a.push( true );
			_a.push( false );
			_a.push( false );
			_a.push( false );
			_a.push( true );
			_a.push( true );
			_a.push( true );
			_a.push( true );
			_a.push( true );
			_a.push( true );
			_a.push( true );
			_a.push( true );
			
			stage.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick( e:Event ):void
		{
			var f:Function;
			if ( phase == 0 ) 
			{
				f = ppi;
				trace( "continue" );
			}
			else if ( phase == 1 )
			{
				f = ipp;
				trace( "tri" );
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
		
		private function ppi():void
		{
			var cost:int;
			var n:int = _a.length;
			for ( var i:int; i < n; ++i )
			{
				if ( _a[ i ] == false ) continue;
				++cost;
			}
		}
		
		private function ipp():void
		{
			var a:Array = tri();
			
			var cost:int;
			var n:int = a.length;
			for ( var i:int; i < n; ++i )
				++cost;
		}
		
		private function tri():Array
		{
			var a:Array = [];
			var n:int = _a.length;
			for ( var i:int; i < n; ++i )
				if ( _a[ i ] ) a[ i ] = _a[ i ];
			
			return a;
		}
	}
	
}