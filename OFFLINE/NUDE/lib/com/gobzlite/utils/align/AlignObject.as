package com.gobzlite.utils.align
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author David Ronai
	 */
	public class AlignObject
	{
		
		private var _o:DisplayObject;
		
		/**
		 * Align object
		 * @param	o object to align
		 */
		public function AlignObject( o:DisplayObject ) 
		{
			if ( o == null )
				throw new Error("Align object can't be null");
			_o = o;
		}
		
		/**
		 * Align object to specified position beside parent or target if it's specified
		 * @param	position position to place element
		 * @param	offsetX horizontal offset 
		 * @param	offsetY vertical offset
		 * @param	target if specified , align beside target, else align beside his parent if it isn't null 
		 * @return Current AlignObject
		 */
		public function to( position:int=Align.NONE, offsetX:int=0, offsetY:int=0, target:DisplayObject = null ):AlignObject
		{
			if ( target != null )
				Align.to( _o, target, position, offsetX, offsetY );
			else if( _o.parent != null )
				Align.to( _o, _o.parent, position, offsetX, offsetY );
			return this;
		}
		
		/**
		 * Align object to specified position beside his stage or specified stage
		 * @param	position position to place element
		 * @param	offsetX horizontal offset 
		 * @param	offsetY vertical offset
		 * @param	stage if specified , align beside this stage, else align beside object stage if it isn't null 
		 * @return Current AlignObject
		 */
		public function toStage( position:int=Align.NONE, offsetX:int=0, offsetY:int=0, stage:Stage = null ):AlignObject
		{
			if ( stage != null )
				Align.toStage( _o, stage, position, offsetX, offsetY );
			else if ( _o.stage != null )
				Align.toStage( _o, _o.stage, position, offsetX, offsetY );
			return this;
		}
		
		/**
		 * Align all children in current AlignObject
		 * @param	position position to align children
		 * @param	offsetX horizontal offset
		 * @param	offsetY vertical offset
		 * @return Current AlignObject
		 */
		public function allChildren( position:int = Align.NONE, offsetX:int = 0, offsetY:int = 0 ):AlignObject
		{
			if ( _o is DisplayObjectContainer )
				Align.all( _o as DisplayObjectContainer, position, offsetX, offsetY );
			return this;
		}
		
		/**
		 * Align all children vertically
		 * @param	padding vertical space beetween each child
		 * @return Current AlignObject
		 */
		public function vertical( padding:int = 0 ):AlignObject
		{
			if ( _o is DisplayObjectContainer )
				Align.vertical( _o as DisplayObjectContainer, padding );
			return this;
		}
		
		/**
		 * Align all children horizontally
		 * @param	padding horizontal space beetween each child
		 * @return Current AlignObject
		 */
		public function horizontal( padding:int = 0 ):AlignObject
		{
			if ( _o is DisplayObjectContainer )
				Align.horizontal( _o as DisplayObjectContainer, padding );
			return this;
		}
		
		/**
		 * Align the current object to the left of the target 
		 * @param	target object against which the current object is align
		 * @param	offsetX horizontal offset
		 * @param	offsetY vertical offset
		 * @return Current AlignObject
		 */
		public function leftTo( target:DisplayObject, offsetX:int=0, offsetY:int=0 ):AlignObject
		{
			Align.leftTo( _o, target, offsetX, offsetY );
			return this;
		}
		
		/**
		 * Align the current object to the left of the target 
		 * @param	target object against which the current object is align
		 * @param	offsetX horizontal offset
		 * @param	offsetY vertical offset
		 * @return Current AlignObject
		 */
		public function rightTo( target:DisplayObject, offsetX:int=0, offsetY:int=0 ):AlignObject
		{
			Align.rightTo( _o, target, offsetX, offsetY );
			return this;
		}
		
		/**
		 * Align the current object below the target 
		 * @param	target object against which the current object is align
		 * @param	offsetX horizontal offset
		 * @param	offsetY vertical offset
		 * @return Current AlignObject
		 */
		public function underTo( target:DisplayObject, offsetX:int = 0, offsetY:int = 0):AlignObject
		{
			Align.underTo( _o, target, offsetX, offsetY );
			return this;
		}
		
		/**
		 * Align the current object above the target 
		 * @param	target object against which the current object is align
		 * @param	offsetX horizontal offset
		 * @param	offsetY vertical offset
		 * @return Current AlignObject
		 */
		public function overTo( target:DisplayObject, offsetX:int = 0, offsetY:int = 0):AlignObject
		{
			Align.upperTo( _o, target, offsetX, offsetY);
			return this;
		}
		
		/**
		 * DOESN'T WORK YET - Align the children of the current object by column of specified num
		 * @param	num object on one line
		 * @param	horizontalPadding horizontal padding
		 * @param	verticalPadding vertical padding
		 * @return Current AlignObject
		 */
		public function objectByLine ( num:int , horizontalPadding:int = 0, verticalPadding:int = 0):AlignObject
		{
			//TODO
			return this;
		}
		
		/**
		 * DOESN'T WORK YET - Align the children of the current object by column of specified num
		 * @param	num object on one line
		 * @param	horizontalPadding horizontal padding
		 * @param	verticalPadding vertical padding
		 * @return Current AlignObject
		 */
		public function objectByColumn ( num:int , horizontalPadding:int = 0, verticalPadding:int = 0):AlignObject
		{
			//TODO
			return this;
		}
	}
}