/*** Written by :* @author Floz* www.floz.fr || www.minuit4.fr*/package fr.minuit4.tools.musicPlayer.core.views.playlist{	import fr.minuit4.tools.musicPlayer.core.managers.MusicManager;	import flash.display.Sprite;	import flash.events.Event;	import flash.text.TextField;	public class AbstractPlaylistItem extends Sprite	{			// - PRIVATE VARIABLES -----------------------------------------------------------				private var _musicManager:MusicManager;				private var _titleField:TextField;		private var _artistField:TextField;				// - PUBLIC VARIABLES ------------------------------------------------------------				// - CONSTRUCTOR -----------------------------------------------------------------				public function AbstractPlaylistItem()		{			_musicManager = MusicManager.getInstance();			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );		}				// - EVENTS HANDLERS -------------------------------------------------------------				private function onRemovedFromStage( e:Event ):void		{			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );		}		private function onAddedToStage( e:Event ):void		{			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true );		}				// - PRIVATE METHODS -------------------------------------------------------------				// - PUBLIC METHODS --------------------------------------------------------------				public function update( idx:int ):void		{			var song:Object = _musicManager.getSong( idx );			if( _titleField )				_titleField.text = song.title;			if( _artistField )				_artistField.text = song.artist;		}		// - GETTERS & SETTERS -----------------------------------------------------------				public function set titleField( value:TextField ):void		{			_titleField = value;		}				public function set artistField( value:TextField ):void		{			_artistField = value;		}		}	}