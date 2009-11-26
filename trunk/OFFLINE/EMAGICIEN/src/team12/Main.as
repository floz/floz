
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package team12 
{
	import assets.Balcony_FC;
	import assets.Guide_FC;
	import assets.MaskBarriers_FC;
	import assets.MaskSnake_FC;
	import com.greensock.TweenMax;
	import emagicien.elements.Window;
	import emagicien.fluidSnake.FluidSnake;
	import emagicien.onomatopeias.Onomatopeias;
	import emagicien.teams.Teams;
	import emagicien.teams.TeamsEvent;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import fr.minuit4.utils.debug.FPS;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const CONFIG:Config = Config.getInstance();
		
		private var _isActive:Boolean;
		private var _balcony:Balcony_FC;
		
		private var _cntColorfull:Sprite;
		private var _colorfullBackground:ColorfullBackground;
		private var _mask:MaskBarriers_FC;
		
		private var _window:Window;
		
		private var _fluidSnake:FluidSnake;
		
		private var _onomatop:Onomatopeias;
		private var _lastRect:Rectangle;
		
		// LOL
		
		private var _isDeInitClick:Boolean;
		private var _main:DisplayObjectContainer;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			CONFIG.addEventListener( Config.FOCUS_IN, focusInHandler, false, 0, true );
			CONFIG.addEventListener( Config.FOCUS_OUT, focusOutHandler, false, 0, true );
		}
		
		private function clickInitHandler(e:MouseEvent):void 
		{
			if ( !_isDeInitClick )
			{
				_main = DisplayObjectContainer( root.parent.root );				
				_main.addEventListener( "DeInit", deInitHandler, false, 0, true );
				
				CONFIG.activate();
			}
			else _isDeInitClick = false;
		}
		
		private function deInitHandler(e:Event):void 
		{
			_isDeInitClick = true;
			_main.removeEventListener( "DeInit", deInitHandler );
			CONFIG.deactivate();
			
			TweenMax.delayedCall( .2, setFalse );
		}
		
		private function focusInHandler(e:Event):void 
		{
			TweenMax.killTweensOf( _mask );
			
			if ( !_cntColorfull.numChildren )
			{
				_cntColorfull.addChild( _colorfullBackground );
				_cntColorfull.addChild( _mask );
			}
			show();
			_window.explode();
			//moveSnake();
		}
		
		private function focusOutHandler(e:Event):void 
		{
			hide();
			
			_isDeInitClick = false;
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			CONFIG.activate();
		}
		
		private function teamEncounterHandler(e:TeamsEvent):void 
		{
			var rect:Rectangle = e.teamRect;
			if ( _lastRect == rect || rect == Teams.TEAM12 ) return;
			_onomatop.addOnomatopAt( new Point( rect.x, rect.y ) );
			_lastRect = rect;
		}
		
		private function pathEndedHandler(e:Event):void 
		{
			moveSnake();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			if ( stage )
			{
				Config.STANDALONE = true;
				onStandAlone();
			}
			else addEventListener( MouseEvent.CLICK, clickInitHandler, false, 0, true );
			
			createBalcony();
			createColorfullBackground();
			createWindow();
			createFluidSnake();
			createOnomatop();
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function createBalcony():void
		{
			_balcony = new Balcony_FC();
			_balcony.x = 627;
			_balcony.y = 734;
			addChild( _balcony );
		}
		
		private function createColorfullBackground():void
		{
			_cntColorfull = new Sprite();
			addChild( _cntColorfull );
			
			_colorfullBackground = new ColorfullBackground();
			_colorfullBackground.x = 59;
			_colorfullBackground.y = 242;
			_colorfullBackground.cacheAsBitmap = true;
			
			_mask = new MaskBarriers_FC();
			_mask.stop();
			_mask.x = 640;
			_mask.y = 512;
			_mask.cacheAsBitmap = true;
			
			_colorfullBackground.mouseChildren =
			_colorfullBackground.mouseEnabled = false;
			_mask.mouseChildren =
			_mask.mouseEnabled = false;
			
			_colorfullBackground.mask = _mask;
		}
		
		private function createWindow():void
		{
			_window = new Window();
			_window.x = 633;
			_window.y = 509;	
			addChild( _window );
		}
		
		private function createFluidSnake():void
		{
			_fluidSnake = new FluidSnake();
			_fluidSnake.initAt( Teams.TEAM12.x, Teams.TEAM12.y );
			_fluidSnake.addEventListener( TeamsEvent.TEAM_ENCOUNTER, teamEncounterHandler, false, 0, true );
			_fluidSnake.addEventListener( FluidSnake.PATH_ENDED, pathEndedHandler, false, 0, true );
			addChild( _fluidSnake );
			
			_fluidSnake.mouseChildren = 
			_fluidSnake.mouseEnabled = false;
			
			//_fluidSnake.blendMode = BlendMode.OVERLAY; // TODO: Check si je le mets ou non
			
			//_mask.cacheAsBitmap = true;
			//_fluidSnake.cacheAsBitmap = true;			
			
			var mask:MaskSnake_FC = new MaskSnake_FC();
			addChild( mask );
			
			_fluidSnake.mask = mask;
		}
		
		private function createOnomatop():void
		{
			_onomatop = new Onomatopeias();
			addChild( _onomatop );
			
			_onomatop.mouseChildren =
			_onomatop.mouseEnabled = false;
		}
		
		private function onStandAlone():void
		{
			var guide:Guide_FC = new Guide_FC();
			addChild( guide );
			
			addEventListener( MouseEvent.CLICK, clickHandler, false, 0, true );
			
			addChild( new FPS() );
		}
		
		private function show():void
		{
			TweenMax.to( _mask, 1, { frame: _mask.totalFrames } );
		}
		
		private function hide():void
		{
			TweenMax.to( _mask, 1, { frame: 0, onComplete: killColorfull } );
		}
		
		private function killColorfull():void
		{
			while ( _cntColorfull.numChildren ) _cntColorfull.removeChildAt( 0 );
		}
		
		private function moveSnake():void
		{
			_fluidSnake.goTo( Math.random() * Teams.TEAMS_ZONE.width + Teams.TEAMS_ZONE.x,
							Math.random() * Teams.TEAMS_ZONE.height + Teams.TEAMS_ZONE.y );	
		}
		
		private function setFalse():void { _isDeInitClick = false; }
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}