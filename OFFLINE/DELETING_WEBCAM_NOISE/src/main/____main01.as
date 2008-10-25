// Conways Game of Life in just three bitmap operations
//
// Author: Mario Klingemann
//         http://www.quasimondo.com
//		   mario@quasimondo.com
//
// Released under Apache License, Version 2.0
// http://www.opensource.org/licenses/apache2.0.php
//
// NOTE: If you republish this code on a website you have to
// add a visible credits link on the same page which looks like this:
//
// Based on code by <a href="http://www.quasimondo.com">Mario Klingemann</a>

package main {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;

	[SWF( width="400",height="800",framerate="60",backgroundColor="#000000")]
	public class main01 extends Sprite
	{
		private var gameMap:BitmapData;
		private var calculationMap:BitmapData;
		
		private var neighbourBlur:BlurFilter;
		private var colorAdd:ColorTransform;
		
		private var rules:Array;
		private var zero:Array;
		
		// Size of game canvas:
		private var w:int = 400;
		private var h:int = 800;
		
		private const origin:Point = new Point();
		private const rect:Rectangle = new Rectangle( 0, 0, w, h );
		
		
		public function main01()
		{
			setup();
			addChild ( new Bitmap( gameMap, "auto", false ));
			randomizeMap();
			 
			//stage.addEventListener( Event.ENTER_FRAME, update );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		}
		
		private function setup():void
		{
			 neighbourBlur = new BlurFilter(3,3,1);
			 colorAdd = new ColorTransform( 1, 1, 1, 1, -254, -254, -254, 0 );
			 
			 gameMap = new BitmapData( w, h, false, 0xffffff );
			 calculationMap = gameMap.clone();
			 
			 zero = [];
			 rules = [];
			 
			// These are the rules:
			 
			 for ( var i:int = 0; i < 256; i++ )
			 {
			 	zero[i] = 0;
			 	rules[i] = 0;
			 }
			 
			 rules[0]   = 0;        // not set, 0 neighbours
			 rules[28]  = 0;        // not set, 1 neighbour
			 rules[56]  = 0;        // not set, 2 neighbours
			 rules[85]  = 0xffffff; // not set, 3 neighbours
			 rules[113] = 0;        // not set, 4 neighbours
			 rules[141] = 0; 		// not set, 5 neighbours
			 rules[170] = 0; 		// not set, 6 neighbours
			 rules[198] = 0; 		// not set, 7 neighbours
			 rules[226] = 0; 		// not set, 8 neighbours
			 
			 rules[29]  = 0;        // set, 0 neighbours
			 rules[57]  = 0;        // set, 1 neighbour
			 rules[86]  = 0xffffff; // set, 2 neighbours
			 rules[114] = 0xffffff; // set, 3 neighbours
			 rules[142] = 0; 		// set, 4 neighbours
			 rules[171] = 0; 		// set, 5 neighbours
			 rules[199] = 0; 		// set, 6 neighbours
			 rules[227] = 0; 		// set, 7 neighbours
			 rules[255] = 0; 		// set, 8 neighbours
			  
		}
		
		private function randomizeMap():void
		{
			calculationMap.perlinNoise(  1 + Math.random() * w * 0.5, 1+ Math.random() * h * 0.5, 1 + int ( 4 * Math.random()), getTimer(), true, Math.random() < 0.5, 4, false );
			gameMap.fillRect( rect, 0xffffff );
			gameMap.threshold( calculationMap, rect, origin, "<", 0x000080, 0x000000, 0x0000ff, false );
		}
		
		// Core Routine
		private function update( event:Event ):void
		{
			// create a separate 3x3 box blur of the current game canvas
			calculationMap.applyFilter( gameMap, rect, origin, neighbourBlur );
			
			// add +1 for every set pixel
			calculationMap.draw( gameMap, null, colorAdd, "add");
			
			// update the canvas based on the rules lookup table
			gameMap.paletteMap( calculationMap, rect, origin, zero, zero, rules );
		}
		
		private function onKeyDown( event:KeyboardEvent ):void
		{
			randomizeMap();
		}
   
	}
}