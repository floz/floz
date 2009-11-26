
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package emagicien.fluidSnake 
{
	import assets.Degrades_FC;
	import com.greensock.TweenMax;
	import emagicien.misc.Dummy;
	import emagicien.teams.Teams;
	import emagicien.teams.TeamsEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import team12.Config;
	
	public class FluidSnake extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const CMF:ColorMatrixFilter = new ColorMatrixFilter(  [ 1, 0, 0, 0, 0,
																		0, 1, 0, 0, 0,
																		0, 0, 1, 0, 0,
																		0, 0, 0, .9995, 0 ] );
		
		private const ENDED_EVENT:Event = new Event( FluidSnake.PATH_ENDED );
		private const ANGLE:Number = 60;
		private const COLOR_SPEED:int = 2;
		private const POINT:Point = new Point();		
		private const CONFIG:Config = Config.getInstance();
		
		private var _shape:Shape;
		private var _degrades:Degrades_FC;
		private var _colors:Vector.<uint>;
		private var _colorsCount:int;
		private var _oldDest:Point;
		private var _lastBezier:Point;
		
		private var _link1:Point;
		private var _link2:Point;
		private var _dest:Point;
		private var _px:Number;
		private var _py:Number;
		private var _dx:Number;
		private var _dy:Number;
		
		private var _graphics:Graphics;
		private var _rect:Rectangle;
		
		private var _canvas:BitmapData;
		
		private var _initialized:Boolean;
		
		private var _colorIdx:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const PATH_ENDED:String = "path_ended";
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function FluidSnake()
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			_canvas = new BitmapData( stage.stageWidth, stage.stageHeight, true, 0x00 );
			var b:Bitmap = new Bitmap( _canvas, PixelSnapping.AUTO, true );
			addChild( b );
			
			CONFIG.addEventListener( Config.FOCUS_OUT, focusOutHandler, false, 0, true );
		}
		
		private function focusOutHandler(e:Event):void 
		{
			TweenMax.killTweensOf( _dest );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_shape = new Shape();
			_degrades = new Degrades_FC( 0, 0 );
			precalculateColors();
			
			_oldDest = new Point();
			_lastBezier = new Point();
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function precalculateColors():void
		{
			_colorsCount = _degrades.width / COLOR_SPEED;
			_colors = new Vector.<uint>( _colorsCount, true );
			for ( var i:int; i < _colorsCount; ++i )
				_colors[ i ] = _degrades.getPixel( i * COLOR_SPEED, 1 );
		}
		
		private function onUpdate():void
		{
			drawPart();
			
			var rect:Rectangle = Teams.getTeamRectangle( _dest );
			var bool:int = int( Math.random() * 2 );
			if ( rect )
			{		
				if ( rect == _rect || !bool ) 
				{
					render();
					return;
				}
				
				var teamEvent:TeamsEvent = new TeamsEvent( TeamsEvent.TEAM_ENCOUNTER );
				teamEvent.teamRect = rect;
				dispatchEvent( teamEvent ); 
			}
			//else render();
			render();
			
			_rect = rect;
		}
		
		private function drawPart():void
		{
			var dx:Number = _dest.x - _oldDest.x;
			var dy:Number = _dest.y - _oldDest.y;
			var diametre:Number = Math.sqrt( dx * dx + dy * dy );
			var rayon:Number = diametre * .5;
			
			var o:Point = new Point( _oldDest.x + dx * .5, _oldDest.y + dy * .5 );
			
			var baseAngle:Number = Math.atan2( dy, dx );
			
			//rayon += Math.random() * 20;
			var posX:Number = Math.cos( ANGLE * Math.PI / 180 ) * rayon;
			var posY:Number = Math.sin( ANGLE * Math.PI / 180 ) * rayon;
			
			var a1:Number = Math.atan2( -posY, -posX );
			var a2:Number = Math.atan2( posY, -posX );
			var a3:Number = Math.atan2( posY, posX );
			var a4:Number = Math.atan2( -posY, posX );
			
			if ( !_link1 )
			{
				_link1 = new Point();
				_link2 = new Point();
				
				_link2.x = o.x + rayon * Math.cos( a1 + baseAngle );
				_link2.y = o.y + rayon * Math.sin( a1 + baseAngle );
				
				_link1.x = o.x + rayon * Math.cos( a2 + baseAngle );
				_link1.y = o.y + rayon * Math.cos( a2 + baseAngle );
			}
			
			++_colorIdx;
			if ( _colorIdx >= _colorsCount ) _colorIdx = 0;
			
			_graphics.clear();
			//_graphics.lineStyle( 1, _colors[ _colorIdx ] );
			_graphics.beginFill( _colors[ _colorIdx ] );				
			_graphics.moveTo( _link2.x, _link2.y );
			_graphics.lineTo( _link1.x, _link1.y );
			_graphics.lineTo( o.x + rayon * Math.cos( a3 + baseAngle ), o.y + rayon * Math.sin( a3 + baseAngle ) );
			_graphics.lineTo( o.x + rayon * Math.cos( a4 + baseAngle ), o.y + rayon * Math.sin( a4 + baseAngle ) );
			_graphics.lineTo( _link2.x, _link2.y );
			_graphics.endFill();
			
			_link1.x = o.x + rayon * Math.cos( a3 + baseAngle );
			_link1.y = o.y + rayon * Math.sin( a3 + baseAngle );
			
			_link2.x = o.x + rayon * Math.cos( a4 + baseAngle );
			_link2.y = o.y + rayon * Math.sin( a4 + baseAngle );
			
			_oldDest.x = _dest.x;
			_oldDest.y = _dest.y;
		}
		
		private function render():void
		{
			//_canvas.draw( _shape );
			_canvas.draw( _shape, null, null, BlendMode.OVERLAY ); // TODO: Check it
			//_canvas.applyFilter( _canvas, _canvas.rect, POINT, CMF );
		}
		
		private function onComplete():void
		{
			dispatchEvent( ENDED_EVENT );
		}
		
		private function getRandomX():Number { return Teams.TEAMS_ZONE.x + Math.random() * Teams.TEAMS_ZONE.width; }
		private function getRandomY():Number { return Teams.TEAMS_ZONE.y + Math.random() * Teams.TEAMS_ZONE.height; }
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function initAt( px:Number, py:Number ):void
		{
			this._px = px;
			this._py = py;
			
			_oldDest = new Point( px, py );
			_dest = new Point( _px, _py );
			_graphics = _shape.graphics;
			_graphics.lineStyle( 1, 0xff00ff );
			_graphics.moveTo( _px, _py );
		}
		
		public function goTo( px:Number, py:Number ):void
		{
			if ( !_initialized )
			{
				this._dx = px;
				this._dy = py;
				var mx:Number = ( _dx + _px ) * .5;
				var my:Number = ( _dy + _py ) * .5;
				
				var a:Number = Math.atan2( _dy - _py, _dx - _px );
				mx = mx + 100 * Math.cos( a + 90 * Math.PI / 180 );
				my = my + 100 * Math.sin( a + 90 * Math.PI / 180 );
				
				TweenMax.to( _dest, 2, { bezier: [ { x: mx, y: my }, { x: _dx, y: _dy } ], onUpdate: onUpdate, onComplete: onComplete } );
				
				_lastBezier.x = mx;
				_lastBezier.y = my;
				
				_initialized = true;
			}
			else
			{
				var newBezier:Point = CurvesBeziers.getNextBezier( new Point( _dx, _dy ), _lastBezier );
				var lastBezier:Point = new Point( getRandomX(), getRandomY() );
				TweenMax.to( _dest, 2, { bezier: [ { x: newBezier.x, y: newBezier.y }, 
										{ x: getRandomX(), y: getRandomY() },
										{ x: lastBezier.x, y: lastBezier.y },
										{ x: px, y: py } ], 
										onUpdate: onUpdate,
										onComplete: onComplete } );
				
				_dx = px;
				_dy = py;
				_lastBezier = lastBezier;
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}