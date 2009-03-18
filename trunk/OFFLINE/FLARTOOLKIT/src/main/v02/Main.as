
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main.v02
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.objects.primitives.Plane;
	
	public class Main extends PV3DARApp
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _plane:Plane;
		private var _cube:Cube;
		private var _inited:Boolean;
		private var _aProjectiles:Array;
		private var _light:PointLight3D;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			this.init( "camera_para.dat", "floz1.pat" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onTimer(e:TimerEvent):void 
		{
			var projectile:Projectile = new Projectile( 40, _light );
			projectile.zVel = Math.random() * 10 + 3;
			_baseNode.addChild( projectile );
			
			_aProjectiles.push( projectile );
			
			if ( !_inited )
			{
				_inited = true;
				addEventListener( Event.ENTER_FRAME, onFrame );
			}
		}
		
		private function onFrame(e:Event):void 
		{
			if ( !this._running )
				return;
			
			var p:Projectile;
			var n:int = _aProjectiles.length;
			for ( var i:int; i < n; i++ )
				Projectile( _aProjectiles[ i ] ).move();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected override function onInit():void
		{
			super.onInit();			
			this.mirror = true;
			
			_aProjectiles = [];
			
			_light = new PointLight3D();
			_light.x = 0;
			_light.y = 1000;
			_light.z = -1000;
			
			_baseNode.addChild( new Body() );
			
			var timer:Timer = new Timer( 500 );
			timer.addEventListener( TimerEvent.TIMER, onTimer );
			//timer.start();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		// - END CLASS -------------------------------------------------------------------
		
	}
	
}