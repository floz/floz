/*** Written by :* @author Floz* www.floz.fr || www.minuit4.fr*/package fr.minuit4.core.datas.dynamics{	public class DynamicDatas implements IDynamic	{			// - PRIVATE VARIABLES -----------------------------------------------------------				private static const PROP_REGEXP:RegExp = /\$\{(\w)*\}/;		private static const BEGIN_TOKEN_REGEXP:RegExp = /\$\{/;		private static const END_TOKEN_REGEXP:RegExp = /\}/;		private static const DOUBLE_BAR_REGEXP:RegExp = /\/\//g;				/**		 * L'objet dans lequel sera stock�es toutes les propri�t�s de l'objet Dynamic.		 * @protected		 */		protected const _properties:Object = {};				// - PUBLIC VARIABLES ------------------------------------------------------------				// - CONSTRUCTOR -----------------------------------------------------------------				public function DynamicDatas()		{					}				// - EVENTS HANDLERS -------------------------------------------------------------				// - PRIVATE METHODS -------------------------------------------------------------				protected function resolveString( value:String ):String		{			if( !PROP_REGEXP.test( value ) ) return value;						var propertyName:String;			var result:Object = PROP_REGEXP.exec( value );			while( result )			{				propertyName = result[ 0 ];				propertyName = propertyName.replace( BEGIN_TOKEN_REGEXP, "" ).replace( END_TOKEN_REGEXP, "" );			    if( !hasProperty( propertyName ) ) throw new Error( "The property '" + propertyName + "' doesn't exist, impossible to solve : ${" + propertyName + "}" );				value = value.replace( PROP_REGEXP, resolveString( _properties[ propertyName ] ) );								result = PROP_REGEXP.exec( value );			}						return value.replace( DOUBLE_BAR_REGEXP, "/" );		}				// - PUBLIC METHODS --------------------------------------------------------------				/**		 * M�thode qui parse des donn�es pour pouvoir y acc�der via la m�thode getProperty.		 * @param	datas	String	La chaine de caract�res contenant les donn�es � parser.			 */		public function parseDatas( datas:String ):void		{			// ABSTRACT METHOD, MUST BE OVERIDDED		}				/**		 * @return	Boolean	Renvoie true si la propri�t� existe.		 */		public function hasProperty( propertyName:String ):Boolean		{			return ( propertyName in _properties );		}				/**		 * Cette m�thode permet de modifier la valeur d'une propri�t�, ou d'ajouter une propri�t� (et sa valeur).		 * Ces propri�t�s seront par la suite accessible via la m�thode getProperty.		 * @param	propertyName	String	Le nom de la propri�t� en question.		 * @param	propertyValue	*	La valeur de la propri�t� en question.		 */		public function setProperty( propertyName:String, propertyValue:* ):void		{			_properties[ propertyName ] = propertyValue;		}				/**		 * Renvoie la valeur d'une propri�t�.		 * @param	propertyName	String	Le nom de la propri�t� en question.		 * @return	*		 */		public function getProperty( propertyName:String ):*		{			if( !hasProperty( propertyName ) ) return null			var propertyValue:* = _properties[ propertyName ];						if( String( propertyValue ) ) return resolveString( propertyValue );			return propertyValue;		}				/**		 * Renvoie un tableau contenant des Object de la forme :		 * { id: nom de la propri�t�, url: url du fichier � downloader }		 * Ce tableau permettra par la suite de t�l�charger une s�rie de fichier.		 * Cette m�thode est utilis�e dans la classe Configuration pour r�cup�rer les fichiers externes � t�l�charger.		 * @param	String	Le nom de la propri�t� contenant la liste des fichiers.		 * @return	Array		 */		public function getFiles( propertyName:String ):Array		{			// ABSTRACT METHOD, MUST BE OVERRIDED						propertyName = "";			return null;		}				// - GETTERS & SETTERS -----------------------------------------------------------		}	}