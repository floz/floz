/*** Written by :* @author Floz* www.floz.fr || www.minuit4.fr*/package fr.minuit4.core.conf{	import XML;	import fr.minuit4.core.commands.Batch;	import fr.minuit4.core.datas.dynamics.DynamicDatas;	import fr.minuit4.core.datas.dynamics.DynamicFormats;	import fr.minuit4.core.datas.dynamics.DynamicJSON;	import fr.minuit4.core.datas.dynamics.DynamicXML;	import fr.minuit4.core.datas.dynamics.IDynamic;	import fr.minuit4.core.events.BatchEvent;	import fr.minuit4.net.loaders.AbstractLoader;	import fr.minuit4.net.loaders.types.AssetLoader;	import fr.minuit4.net.loaders.types.DataLoader;	import flash.display.DisplayObject;	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.events.ProgressEvent;	public class Configuration extends EventDispatcher implements IDynamic	{			// - PRIVATE VARIABLES -----------------------------------------------------------				private static var _instance:Configuration;		private static var _allowInstanciation:Boolean;				private const _completeEvent:Event = new Event( Event.COMPLETE );				/**		 * Au moment du parsing du fichier DynamicDatas, l'objet Configuration va regarder s'il		 * existe les paramètres contenu dans le tableau _propertiesToCheck.		 * Si tel est le cas, les propriétés publiques statiques seront renseignées.		 */		private const _propertiesToCheck:Array = [ "baseURL", "pathIMG", "pathXML", "pathSWF", "pathCSS" ];				/**		 * Le nom de la propriété contenant les fichiers de types XML, JSON, ... A charger.		 * L'objet Configuration interrogera l'objet DynamicDatas pour savoir si cette propriété existe.		 */		private const DATAS_TO_LOAD:String = "datasToLoad";				/**		 * Le nom de la propriété contenant les fichiers de types JPG, SWF, ... A charger.		 * L'objet Configuration interrogera l'objet DynamicDatas pour savoir si cette propriété existe.		 */		private const ASSETS_TO_LOAD:String = "assetsToLoad";				private var _batch:Batch;		private var _commands:Array;		private var _filesLoaded:Object;				private var _dynamicDatas:DynamicDatas;		private var _format:String;				// - PUBLIC VARIABLES ------------------------------------------------------------				/**		 * L'url de l'index du site.		 */		public static var baseURL:String = ".";				/**		 * Le chemin pour accéder aux images.		 */		public static var pathIMG:String = baseURL + "/img";				/**		 * Le chemin pour accéder aux fichiers XML.		 */		public static var pathXML:String = baseURL + "/xml";				/**		 * Le chemin pour accéder aux fichiers JSON.		 */		public static var pathJSON:String = baseURL + "/json";				/**		 * Le chemin pour accéder aux SWF.		 */		public static var pathSWF:String = baseURL + "/swf";				/**		 * Le chemin pour accéder aux feuilles de styles.		 */		public static var pathCSS:String = baseURL + "/css";		// - CONSTRUCTOR -----------------------------------------------------------------				public function Configuration()		{			if( !_allowInstanciation ) throw new Error( "This is a Singleton class, use the getInstance() method instead." );			init();		}				// - EVENTS HANDLERS -------------------------------------------------------------				private function onLoadComplete( e:Event ):void		{			var dataLoader:DataLoader = e.target as DataLoader;			dataLoader.removeEventListener( Event.COMPLETE, onLoadComplete );						var datas:String = dataLoader.getItemLoaded();			switch( _format )			{				case DynamicFormats.XML : _dynamicDatas = new DynamicXML( XML( datas ) ); break;				case DynamicFormats.JSON : _dynamicDatas = new DynamicJSON( Object( datas ) ); break; 			}										dataLoader.dispose();						parseDatas();		}				private function onBatchProgress( e:ProgressEvent ):void		{			dispatchEvent( e );		}				private function onCommandComplete( e:BatchEvent ):void		{			var item:Object = _commands.shift();			var loader:AbstractLoader = e.command as AbstractLoader;			_filesLoaded[ item.id ] = loader.getItemLoaded();			loader.dispose();		}				private function onBatchComplete( e:Event ):void		{			_batch.removeEventListener( ProgressEvent.PROGRESS, onBatchProgress );			_batch.removeEventListener( Event.COMPLETE, onBatchComplete );			dispatchEvent( _completeEvent );		}				// - PRIVATE METHODS -------------------------------------------------------------				private function init():void		{			_commands = [];		}				/**		 * Parcoure le xml/json/... de configuration pour mettre en place toutes les propriétés/variables		 * qui pourront être utiliser à la suite.		 */		protected function parseDatas():void		{			var propertyName:String;			var i:int = _propertiesToCheck.length;			while( --i > -1 )			{				// Settage des variables statiques de la classe.				propertyName = _propertiesToCheck[ i ];								if( _dynamicDatas.hasProperty( propertyName ) )					Configuration[ propertyName ] = _dynamicDatas.getProperty( propertyName );			}						var datas:Boolean = registerDatasToLoad(), assets:Boolean = registerAssetsToLoad();			// Chargement des fichiers externes.			if( datas || assets )			{				loadFiles();				return;			}			dispatchEvent( _completeEvent );		}				/**		 * Vérifie l'existence des fichiers de types datas (XML, JSON, CSS...) à télécharger.		 * S'il y en a, un objet Loader est ajouté à la liste des commandes qui seront exécutées		 * par l'instance de Batch.		 * @return	Boolean		 */		private function registerDatasToLoad():Boolean		{			if( !_dynamicDatas.hasProperty( DATAS_TO_LOAD) ) return false;			var datasToLoad:Array = _dynamicDatas.getFiles( DATAS_TO_LOAD );						var dataLoader:DataLoader;			var i:int, n:int = datasToLoad.length;			for( ; i<n; ++i )			{				dataLoader = new DataLoader( datasToLoad[ i ].url );				datasToLoad[ i ].command = dataLoader;				_commands.push( datasToLoad[ i ] );			}									return true;		}				/**		 * Vérifie l'existence des fichiers de types datas (JPG, SWF...) à télécharger.		 * S'il y en a, un objet Loader est ajouté à la liste des commandes qui seront exécutées		 * par l'instance de Batch.		 * @return	Boolean		 */		private function registerAssetsToLoad():Boolean		{			if( !_dynamicDatas.hasProperty( DATAS_TO_LOAD) ) return false;			var assetsToLoad:Array = _dynamicDatas.getFiles( ASSETS_TO_LOAD );						var assetLoader:AssetLoader;			var i:int, n:int = assetsToLoad.length;			for( ; i<n; ++i )			{				assetLoader = new AssetLoader( assetsToLoad[ i ].url );				assetsToLoad[ i ].command = assetLoader;				_commands.push( assetsToLoad[ i ] );			}									return true;		}				/**		 * Débutte le chargement des fichiers externes.		 */		private function loadFiles():void		{			_filesLoaded = {};						_batch = new Batch();			var i:int, n:int = _commands.length;			for( ; i<n; ++i )				_batch.addCommand( _commands[ i ].command );						_batch.addEventListener( ProgressEvent.PROGRESS, onBatchProgress, false, 0, true );			_batch.addEventListener( BatchEvent.COMMAND_COMPLETE, onCommandComplete, false, 10, true );			_batch.addEventListener( Event.COMPLETE, onBatchComplete, false, 0, true );			_batch.execute();		}		// - PUBLIC METHODS --------------------------------------------------------------				/**		 * This method has to be called to instanciate the Configuration Object.		 */		public static function getInstance():Configuration		{			if( !_instance )			{				_allowInstanciation = true; {					_instance = new Configuration;				} _allowInstanciation = false;			}			return _instance;		}				/**		 * Launch the loading of the xml file which will be used for the Configuration instance.		 * @param	url	String	The url of the xml file.		 */		public function load( url:String ):void		{			_format = url.substr( url.search( /\./ ), url.length );			if( !DynamicFormats.isFormatAllowed( _format ) ) throw new Error( "Format de données non attendu : '" + _format + "'." );						var dataLoader:DataLoader = new DataLoader();			dataLoader.addEventListener( Event.COMPLETE, onLoadComplete );			dataLoader.load( url );		}				/**		 * @return	Boolean	Return true if the property exist.		 */		public function hasProperty( propertyName:String ):Boolean		{			return _dynamicDatas.hasProperty( propertyName ) || propertyName in _filesLoaded;		}				/**		 * Cette méthode permet de modifier la valeur d'une propriété, ou d'ajouter une propriété (et sa valeur).		 * Ces propriétés seront par la suite accessible via la méthode getProperty.		 * @param	propertyName	String	Le nom de la propriété en question.		 * @param	propertyValue	*	La valeur de la propriété en question.		 */		public function setProperty( propertyName:String, propertyValue:* ):void		{			if( propertyName in _filesLoaded || propertyValue is DisplayObject ) _filesLoaded[ propertyName ] = propertyValue;			_dynamicDatas.setProperty( propertyName, propertyValue );		}				/**		 * Renvoie la valeur d'une propriété.		 * @param	propertyName	String	Le nom de la propriété en question.		 * @return	*		 */		public function getProperty( propertyName:String ):*		{			if( propertyName in _filesLoaded ) return _filesLoaded[ propertyName ];			return _dynamicDatas.getProperty( propertyName );		}				// - GETTERS & SETTERS -----------------------------------------------------------		}	}