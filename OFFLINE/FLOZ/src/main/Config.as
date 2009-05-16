
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import assets.Fonts;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.StyleSheet;
	
	public class Config 
	{
		// Debug mode
		public static const DEBUG:Boolean = false;
		
		// Rubriques & Menu infos
		public static const HOME:String = "home";
		public static const WORKS:String = "works";
		public static const LAB:String = "lab";
		public static const ABOUT:String = "about";
		public static const DETAILS:String = "details";
		public static const RUBRIQUES:Array = [ Config.HOME, Config.WORKS, Config.LAB, Config.ABOUT ];
		
		// Les informations des différentes rubriques
		public static const worksDatas:Array = [];
		public static const labDatas:Array = [];
		public static const aboutDatas:Object = {};
		
		// Les chemins d'accès aux fichiers nécessaires
		public static var path_swf:String;
		public static var path_xml:String;
		public static var path_css:String;
		public static var path_img:String; // Chemin des images
		public static var path_works:String; // Chemin du dossier works contenu dans img
		public static var path_lab:String; // Chemin du dossier lab contenu dans img
		
		public static var cntMain:Sprite; // Conteneur des différentes rubriques
		public static var background:BitmapData;
		public static var styleSheet:StyleSheet;
		
		public static var currentSection:String;
		public static var detailsSection:String;
		public static var detailsId:int;
		public static var detailsTitle:String;
		
		public static const glowFilter:GlowFilter = new GlowFilter( 0x142927, .75, 4, 4, 1.8, 3 );
	}
	
}