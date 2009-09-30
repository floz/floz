/*** Written by :* @author Floz* www.floz.fr || www.minuit4.fr*/package fr.minuit4.tools.musicPlayer.views{	import fr.minuit4.tools.musicPlayer.core.views.device.APlayButton;	import fr.minuit4.tools.musicPlayer.manager.VisualManager;	import flash.display.Graphics;	import flash.display.Shape;	public class PlayButton extends APlayButton	{			// - PRIVATE VARIABLES -----------------------------------------------------------				private var _visualManager:VisualManager = VisualManager.getInstance();				// - PUBLIC VARIABLES ------------------------------------------------------------				// - CONSTRUCTOR -----------------------------------------------------------------				public function PlayButton()		{			drawBackground();			drawPlayIcon();		}				// - EVENTS HANDLERS -------------------------------------------------------------				// - PRIVATE METHODS -------------------------------------------------------------				private function drawBackground():void		{			var background:Shape = new Shape();			addChild( background );						var g:Graphics = background.graphics;			g.lineStyle( 0, 0, 1, true );			g.beginFill( _visualManager.getBackgroundElementColor() );			g.drawRect( 0, 0, 16, 16 );			g.endFill();		}				private function drawPlayIcon():void		{			var playIcon:Shape = new Shape();			playIcon.x = 5;			playIcon.y = 3;			addChild( playIcon );						var g:Graphics = playIcon.graphics;			g.lineStyle( 0, 0, 1, true );			g.beginFill( _visualManager.getElementColor() );			g.moveTo( 0, 0 );			g.lineTo( 8, 5 );			g.lineTo( 0, 10 );			g.endFill();		}				// - PUBLIC METHODS --------------------------------------------------------------				// - GETTERS & SETTERS -----------------------------------------------------------		}	}