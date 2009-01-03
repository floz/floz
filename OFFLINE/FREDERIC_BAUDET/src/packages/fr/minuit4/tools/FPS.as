
/**
* Written by :
* @author : Floz - Florian Zumbrunn
* www.floz.fr || www.minuit-4.fr
*
* Version log :
* 
* 28.08.08		1.0		Floz		+ Première version
*/
package fr.minuit4.tools 
{
	import flash.system.System;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	public class FPS extends Sprite
	{
		private var background:BitmapData;
		private var fpsBar:Shape;
		private var fpsField:TextField;
		private var frames:String;
		private var memoryBar:Shape;
		private var memoryField:TextField;
		private var memory:String;
		private var msField:TextField;
		private var frameRate:TextField;
		
		private var fps:int;
		private var mem:int;
		private var time:int;
		private var ms:int;
		private var prevTime:int;
		
		/**
		 * Ajoute un outil permettant d'observer les FPS et la mémoire utilisée.
		 */
		public function FPS() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
			
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ENTER_FRAME, onFrame );
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			background = new BitmapData( 150, 50, false, 0x000000 );
			var bmp:Bitmap = new Bitmap( background );
			addChild( bmp );
			
			fpsBar = new Shape();
			fpsBar.graphics.beginFill( 0xFF0000 );
			fpsBar.graphics.drawRect( 5, 20, 1, 8.5 );
			fpsBar.graphics.endFill();
			
			memoryBar = new Shape();
			memoryBar.graphics.beginFill( 0x33DD33 );
			memoryBar.graphics.drawRect( 5, 35, 1, 8.5 );
			memoryBar.graphics.endFill();
			
			background.draw( fpsBar );
			background.draw( memoryBar );
			
			var format:TextFormat = new TextFormat( "_sans", 9 );
			
			fpsField = new TextField();
			memoryField = new TextField();
			msField = new TextField();
			frameRate = new TextField();
			
			fpsField.defaultTextFormat = memoryField.defaultTextFormat = msField.defaultTextFormat = frameRate.defaultTextFormat = format;
			fpsField.selectable = memoryField.selectable = msField.selectable = frameRate.selectable = false;		
			
			fpsField.x = fpsBar.x + fpsBar.width + 7;
			fpsField.y = 17;
			fpsField.textColor = 0xFF0000;
			fpsField.text = "FPS : ...";
			addChild( fpsField );
			
			memoryField.x = memoryBar.x + memoryBar.width + 7;
			memoryField.y = 31.5;
			memoryField.textColor = 0x33DD33;
			memoryField.text = "MEM : ...";
			addChild( memoryField );
			
			msField.x = 5;
			msField.textColor = 0xBBBBBB;
			msField.text = "MS : ...";
			addChild( msField );
			
			frameRate.x = 79;
			frameRate.textColor = 0xBBBBBB;
			frameRate.text = "Frame rate : " + stage.frameRate.toString();
			addChild( frameRate );
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onFrame(e:Event):void 
		{
			time = getTimer();
			
			fps++;
			
			if ( time - 1000 > prevTime )
			{
				prevTime = getTimer();
				
				mem = int( System.totalMemory / 1048576 );
				
				fpsBar.graphics.clear();
				fpsBar.graphics.beginFill( 0xFF0000 );
				fpsBar.graphics.drawRect( 5, 20, getFPSPercent( fps ), 8.5 );
				fpsBar.graphics.endFill();
				
				memoryBar.graphics.clear();
				memoryBar.graphics.beginFill( 0x33DD33 );
				( mem > 100 ) ? memoryBar.graphics.drawRect( 5, 35, 100, 8.5 ) : memoryBar.graphics.drawRect( 5, 35, mem, 8.5 );
				memoryBar.graphics.endFill();
				
				background.fillRect( background.rect, 0x000000 );
				background.draw( fpsBar );
				background.draw( memoryBar );
				
				fpsField.x = fpsBar.x + fpsBar.width + 7;
				memoryField.x = memoryBar.x + memoryBar.width + 7;
				
				fpsField.text = "FPS : " + fps.toString();
				memoryField.text = "MEM : " + mem.toString();
				
				fps = 0;
			}
			
			msField.text = "MS : " + ( time - ms );
			ms = time;
		}
		
		// PRIVATE
		
		private function getFPSPercent( value:Number ):Number
		{
			return ( ( 100 * value ) / stage.frameRate );
		}
		
		// PUBLIC
	}
	
}