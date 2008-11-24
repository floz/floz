
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	public class Engine extends MovieClip 
	{
		private var _width:Number;
		private var _height:Number;
		
		private var _view:BasicView;
		
		private var _listInfos:Array; // { name:String, tooltip:String, screenshot:String };
		private var _slides:Array;
		
		private var _rendering:Boolean;
		private var _index:int;
		
		public function Engine( width:Number, heigh:Number ) 
		{
			_width = width;
			_height = heigh;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			_view = new BasicView( _width, _height, false, true );
			_view.camera.fov = 30;
			
			addChild( _view );
		}
		
		private function onFrame(e:Event):void 
		{
			_view.singleRender();
		}
		
		// PRIVATE
		
		private function arrange():void
		{
			
		}
		
		// PUBLIC
		
		public function init( listInfos:Array, intro:Boolean = false ):void
		{
			_listInfos = listInfos;
			
			var p:Plane;
			_slides = [];
			
			var i:int;
			var n:int = _listInfos.length;
			for ( i; i < n; i++ )
			{
				p = new Plane();
				p.name = _listInfos[ i ].name;
				
				_slides.push( p );
			}
		}
		
		public function startRender():void
		{
			if ( _rendering ) return;
			_rendering = true;
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		public function stopRender():void
		{
			if ( !_rendering ) return;
			_rendering = false;
		}
		
		// GETTERS & SETTERS
		
		public function get rendering():Boolean { return _rendering; }
		
		public function get index():int { return _index; }
		
		public function set index( value:int ):void 
		{
			if ( _index < 0 || _index > _slides.length ) return;
			
			_index = value;
			
			arrange();
		}
		
	}
	
}