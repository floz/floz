
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.nude.data.parsers 
{
	import com.nude.data.enums.EnumAttribute;
	
	public class XMLParser implements IParser
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _datas:XML;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function XMLParser( datas:XML ) 
		{
			this._datas = datas;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function grabProperties( datas:XML, properties:Object = null ):Object
		{
			if ( !properties )
				properties = initProperties();
			
			var node:XML;
			var list:XMLList = datas.children();
			var i:int = list.length();
			while ( --i > -1 )
			{
				node = list[ i ];
				if ( node.attribute( EnumAttribute.ID ).length() )
					properties[ EnumAttribute.ID ] = addProperty( node.attribute( EnumAttribute.ID ), node, properties[ EnumAttribute.ID ] );
				
				var children:XMLList = node.children();
				if ( children.length() && children.children().length() )
					properties = grabProperties( node, properties );
			}
			
			return properties;
		}
		
		private function initProperties():Object
		{
			var o:Object = { };
			
			var a:Array = EnumAttribute.ENUM_LIST;
			var i:int = a.length;
			while ( --i > -1 )
				o[ a[ i ] ] = { };
			
			return o;
		}
		
		private function addProperty( name:String, value:XML, properties:Object ):Object
		{
			var datas:Vector.<String>;
			if ( ( name in properties ) )
			{
				datas = properties[ name ];
			}
			else
			{
				datas = new Vector.<String>( 0, false );
				properties[ name ] = datas;
			}
			datas.push( value );
			
			return properties;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function parseDatas():Object
		{
			return grabProperties( _datas );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}