/*** Written by :* @author Floz* www.floz.fr || www.minuit4.fr*/package fr.minuit4.core.commands{	import fr.minuit4.core.events.BatchEvent;	import fr.minuit4.core.interfaces.IIterator;	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.events.ProgressEvent;	public class Batch extends EventDispatcher implements ICommand, IIterator	{			// - PRIVATE VARIABLES -----------------------------------------------------------				private const _commandStartEvent:BatchEvent = new BatchEvent( BatchEvent.COMMAND_START );		private const _progressEvent:ProgressEvent = new ProgressEvent( ProgressEvent.PROGRESS );		private const _completeEvent:Event = new Event( Event.COMPLETE );		private var _aCommands:Array;		private var _currentIdx:int;		private var _commandsCount:int;		private var _locked:Boolean;				// - PUBLIC VARIABLES ------------------------------------------------------------				// - CONSTRUCTOR -----------------------------------------------------------------				public function Batch()		{			_aCommands = [];		}				// - EVENTS HANDLERS -------------------------------------------------------------				private function onCommandProgress( e:ProgressEvent ):void		{			var percent:Number = ( e.bytesLoaded / e.bytesTotal ) / _commandsCount;						_progressEvent.bytesLoaded = ( percent + _currentIdx / _commandsCount ) * 100;			_progressEvent.bytesTotal = 100;			dispatchEvent( _progressEvent );		}				private function onCommandComplete( e:Event ):void		{			++_currentIdx;						var command:ICommand = _aCommands.shift();			command.removeEventListener( ProgressEvent.PROGRESS, onCommandProgress );			command.removeEventListener( Event.COMPLETE, onCommandComplete );						var batchEvent:BatchEvent = new BatchEvent( BatchEvent.COMMAND_COMPLETE );			batchEvent.command = command;			dispatchEvent( batchEvent );			next();		}				// - PRIVATE METHODS -------------------------------------------------------------				private function lock():void		{			_currentIdx = 0;			_commandsCount = size;						_locked = true;		}				private function unlock():void		{			_currentIdx = 			_commandsCount = 0;						_locked = false;		}				private function complete():void		{			dispatchEvent( _completeEvent );		}				// - PUBLIC METHODS --------------------------------------------------------------				public function addCommand( command:ICommand ):Boolean		{			if( _locked ) throw new Error( "Impossible d'ajouter une command pendant que le Batch s'exécute." );			if( !command ) throw new Error( "La command passée en paramètre ne doit pas être nulle." );						var lenght:uint = _aCommands.length;			return lenght != _aCommands.push( command );		}				public function removeCommand( command:ICommand ):Boolean		{			if( _locked ) throw new Error( "Impossible de supprimer une command pendant que le Batch s'exécute." );			var id:uint = _aCommands.indexOf( command );			if( id == -1 ) return false;						while( id )			{				_aCommands.splice( id, 1 );				id = _aCommands.indexOf( command );			}			return true;		}				public function hasCommand( command:ICommand ):Boolean		{			return _aCommands.indexOf( command ) != -1;		}				public function removeAll():void		{			if( _locked ) throw new Error( "Impossible de supprimer des command pendant que le Batch s'exécute." );			_aCommands = [];		}				public function dispose():void		{			_aCommands = null;		}				public function execute():void		{			lock();			next();		}				public function next():void		{			if( hasNext() )			{				var command:ICommand = _aCommands[ 0 ];				command.addEventListener( ProgressEvent.PROGRESS, onCommandProgress, false, 0, true );				command.addEventListener( Event.COMPLETE, onCommandComplete, false, 0, true );				command.execute();				dispatchEvent( _commandStartEvent );				return;			}			unlock();			complete();		}		public function hasNext():Boolean		{			return ( size > 0 );		}				// - GETTERS & SETTERS -----------------------------------------------------------				public function get size():uint { return _aCommands.length; }		}	}