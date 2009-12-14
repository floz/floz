package com.bigarobas.ui.skin.default {
	import com.bigarobas.display.GraphicSprite;
	import com.bigarobas.ui.skin.ComponentSkin;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class ComponentSkinDefault extends ComponentSkin{
		
		public function ComponentSkinDefault() {
			_defaultTextFormat = new TextFormat("tahoma", 9, 0x000000, null, null, null, null, null, null, null, null, null, 1 );
			
			var tbg:GraphicSprite = new GraphicSprite();
			tbg.fillColor = 0xFFFFFF;
			tbg.lineColor = 0x000000;
			tbg.lineAlpha = 1;
			tbg.fillAlpha = 1;
			tbg.drawRect(100, 100);
			tbg.scale9Grid = new Rectangle(10, 10, 80, 80);
			_background = tbg;

			_foreground = new Sprite();
		}
		
	}
	
}