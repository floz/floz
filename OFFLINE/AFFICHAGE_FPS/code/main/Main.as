package main 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import utils.fps.FPS;
	import flash.system.System;
	
	public class Main extends MovieClip
	{
		
		public function Main() 
		{
			addChild( new FPS() );
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onFrame(e:Event):void 
		{
			if ( numChildren < 35000 )
			{
				for ( var i:int; i < 100; i++ )
				{
					var mc:MovieClip = new MovieClip();
					addChild( mc );
				}
			}
		}
		
	}
	
}