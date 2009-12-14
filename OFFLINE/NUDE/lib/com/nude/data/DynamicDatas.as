
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.nude.data 
{
	import com.nude.data.parsers.IParser;
	
	dynamic public class DynamicDatas implements IDynamic
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const PROP_REGEXP:RegExp = /\$\([\w:]*\)/;
		private static const BEGIN_TOKEN_REGEXP:RegExp = /\$\(/;
		private static const END_TOKEN_REGEXP:RegExp = /\)/;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _properties:Object;
		private var _parser:IParser;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DynamicDatas() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_properties = {};
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setParser( parser:IParser ):void
		{
			this._parser = parser;
		}
		
		public function parseDatas():void
		{
			if ( !_parser ) return;			
			_properties = _parser.parseDatas();
		}
		
		public function hasProperty( propertyName:String ):Boolean
		{
			return ( propertyName in _properties );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}