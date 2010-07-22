package com.gobzlite.utils 
{
	import com.gobzlite.utils.align.AlignObject;
	import flash.display.DisplayObject;
	
	/**
	 * align display object
	 * 
	 * ---------------------
	 * + synthax
	 * ---------------------
	 * 
	 * align( target ).to( position, offsetX:int = 0, offsetY:int = 0, container:DisplayObject = null ); 
	 * align( target ).toStage( position, offsetX:int = 0, offsetY:int = 0, stage:Stage = null );
	 * 
	 * align( target ).allChildren( position, offsetX:int = 0, offsetY:int = 0 );
	 * 
	 * align( target ).vertical( padding:int = 0 );
	 * align( target ).horizontal( padding:int = 0 );
	 * 
	 * align( target ).rightTo( otherObject, offsetX:int = 0, offsetY:int = 0 );
	 * align( target ).leftTo( otherObject, offsetX:int = 0, offsetY:int = 0 );
	 * align( target ).upperTo( otherObject, offsetX:int = 0, offsetY:int = 0 );
	 * align( target ).underTo( otherObject, offsetX:int = 0, offsetY:int = 0 );
	 * 
	 * align( target ).objectByColumn( num:int, paddingX:int = 0, paddingY:int = 0 );
	 * align( target ).objectByLine( num:int, paddingX:int = 0, paddingY:int = 0 );
	 * 
	 * ----------------------
	 * + todo
	 * ----------------------
	 * 
	 * fix problem to align object whitch not start at Top Left
	 * add .auto( value:Boolean );
	 * 
	 * 
	 * @version 0.2 : add .objectByLine( ... ).objectByColumn( ... );
	 * @version 0.1 : first implementation
	 * 
	 * @author David Ronai
	 */
	
	
	/**
	 * Align object
	 * @param	target	object to align
	 * @return	new AlignObject with specified target
	 */
	public function align(target:DisplayObject):AlignObject
	{
		return new AlignObject(target);
	}
}