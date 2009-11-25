
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
	import com.greensock.TweenMax;
	import emagicien.fluidSnake.FluidSnake;
	import emagicien.teams.Teams;
	import emagicien.teams.TeamsEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import fr.minuit4.utils.debug.FPS;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _isActive:Boolean;
		private var _balcony:Balcony_FC;
		private var _cntColorfull:Sprite;
		private var _colorfullBackground:ColorfullBackground;
		private var _mask:MaskBarriers_FC;
		private var _fluidSnake:FluidSnake;
		
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
			addEventListener( Event.ENTER_FRAME, enterFrameHandler, false, 0, true );
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			if ( !_isActive && parent.getChildIndex( this ) == int( parent.numChildren - 1 ) )
			{
				_isActive = true;
				onActivate();
			}
			
			if ( _isActive && parent.getChildIndex( this ) != int( parent.numChildren - 1 ) )
			{
				_isActive = false;
				onDeactivate();
			}
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			_fluidSnake.goTo( stage.mouseX, stage.mouseY );
		}
		
		private function teamEncounterHandler(e:TeamsEvent):void 
		{
		}
		
		private function pathEndedHandler(e:Event):void 
		{
			_fluidSnake.goTo( Math.random() * Teams.TEAMS_ZONE.width + Teams.TEAMS_ZONE.x,
							Math.random() * Teams.TEAMS_ZONE.height + Teams.TEAMS_ZONE.y );
			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			if ( stage )
			{
				Config.STANDALONE = true;
				onStandAlone();
			}
			else addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
			
			_balcony = new Balcony_FC();
			_balcony.x = 627;
			_balcony.y = 734;
			addChild( _balcony );
			
			createColorfullBackground();
			createFluidSnake();
			
			show();
			
			addEventListener( MouseEvent.CLICK, clickHandler, false, 0, true );
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
		
		private function createFluidSnake():void
		{
			_fluidSnake = new FluidSnake();
			_fluidSnake.initAt( Teams.TEAM12.x, Teams.TEAM12.y );
			_fluidSnake.addEventListener( TeamsEvent.TEAM_ENCOUNTER, teamEncounterHandler, false, 0, true );
			_fluidSnake.addEventListener( FluidSnake.PATH_ENDED, pathEndedHandler, false, 0, true );
			addChild( _fluidSnake );
			
			_fluidSnake.mouseChildren = 
			_fluidSnake.mouseEnabled = false;
		}
		
		private function onStandAlone():void
		{
			var guide:Guide_FC = new Guide_FC();
			addChild( guide );
			
			addChild( new FPS() );
		}
		
		private function onActivate():void
		{
			TweenMax.killTweensOf( _mask );
			
			if ( !_cntColorfull.numChildren )
			{
				_cntColorfull.addChild( _colorfullBackground );
				_cntColorfull.addChild( _mask );
			}
			show();
		}
		
		private function onDeactivate():void
		{
			hide();
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
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}