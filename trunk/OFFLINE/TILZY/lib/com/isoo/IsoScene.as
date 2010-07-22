package com.isoo 
{
	import aze.motion.eaze;
	import com.isoo.algo.Sort;
	import com.isoo.events.IsooEvent;
	import com.isoo.geom.Point3D;
	import com.isoo.map.Grid;
	import com.isoo.map.Layer;
	import com.isoo.map.Map;
	import com.isoo.map.Tile;
	import com.isoo.objects.IsoObject;
	import com.isoo.utils.IsoUtils;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * 
	 * @author David Ronai
	 */
	public class IsoScene extends Sprite
	{
		
		public static const FLOOR_LAYER:int	 		= 0x000000;
		public static const CASE_LAYER:int			= 0x000001;
		public static const OBJECT_LAYER:int		= 0x000002;
		public static const INFO_LAYER:int			= 0x000004;
		public static const FOREGROUND_LAYER:int	= 0x000008;
		public static const DEBUG_LAYER:int			= 0x000010;
		
		public static const allLayer:Array = [FLOOR_LAYER, CASE_LAYER, OBJECT_LAYER, INFO_LAYER, FOREGROUND_LAYER,  DEBUG_LAYER];
		
		protected var _map:Map;		
		
		protected var layers:Sprite;
		
		protected var _floorLayer:Layer;
		protected var _caseLayer:Layer;
		protected var _objectLayer:Layer;
		protected var _infoLayer:Layer;
		protected var _foregroundLayer:Layer;
		protected var _debugLayer:Layer;
			
		private var _lastY:int;
		private var _lastX:int;
		private var grid:Grid;
		private var _mask:Shape;
		private var _optimized:Boolean;
		private var focusTarget:IsoObject;
		private var cameraMaxX:int;
		private var cameraMinX:int;
		
		public function IsoScene()
		{			
			lastY = -1;
			lastX = -1;
			
			addChild( layers =  new Sprite() );
			layers.addChild( grid = new Grid() );
			layers.addChild( _floorLayer = new Layer());
			layers.addChild( _caseLayer = new Layer() );
			layers.addChild( _objectLayer = new Layer() );
			layers.addChild( _infoLayer = new Layer() );
			layers.addChild( _foregroundLayer = new Layer() );
			layers.addChild( _debugLayer = new Layer() );
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			stage.addEventListener(Event.RESIZE, onResize);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveStage);
			onResize( null );
		}
		
		private function onRemoveStage(e:Event):void 
		{
			stage.removeEventListener(Event.RESIZE, onResize);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveStage);
		}
		
		private function onResize(e:Event):void 
		{
			calcCameraZone();
		}
		
		private function calcCameraZone():void
		{
			if( stage ){
				cameraMaxX = Math.max(100, (stage.stageWidth-width) * .5 +50);
				cameraMinX = Math.max( -stage.stageWidth * .5 - 150, (stage.stageWidth)  - width -150);
			}
		}
			
		private function onMouseDown(e:MouseEvent):void 
		{
			onChangeCase(e);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			onChangeCase(e);
		}
		
		private function onChangeCase(e:MouseEvent):void
		{
			var p:Point3D
			if ( e.target is IsoObject ) 
			{
				var o:IsoObject = e.target as IsoObject;
				var realX:Number = o.x + e.localX-Tile.Width*.5;
				var realY:Number = o.y + e.localY;
				p = IsoUtils.screenToIso(realX  , realY);
			}
			else{
				p = IsoUtils.screenToIso(e.localX , e.localY);
			}
			if (p.x != lastX || p.y != lastY ) 
			{
				lastX = p.x;
				lastY = p.y;
				if ( p.x >= 0 && p.y >= 0 && p.x < map.width && p.y < map.height )
					dispatchEvent(new IsooEvent( p.x, p.y, IsooEvent.CLICK ));
			}
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{			
			lastX = -1;
			lastY = -1;
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		public function size( width:uint, height:uint ):void
		{
			map = new Map(width, height);
		}
		
		public function view( width:uint, height:uint ):void
		{
			var bounds:Rectangle = getBounds(this);
		}
		
		public function cameraFocus( x:int, y:int, duration:Number ):void
		{
			if ( focusTarget )
				focusTarget = null;
			
			removeEventListener(Event.ENTER_FRAME, focusTargetHandler);
				
			var finalX:int = - x;
			var finalY:int = stage.stageHeight * .5 - y;
			
			eaze( this ).to(duration, { x : finalX, y: finalY } );
		}
		
		public function addIso( o:IsoObject, layer:int = IsoScene.OBJECT_LAYER ):void
		{	
			o.registerToScene( this );
			getLayer( layer ).addObject( o );		
		}
		
		public function removeIso( o:IsoObject, layer:int = IsoScene.OBJECT_LAYER ):void
		{
			o.unregisterFromScene();
			getLayer( layer ).removeObject( o );
		}
		
		public function getLayer( layer:int = IsoScene.OBJECT_LAYER ):Layer
		{
			switch( layer )
			{
				case FLOOR_LAYER :
					return _floorLayer;
				case CASE_LAYER :
					return _caseLayer;
				default :
				case OBJECT_LAYER :
					return _objectLayer;
				case INFO_LAYER :
					return _infoLayer;
				case FOREGROUND_LAYER :
					return _foregroundLayer;
				case DEBUG_LAYER :
					return _debugLayer;
			}
		}
		
		public function render(optimized:Boolean = false):void
		{
			_optimized = optimized;
			if( map )
				grid.draw(map, optimized);
			
			calcCameraZone();
			view(0,0);
		}
		
		public function hideGrid():void
		{
			grid.hideTile();
		}
		
		/**
		 * Zoom
		 */
		public function get zoom():Number { return scaleX; }		
		public function set zoom(value:Number):void
		{
			scaleX = scaleY = value;
		}
		
		public function focusOn( o:IsoObject = null):void {
			if ( o == null ) {
				focusTarget = null;
				removeEventListener(Event.ENTER_FRAME, focusTargetHandler);
			} else {
				focusTarget = o;
				addEventListener(Event.ENTER_FRAME, focusTargetHandler);
			}
		}
		
		private function focusTargetHandler(e:Event):void 
		{
			if ( focusTarget == null ) {
				removeEventListener(Event.ENTER_FRAME, focusTargetHandler);
				return;
			}
			//calcCameraZone();
			var finalX:int = - focusTarget.x;
			var finalY:int = stage.stageHeight * .5 - focusTarget.y;
			
			if ( finalX > cameraMaxX )
				finalX = cameraMaxX;
			else if ( finalX < cameraMinX )
				finalX = cameraMinX;
			if ( finalY > 150 )
				finalY =  150
			else if ( finalY < -stage.stageHeight * .5 +150) 
				finalY = -stage.stageHeight * .5 +150
			
			eaze( this ).to(.3, { x : finalX, y: finalY } );
		}
		
		public function get map():Map { return _map; }		
		public function set map(value:Map):void 
		{
			if ( value == null )
				return;
				
			_map = value;
			grid.drawBackgound(map);
			render(_optimized);
			
			layers.x = map.height * Tile.Width * .5;
			
			calcCameraZone();
		}
		
		override public function get width():Number { return grid.width; }
		override public function get height():Number { return grid.height; }

		public function dispose():void
		{
	
			layers.removeChild( grid );
			layers.removeChild( _floorLayer );
			layers.removeChild( _caseLayer );
			layers.removeChild( _objectLayer );
			layers.removeChild( _infoLayer );
			layers.removeChild( _foregroundLayer );
			layers.removeChild( _debugLayer );
			
			_floorLayer.dispose();
			_caseLayer.dispose();
			_objectLayer.dispose();
			_infoLayer.dispose();
			_foregroundLayer.dispose();
			_debugLayer.dispose();
			grid.dispose();
			
			removeChild( layers );	
			layers = null;
			
			_floorLayer = null;
			_caseLayer = null;
			_objectLayer = null;
			_infoLayer = null;
			_foregroundLayer = null;
			_debugLayer = null;
			
			_mask = null;
			_map = null;		
			grid = null;
			
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		public function getObjectTo(x:int, y:int, layer:int = OBJECT_LAYER):IsoObject
		{
			return getLayer( layer ).getObjectTo( x, y );			
		}
		
		public function getAllObjects():Vector.<IsoObject>
		{
			var objects:Vector.<IsoObject> =  new Vector.<IsoObject>();
			
			for ( var i:int = 0; i < allLayer.length; i++ ) {
				objects = objects.concat( getLayer( allLayer[i] ).getAllObjects() );
			}
			
			return objects;
		}
		
		public function activeShadow():void
		{
			grid.activeShadow();
		}
		
		public function removeAllIso():void
		{
			for ( var i:int = 0; i < allLayer.length; i++ ) {
				getLayer( allLayer[i] ).removeAllIsoObject();
			}
		}
		
		public function get realWidth():Number { return super.width; }
		public function get realHeight():Number { return super.height; }
		
		public function get lastY():int { return _lastY; }
		
		public function set lastY(value:int):void 
		{
			_lastY = value;
		}
		
		public function get lastX():int { return _lastX; }
		
		public function set lastX(value:int):void 
		{
			_lastX = value;
		}
		
		public function get optimized():Boolean { return _optimized; }
		
		public function set optimized(value:Boolean):void 
		{
			_optimized = value;
		}
		
	}

}