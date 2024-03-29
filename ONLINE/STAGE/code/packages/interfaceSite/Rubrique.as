﻿package interfaceSite 
{
	import five3D.display.DynamicText3D;
	import five3D.display.Sprite3D;
	import five3D.typography.Helvetica65Medium;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import interfaceSite.Feuille;
	import main.Main;
	
	public class Rubrique extends Feuille
	{
		private var rub = rub;
		
		private var main:main.Main;
		private var timer:Timer;
		
		public function Rubrique( rub:int ) 
		{
			this.rub = rub;
			super();
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			timer.removeEventListener( TimerEvent.TIMER_COMPLETE, create );
			timer = null;
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			main = getAncestor( this, Main ) as Main;
			
			timer = new Timer( 1500, 1 );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, create );
			timer.start();
		}
		
		// PRIVATE
		
		private function create( e:TimerEvent ):void
		{	
			var s:String = main.text[ rub ];
			var txt:Array = s.split( "/" );

			var t:DynamicText3D;
			var i:int;
			var n:int = txt.length;
			for ( i; i < n; i++ )
			{
				if ( txt[ i ] != "" )
				{
					t = new DynamicText3D( Helvetica65Medium );
					t.size = 24;
					t.color = 0xffffff;
					t.text = txt[ i ];
					t.y = 30 * i;
					
					addChild( t );
				}
			}			
			
		}
		
		private function getAncestor( child:DisplayObject, type:* ):DisplayObject
		{
			var c:DisplayObject = child;
			
			while ( c.parent )
			{
				if ( c.parent is type ) return c.parent;
				c = c.parent;
			}
			
			return null;
		}
		
	}
	
}