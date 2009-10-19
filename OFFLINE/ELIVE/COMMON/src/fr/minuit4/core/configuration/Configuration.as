/*** Written by :* @author Floz* www.floz.fr || www.minuit4.fr* * La classe Configuration permet actuellement d'initialiser un projet en lui passant un fichier de donn�es.* Les donn�es contenues dans ce fichier seront par la suite accessible � travers l'instance de Configuration.* Les formats de fichiers autoris�s sont pour le moment :* - XML* - JSON* Des formats peuvent facilement �tre rajout�s en cr�ant une nouvelle classe �tendant DynamicDatas, en suivant le mod�le* de DynamicXML et DynamicJSON.* * Cet objet est un singleton, et il existe deux mani�res de l'utiliser :* 1) var conf:Configuration = Configuration.getInstance();* et passer par la variable conf pour acc�der aux m�thodes publiques de la classe Configuration.* 2) Passer par la la constante Conf, qui renvoie Configuration.getInstance();* * Pour charger un fichier de configuration, il faut faire appel � la m�thode 'load', en passant comme param�tres* l'url du fichier de donn�es, puis une instance de Dynamic correspondant.* Exemple :* 	Conf.load( "datas.xml", new DynamicXML() );* * Nous pouvons �couter l'�v�nement Event.COMPLETE que l'objet Configuration dispatchera une fois le fichier charg�,* les donn�es pars�es, et les �ventuels fichiers suppl�mentaires t�l�charg�s.* Ensuite, nous pourrons faire appel � la m�thode 'getProperty' pour acc�der aux informations du fichier de donn�es.* Pour continuer sur l'exemple du fichier XML, soit le contenu suivant :* *	 <datas>*		<baseURL>.</baseURL>*		*		<minuit4><![CDATA[minuit4forthewin]]></minuit4>*		<testnode><![CDATA[${minuit4}, blabla]]></testnode>*	*		<pathIMG><![CDATA[img/]]></pathIMG>*		<pathXML><![CDATA[${baseURL}/xml/]]></pathXML>* 	</datas>* 	* Equivalent en JSON :* { *	"baseURL": ".",*	*	"minuit4": "minuit4forthewin",*	"testnode": "${minuit4}, blabla",*	*	"pathIMG": "img/",*	"pathXML": "${baseURL}/xml/"* }* * Nous pourrons appeller la m�thode getProperty de cette mani�res :* 	- Conf.getProperty( "baseURL" ); // renvoie un String : ".".* 	- Conf.getProperty( "testnode" ); // renvoie un String : "minuit4forthewin, blabla".* 	- Conf.pathIMG; // renvoie un String : "./xml/".* 	* Au sein du fichier de donn�es, des tags ${...} peuvent �tre ins�r�s pour faire r�f�rence � un des nodes racines, qui sont consid�r�s* comme propri�t�s.* Ici par exemple, ${minuit4} renvoie � <minuit4></minuit4> dont la valeur est "minuit4forthewin".* * Continuons l'exemple :* * 	<datas>*		<baseURL>.</baseURL>*		*		<minuit4><![CDATA[minuit4forthewin]]></minuit4>*		<testnode><![CDATA[${minuit4}, blabla]]></testnode>*		*		<pathIMG><![CDATA[img/]]></pathIMG>*		<pathXML><![CDATA[${baseURL}/xml/]]></pathXML>*		*		<datasToLoad>*			<file id="datas1"><![CDATA[${pathXML}/datas1.xml]]></file>*			<file id="datas2"><![CDATA[${pathXML}/datas2.xml]]></file>*		</datasToLoad>*		*		<assetsToLoad>*			<file id="chapin"><![CDATA[${baseURL}/${pathIMG}/chapin2.jpg]]></file>*			<file id="chapin2"><![CDATA[${baseURL}/${pathIMG}/chapin2.jpg]]></file>*		</assetsToLoad>*		*		<testXml>*			<items>*				<item>toto</item>*				<item>tata</item>*				<item>titi</item>*			</items>*		</testXml>*	</datas>** Les noeuds "datasToLoad" et "assetsToLoad" attendent d'autres noeuds nomm�s "file", avec un attribut "id".* L'attribut "id" permettra d'acc�der aux fichiers une fois qu'ils seront t�l�charg�s par le fichier de Configuration.* Ainsi, lorsque l'�v�nement Event.COMPLETE sera dispatch� par l'objet Configuration, nous pourrons faire :* 	getProperty( "datas1" ); // Renvoie une String qu'il est possible de convertir en XML : XML( getProperty( "datas1" ) );* 	getProperty( "chapin" ); // Renvoie un DisplayObject de type Bitmap.* 	* A noter que getProperty( "textXml" ); renverra aussi une String qu'il sera possible de convertir en XML.* * Il est aussi possible de setter des propri�t�s, ou de resetter des propri�t�s, par le biais de la m�thode 'setProperty'.* * ---** Version log :* 27.09.09		0.1		Floz		+ Premi�re version avec documentation.* 20.09.09		0.1		Floz		+ Refonte de la classe Configuration, linkage avec les objets de type DynamicDatas.* 13.09.09		0.1		Floz		+ Premi�re version de la classe Configuration.	*/package fr.minuit4.core.configuration{	import flash.text.StyleSheet;	import fr.minuit4.core.commands.Batch;	import fr.minuit4.core.datas.dynamics.DynamicDatas;	import fr.minuit4.core.datas.dynamics.IDynamic;	import fr.minuit4.core.events.BatchEvent;	import fr.minuit4.net.loaders.AbstractLoader;	import fr.minuit4.net.loaders.types.AssetsLoader;	import fr.minuit4.net.loaders.types.DatasLoader;	import flash.display.DisplayObject;	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.events.ProgressEvent;		/**	 * La classe Configuration propose une structure d'instanciation d'un projet	 * bas� sur une fichier de donn�es externes de type XML/JSON/...	 * Une fois ces donn�es charg�es, leur contenu est pars�e et accessible via	 * l'instance de Configuration par la m�thode getProperty( "nom de la propri�t� � acc�der" ).	 * 	 * D'autres m�thodes publiques statiques, communes � tous les projets, sont disponibles.	 * 	 * L'objet Configuration peut se charger de loader plusieurs assets/fichiers de donn�es	 * en plus du fichier principal de configuration.	 */	public class Configuration extends EventDispatcher implements IDynamic	{			// - PRIVATE VARIABLES -----------------------------------------------------------				private static var _instance:Configuration;		private static var _allowInstanciation:Boolean;				private const _completeEvent:Event = new Event( Event.COMPLETE );				/**		 * Au moment du parsing du fichier DynamicDatas, l'objet Configuration va regarder s'il		 * existe les param�tres contenu dans le tableau _propertiesToCheck.		 * Si tel est le cas, les propri�t�s publiques statiques seront renseign�es.		 */		private const _propertiesToCheck:Array = [ "baseURL", "pathIMG", "pathXML", "pathSWF", "pathCSS" ];				private var _batch:Batch;		private var _commands:Array;		private var _filesLoaded:Object;				private var _dynamicDatas:DynamicDatas;				private var _linkToConfFile:Boolean;				// - PUBLIC VARIABLES ------------------------------------------------------------				public static var DEBUG:Boolean = true;				/**		 * Le nom de la propri�t� contenant les fichiers de types XML, JSON, ... A charger.		 * L'objet Configuration interrogera l'objet DynamicDatas pour savoir si cette propri�t� existe.		 */		public static var DATAS_TO_LOAD:String = "datasToLoad";				/**		 * Le nom de la propri�t� contenant les fichiers de types JPG, SWF, ... A charger.		 * L'objet Configuration interrogera l'objet DynamicDatas pour savoir si cette propri�t� existe.		 */		public static var ASSETS_TO_LOAD:String = "assetsToLoad";				/**		 * L'url de l'index du site.		 */		public static var baseURL:String = ".";				/**		 * Le chemin pour acc�der aux images.		 */		public static var pathIMG:String = baseURL + "/img";				/**		 * Le chemin pour acc�der aux fichiers XML.		 */		public static var pathXML:String = baseURL + "/xml";				/**		 * Le chemin pour acc�der aux fichiers JSON.		 */		public static var pathJSON:String = baseURL + "/json";				/**		 * Le chemin pour acc�der aux SWF.		 */		public static var pathSWF:String = baseURL + "/swf";				/**		 * Le chemin pour acc�der aux feuilles de styles.		 */		public static var pathCSS:String = baseURL + "/css";		// - CONSTRUCTOR -----------------------------------------------------------------				public function Configuration()		{			if( !_allowInstanciation ) throw new Error( "This is a Singleton class, use the getInstance() method instead." );			init();		}				// - EVENTS HANDLERS -------------------------------------------------------------				private function onLoadComplete( e:Event ):void		{			var dataLoader:DatasLoader = e.target as DatasLoader;			dataLoader.removeEventListener( Event.COMPLETE, onLoadComplete );						var datas:String = dataLoader.getItemLoaded();			_dynamicDatas.parseDatas( datas );										dataLoader.dispose();						parseDatas();		}				private function onBatchProgress( e:ProgressEvent ):void		{			dispatchEvent( e );		}				private function onCommandComplete( e:BatchEvent ):void		{			var item:Object = _commands.shift();			var loader:AbstractLoader = e.command as AbstractLoader;			_filesLoaded[ item.id ] = loader.getItemLoaded();			loader.dispose();		}				private function onBatchComplete( e:Event ):void		{			_batch.removeEventListener( ProgressEvent.PROGRESS, onBatchProgress );			_batch.removeEventListener( Event.COMPLETE, onBatchComplete );						_linkToConfFile = true;			dispatchEvent( _completeEvent );		}				// - PRIVATE METHODS -------------------------------------------------------------				private function init():void		{			_commands = [];			_filesLoaded = {};		}				/**		 * Parcoure le xml/json/... de configuration pour mettre en place toutes les propri�t�s/variables		 * qui pourront �tre utiliser � la suite.		 */		protected function parseDatas():void		{			var propertyName:String;			var i:int = _propertiesToCheck.length;			while( --i > -1 )			{				// Settage des variables statiques de la classe.				propertyName = _propertiesToCheck[ i ];								if( _dynamicDatas.hasProperty( propertyName ) )					Configuration[ propertyName ] = _dynamicDatas.getProperty( propertyName );			}						var datas:Boolean = registerDatasToLoad(), assets:Boolean = registerAssetsToLoad();			// Chargement des fichiers externes.			if( datas || assets )			{				loadFiles();				return;			}			_linkToConfFile = true;			dispatchEvent( _completeEvent );		}				/**		 * V�rifie l'existence des fichiers de types datas (XML, JSON, CSS...) � t�l�charger.		 * S'il y en a, un objet Loader est ajout� � la liste des commandes qui seront ex�cut�es		 * par l'instance de Batch.		 * @return	Boolean		 */		private function registerDatasToLoad():Boolean		{			if( !_dynamicDatas.hasProperty( DATAS_TO_LOAD) ) return false;			var datasToLoad:Array = _dynamicDatas.getFiles( DATAS_TO_LOAD );						var dataLoader:DatasLoader;			var i:int, n:int = datasToLoad.length;			for( ; i<n; ++i )			{				dataLoader = new DatasLoader( datasToLoad[ i ].url );				datasToLoad[ i ].command = dataLoader;				_commands.push( datasToLoad[ i ] );			}									return true;		}				/**		 * V�rifie l'existence des fichiers de types datas (JPG, SWF...) � t�l�charger.		 * S'il y en a, un objet Loader est ajout� � la liste des commandes qui seront ex�cut�es		 * par l'instance de Batch.		 * @return	Boolean		 */		private function registerAssetsToLoad():Boolean		{			if( !_dynamicDatas.hasProperty( ASSETS_TO_LOAD ) ) return false;			var assetsToLoad:Array = _dynamicDatas.getFiles( ASSETS_TO_LOAD );						var assetLoader:AssetsLoader;			var i:int, n:int = assetsToLoad.length;			for( ; i<n; ++i )			{				assetLoader = new AssetsLoader( assetsToLoad[ i ].url );				assetsToLoad[ i ].command = assetLoader;				_commands.push( assetsToLoad[ i ] );			}						return true;		}				/**		 * D�bute le chargement des fichiers externes.		 */		private function loadFiles():void		{			_batch = new Batch();			var i:int, n:int = _commands.length;			for( ; i<n; ++i )				_batch.addCommand( _commands[ i ].command );						_batch.addEventListener( ProgressEvent.PROGRESS, onBatchProgress, false, 0, true );			_batch.addEventListener( BatchEvent.COMMAND_COMPLETE, onCommandComplete, false, 10, true );			_batch.addEventListener( Event.COMPLETE, onBatchComplete, false, 0, true );			_batch.execute();		}		// - PUBLIC METHODS --------------------------------------------------------------				/**		 * This method has to be called to instanciate the Configuration Object.		 */		public static function getInstance():Configuration		{			if( !_instance )			{				_allowInstanciation = true; {					_instance = new Configuration;				} _allowInstanciation = false;			}			return _instance;		}				/**		 * D�marre le chargement du fichier de configuration.		 * @param	url	String	L'url du fichier de configuration.		 * @param	dynamicDatas	DynamicDatas	L'objet Dynamic qui d�pend du type des donn�es � charger		 * (DynamicXML pour le XML, DynamicJSON pour le JSON).		 */		public function load( url:String, dynamicDatas:DynamicDatas ):void		{			_dynamicDatas = dynamicDatas;						var dataLoader:DatasLoader = new DatasLoader();			dataLoader.addEventListener( Event.COMPLETE, onLoadComplete );			dataLoader.load( url );		}				/**		 * @return	Boolean	Renvoie 'true' si la propri�t� existe.		 */		public function hasProperty( propertyName:String ):Boolean		{			if( _linkToConfFile )				return _dynamicDatas.hasProperty( propertyName ) || propertyName in _filesLoaded;						return false;		}				/**		 * Cette m�thode permet de modifier la valeur d'une propri�t�, ou d'ajouter une propri�t� (et sa valeur).		 * Ces propri�t�s seront par la suite accessible via la m�thode getProperty.		 * @param	propertyName	String	Le nom de la propri�t� en question.		 * @param	propertyValue	*	La valeur de la propri�t� en question.		 */		public function setProperty( propertyName:String, propertyValue:* ):void		{			if( propertyName in _filesLoaded || propertyValue is DisplayObject ) _filesLoaded[ propertyName ] = propertyValue;			_dynamicDatas.setProperty( propertyName, propertyValue );		}				/**		 * Renvoie la valeur d'une propri�t�.		 * @param	propertyName	String	Le nom de la propri�t� en question.		 * @return	*		 */		public function getProperty( propertyName:String ):*		{			if ( !hasProperty( propertyName ) ) 				return null;						if( propertyName in _filesLoaded ) return _filesLoaded[ propertyName ];			return _dynamicDatas.getProperty( propertyName );		}				// - GETTERS & SETTERS -----------------------------------------------------------		}	}