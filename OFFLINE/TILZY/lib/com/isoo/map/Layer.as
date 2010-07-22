package com.isoo.map 
{
        import flash.display.Bitmap;
        import flash.display.DisplayObjectContainer;
        import flash.display.Sprite;
		import com.isoo.objects.IsoObject;
        
        public class Layer extends Sprite 
        {
                
                // - PRIVATE VARIABLES -----------------------------------------------------------
                
                private var _objects:Vector.<IsoObject>; /*IsoObject*/
                private var _objectsToRender:Vector.<IsoObject>;
                private var _needRender:Boolean;
                
                private var _objA:IsoObject;
                private var _objB:IsoObject;

                // - CONSTRUCTOR -----------------------------------------------------------------

                public function Layer() 
                {
                        _objects = new Vector.<IsoObject>();
                        _objectsToRender = new Vector.<IsoObject>();
                }
                
                // - PRIVATE METHODS -------------------------------------------------------------
                
                private function addToList( object:IsoObject ):void
                {
                        var idx:int = getDepthIdx( object.depth );
                        _objects.splice( idx, 0, object );
                        addChildAt( object, idx );
                        
                        var startIdx:int = idx;
                        var sorted:Boolean = true;
                        
                        do
                        {
                                idx = startIdx;
                                _objA = _objects[ idx ];
                                
                                sorted = true;
                                
                                while( idx + 1 < _objects.length && _objects[ idx + 1 ].depth == _objA.depth )
                                {
                                        _objB = _objects[ idx + 1 ];
                                        if ( _objA.y > _objB.y )
                                        {
                                                _objects[ idx ] = _objB;
                                                _objects[ idx + 1 ] = _objA;
                                                swapChildren( _objA, _objB );
                                                
                                                sorted = false;
                                        }
                                        
                                        _objA = _objB;
                                        ++idx;
                                }
                        } 
                        while ( !sorted );
                        
                        _objA = null;
                        _objB = null;
                }
                
                private function getDepthIdx( depth:Number ):int
                {
                        const L:int = _objects.length;
                        
                        var min:int = 0;
                        var max:int = L;
                        
                        var mid:int;
                        
                        while ( min < max )
                        {
                                mid = min + ( ( max - min ) >> 1 );
                                if ( _objects[ mid ].depth < depth )
                                        min = mid + 1;
                                else
                                        max = mid;
                        }
                        
                        return min;                     
                }
                
                // - PUBLIC METHODS --------------------------------------------------------------
                
                /**
                 * Ajoute un objet au layer.
                 * @param       object  IsoObject      L'objet à ajouter.
                 */
                public function addObject( object:IsoObject ):void
                {
					if ( _objects.indexOf(object) != -1 )
						return;
					
                    addToList( object );
                    object.registerToLayer( this );
                }
				
				public function getObjectTo(x:int, y:int):IsoObject
				{
					for ( var i:int = 0; i < numChildren; i++ ) {
						var o:IsoObject = getChildAt(i) as IsoObject;
						if ( o.caseX == x && o.caseY == y )
							return o;
					}
					return null;
				}
                
                /**
                 * Supprimer un objet du layer.
                 * @param       object  GameObject      L'objet à supprimer.
                 */
                public function removeObject( object:IsoObject ):void
                {
                        if ( !object.isRegisterToLayer( this ) ){
							return;
						}
						
                        var idx:int = _objects.indexOf( object );
                        if( idx != -1 ){             
							_objects.splice( idx, 1 );
                        }
						
                        object.unregisterFromLayer();
                        
                        removeChild( object );
                }
                
                /**
                 * Rend disponible un objet au prochain rendu.
                 * Appellé automatiquement par l'objet lorsque sa position change.
                 * @param       object  IsoObject      L'objet à rendre.
                 */
                public function renderObject( object:IsoObject ):void
                {
                        var idx:int = _objects.indexOf( object );
                        if ( idx >= 0 )
                            _objects.splice( idx, 1 );
                        
                        addToList( object );
                }
                
                public function dispose():void
                {                       
                        _objA = null;
                        _objB = null;
						
                        var i:int = _objects.length;
						
                        while ( --i > -1 )
                        {
							_objects[ i ].unregisterFromScene();
                            _objects[ i ].unregisterFromLayer();
                        }
						
                        _objectsToRender = null;
						
						while ( numChildren > 0 )
							removeChildAt( 0 );
                }
                
                public function traceObjects():void
                {
                        trace( "Object : " + _objects );
                }
				
				public function getAllIsoObject():Vector.<IsoObject> 
				{
					var v:Vector.<IsoObject> = new Vector.<IsoObject>();
					for ( var i:int = 0 ; i < numChildren; i++ )
						v.push( getChildAt( i ) );
					return v;
				}
				
				public function removeAllIsoObject():void
				{
					for ( var i:int = 0; i < _objects.length; i++ )
						removeObject( _objects[i] );
					for ( i = 0; i < _objectsToRender.length; i++ )
						removeObject( _objectsToRender[i] );
				}
				
				public function getAllObjects():Vector.<IsoObject>
				{
					return _objects;
				}
                
                // - GETTERS & SETTERS -----------------------------------------------------------
                
                public function get needRender():Boolean { return _needRender; }
                
                public function set needRender( value:Boolean ):void 
                {
                        _needRender = value;
                }
                
        }
        
}