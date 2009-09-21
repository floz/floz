/*** Written by :* @author Floz* www.floz.fr || www.minuit4.fr*/package fr.minuit4.core.datas.dynamics{	import flash.utils.Dictionary;	public class DynamicDatas implements IDynamic	{			// - PRIVATE VARIABLES -----------------------------------------------------------				private static const PROP_REGEXP:RegExp = /\$\{(\w)*\}/;		private static const BEGIN_TOKEN_REGEXP:RegExp = /\$\{/;		private static const END_TOKEN_REGEXP:RegExp = /\}/;		private static const DOUBLE_BAR_REGEXP:RegExp = /\/\//g;				protected const _properties:Dictionary = new Dictionary( false );				// - PUBLIC VARIABLES ------------------------------------------------------------				// - CONSTRUCTOR -----------------------------------------------------------------				public function DynamicDatas()		{					}				// - EVENTS HANDLERS -------------------------------------------------------------				// - PRIVATE METHODS -------------------------------------------------------------				protected function parseDatas():void		{			// ABSTRACT METHOD, MUST BE OVERIDDED		}				private function resolveString( value:String ):String		{			if( !PROP_REGEXP.test( value ) ) return value;						var propertyName:String;			var result:Object = PROP_REGEXP.exec( value );			while( result )			{				propertyName = result[ 0 ];				propertyName = propertyName.replace( BEGIN_TOKEN_REGEXP, "" ).replace( END_TOKEN_REGEXP, "" );			    if( !hasProperty( propertyName ) ) throw new Error( "The property '" + propertyName + "' doesn't exist, impossible to solve : ${" + propertyName + "}" );				value = value.replace( PROP_REGEXP, resolveString( _properties[ propertyName ] ) );								result = PROP_REGEXP.exec( value );			}						return value.replace( DOUBLE_BAR_REGEXP, "/" );		}				// - PUBLIC METHODS --------------------------------------------------------------				public function hasProperty( propertyName:String ):Boolean		{			return ( propertyName in _properties );		}				public function getData( propertyName:String ):*		{			if( !hasProperty( propertyName ) ) throw new Error( "La propriété '" + propertyName + "' n'existe pas." );			return resolveString( _properties[ propertyName ] );					}				// - GETTERS & SETTERS -----------------------------------------------------------		}	}