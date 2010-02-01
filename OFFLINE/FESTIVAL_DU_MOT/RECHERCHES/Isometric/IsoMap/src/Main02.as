
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import fr.floz.isometric.geom.IsoMath;
	import fr.floz.isometric.geom.Point3D;
	import maps.builders.Map2DBuilder;
	import maps.builders.MapIsoBuilder;
	import maps.IMap;
	import maps.Map;
	
	public class Main02 extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _map:/*Array*/Array = [ [ 0, 0, 0, 1, 0 ],
											[ 0, 1, 0, 0, 1 ],
											[ 0, 1, 1, 0, 1 ],
											[ 0, 1, 0, 0, 0 ],
											[ 1, 0, 0, 0, 0 ] ];
		
		private var _normalMap:Map;
		private var _isoMap:Map;
		
		private var _normalPanel:InfoPanel;
		private var _isoPanel:InfoPanel;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main02() 
		{
			_normalMap = new Map( new Map2DBuilder(), _map );
			_normalMap.x = _normalMap.width * .5;
			_normalMap.y = ( stage.stageHeight - _normalMap.height ) * .5;
			addChild( _normalMap );
			
			_isoMap = new Map( new MapIsoBuilder(), _map );
			_isoMap.x = stage.stageWidth - _isoMap.width * .5 - _isoMap.width * .25;
			_isoMap.y = ( stage.stageHeight - _isoMap.height ) * .5;
			addChild( _isoMap );
			
			initPanels();
			
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function enterFrameHandler(e:Event):void 
		{
			refresh2DPanel();
			refreshIsoPanel();			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initPanels():void
		{
			_normalPanel = new InfoPanel();
			_normalPanel.x = _normalMap.x;
			_normalPanel.y = _normalMap.y + _normalMap.height + 20;
			addChild( _normalPanel );
			
			_isoPanel = new InfoPanel();
			_isoPanel.x = _isoMap.x - _isoMap.width * .5;
			_isoPanel.y = _isoMap.y + _isoMap.height + 20;
			addChild( _isoPanel );
			
			_normalPanel.title = "2D infos :";
			_isoPanel.title = "Iso infos :";
		}
		
		private function refresh2DPanel():void
		{
			var mx:Number = _normalMap.mouseX;
			var my:Number = _normalMap.mouseY;
			
			_normalPanel.infos = "x : " + ( mx >> 5 );
			_normalPanel.infos += "\ny : " + ( my >> 5 );
			_normalPanel.infos += "\n\nmouseX : " + mx;
			_normalPanel.infos += "\nmouseY : " + my;
			
			//trace( _normalMap.getTile( mx >> 5, my >> 5 ) );
		}
		
		private function refreshIsoPanel():void
		{
			var p:Point3D = IsoMath.screenToIso( new Point3D( _isoMap.mouseX, _isoMap.mouseY ) );
			
			_isoPanel.infos = "x : " + ( p.x >> 5 );
			_isoPanel.infos += "\ny : " + ( p.y >> 5 );
			_isoPanel.infos += "\n\nmouseX : " + _isoMap.mouseX;
			_isoPanel.infos += "\nmouseY : " + _isoMap.mouseY;
			
			//trace( _isoMap.getTile( p.x >> 5, p.y >> 5 ) );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}