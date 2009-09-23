/*** Written by :* @author Floz* www.floz.fr || www.minuit4.fr*/package fr.minuit4.core.datas.dynamics{	public class DynamicDatas implements IDynamic	{			// - PRIVATE VARIABLES -----------------------------------------------------------				private static const PROP_REGEXP:RegExp = /\$\{(\w)*\}/;		private static const BEGIN_TOKEN_REGEXP:RegExp = /\$\{/;		private static const END_TOKEN_REGEXP:RegExp = /\}/;		private static const DOUBLE_BAR_REGEXP:RegExp = /\/\//g;				/**		 * L'objet dans lequel sera stockées toutes les propriétés de l'objet Dynamic.		 * @protected		 */		protected const _properties:Object = {};				// - PUBLIC VARIABLES ------------------------------------------------------------				// - CONSTRUCTOR -----------------------------------------------------------------				public function DynamicDatas()		{					}				// - EVENTS HANDLERS -------------------------------------------------------------				// - PRIVATE METHODS -------------------------------------------------------------				protected function parseDatas():void		{			// ABSTRACT METHOD, MUST BE OVERIDDED		}				protected function resolveString( value:String ):String		{			if( !PROP_REGEXP.test( value ) ) return value;						var propertyName:String;			var result:Object = PROP_REGEXP.exec( value );			while( result )			{				propertyName = result[ 0 ];				propertyName = propertyName.replace( BEGIN_TOKEN_REGEXP, "" ).replace( END_TOKEN_REGEXP, "" );			    if( !hasProperty( propertyName ) ) throw new Error( "The property '" + propertyName + "' doesn't exist, impossible to solve : ${" + propertyName + "}" );				value = value.replace( PROP_REGEXP, resolveString( _properties[ propertyName ] ) );								result = PROP_REGEXP.exec( value );			}						return value.replace( DOUBLE_BAR_REGEXP, "/" );		}				// - PUBLIC METHODS --------------------------------------------------------------				/**		 * @return	Boolean	Renvoie true si la propriété existe.		 */		public function hasProperty( propertyName:String ):Boolean		{			return ( propertyName in _properties );		}				/**		 * Cette méthode permet de modifier la valeur d'une propriété, ou d'ajouter une propriété (et sa valeur).		 * Ces propriétés seront par la suite accessible via la méthode getProperty.		 * @param	propertyName	String	Le nom de la propriété en question.		 * @param	propertyValue	*	La valeur de la propriété en question.		 */		public function setProperty( propertyName:String, propertyValue:* ):void		{			_properties[ propertyName ] = propertyValue;		}				/**		 * Renvoie la valeur d'une propriété.		 * @param	propertyName	String	Le nom de la propriété en question.		 * @return	*		 */		public function getProperty( propertyName:String ):*		{			if( !hasProperty( propertyName ) ) throw new Error( "La propriété '" + propertyName + "' n'existe pas." );			var propertyValue:* = _properties[ propertyName ];						if( String( propertyValue ) ) return resolveString( propertyValue );			return propertyValue;		}				/**		 * Renvoie un tableau contenant des Object de la forme :		 * { id: nom de la propriété, url: url du fichier à downloader }		 * Ce tableau permettra par la suite de télécharger une série de fichier.		 * Cette méthode est utilisée dans la classe Configuration pour récupérer les fichiers externes à télécharger.		 * @param	String	Le nom de la propriété contenant la liste des fichiers.		 * @return	Array		 */		public function getFiles( propertyName:String ):Array		{			// ABSRACT METHOD, MUST BE OVERIDDED		}				// - GETTERS & SETTERS -----------------------------------------------------------		}	}