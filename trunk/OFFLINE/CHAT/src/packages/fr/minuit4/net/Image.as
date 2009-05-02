/**
 * @author : Arno - Arnaud NICOLAS
 * @version : 1.0
 * Name : Image
 * 
	Code à mettre dans le fichier php (PHP_FILE):
	
	<?php
	if (isset($GLOBALS["HTTP_RAW_POST_DATA"]))
	{
		$jpg = $GLOBALS["HTTP_RAW_POST_DATA"];
		$m = imagecreatefromstring($jpg);
		switch($_GET['type'])
		{
			case "JPG":
				imagejpeg($m,$_GET['name'],100);
				break;
			case "PNG":
				imagepng($m, $_GET['name']);
				break;
			default :
				exit();
				break;
		}
		header("Location:".$_GET['name']);
	}
	?>
 * 
 */
package fr.minuit4.net 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.net.navigateToURL;
	import flash.utils.ByteArray;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLRequestHeader;
	
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	
	public class Image 
	{
		static public const EXT_JPG:String = ".jpg";
		static public const EXT_PNG:String = ".png";
		
		static public const FORMAT_JPG:String = "JPG";
		static public const FORMAT_PNG:String = "PNG";
		
		static public var PHP_FILE:String = "SaveImage.php";
		
		static public var SERVEUR:String = "http://localhost/BEATLIZER/bin/";
		
		static public function save(pDisplayObject:DisplayObject = null, serveur:String = null, pName:String = null, pType:String = FORMAT_JPG):URLRequest
		{
			if ( !serveur ) throw new Error ( "aucun serveur bouboup" );
			Image.SERVEUR = serveur;
			if (!pDisplayObject) return null;
			if (!pName) pName = "image_" + Math.round(Math.random() * (999999) + 1);
			
			var bd:BitmapData = new BitmapData(pDisplayObject.width, pDisplayObject.height);
			bd.draw(pDisplayObject);
			
			var bArray:ByteArray;
			var ext:String;
			
			switch(pType)
			{
				case FORMAT_JPG:
					ext = EXT_JPG;
					var jpg:JPGEncoder = new JPGEncoder(100);
					bArray = jpg.encode(bd);
					break;
				case FORMAT_PNG:
					ext = EXT_PNG;
					bArray = PNGEncoder.encode(bd);
					break;
				default : 
					return null;
					break;
			}
			var header:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
			var urlR:URLRequest = new URLRequest(SERVEUR + PHP_FILE + "?name=" + pName + ext + "&type=" + pType);
			urlR.requestHeaders.push(header);
			urlR.method = URLRequestMethod.POST;
			urlR.data = bArray;
			return urlR;
		}
	}
}