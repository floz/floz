/*** Written by :* @author Floz* www.floz.fr || www.minuit4.fr*/package fr.minuit4.tools.musicPlayer.core.views.playlist{	import fr.minuit4.tools.musicPlayer.core.events.MusicEvent;	import fr.minuit4.tools.musicPlayer.core.managers.MusicManager;	import flash.display.Shape;	import flash.display.Sprite;	import flash.events.Event;	public class PlaylistContainer extends Sprite	{			// - PRIVATE VARIABLES -----------------------------------------------------------				private var _musicManager:MusicManager;				private var _itemsContainer:Sprite;		private var _mask:Shape;				private var _itemClass:Class;				// - PUBLIC VARIABLES ------------------------------------------------------------				// - CONSTRUCTOR -----------------------------------------------------------------				public function PlaylistContainer()		{			_musicManager = MusicManager.getInstance();			_musicManager.addEventListener( MusicEvent.SONG_ADDED, onSongAdded, false, 0, true );						_itemsContainer = new Sprite();			addChild( _itemsContainer );						_mask = new Shape();			addChild( _mask );								addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );		}				// - EVENTS HANDLERS -------------------------------------------------------------				private function onRemovedFromStage( e:Event ):void		{			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );		}		private function onAddedToStage( e:Event ):void		{			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true );		}				private function onSongAdded( e:MusicEvent ):void		{			build();		}				// - PRIVATE METHODS -------------------------------------------------------------				private function build():void		{			while( _itemsContainer.numChildren ) _itemsContainer.removeChildAt( 0 );						var item:PlaylistItem;			var songs:Array = _musicManager.getSongs();			var i:int, n:int = songs.length;			for( ; i < n; ++i )			{				item = new _itemClass();				item.update( i );				_itemsContainer.addChild( item );			}		}				// - PUBLIC METHODS --------------------------------------------------------------				// - GETTERS & SETTERS -----------------------------------------------------------				public function set playlistItem( item:PlaylistItem ):void		{			_itemClass = item as Class;					}		}	}