﻿
/**
* Written by :
* @author : Floz - Florian Zumbrunn
* Version log :
* 
* 28.08.08		1.0		Floz		+ Première version
*/
package fr.minuit4.utils 
{
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * Classe de méthodes en rapport avec les outils TextField/String : du texte en général.
	 */
	public class UText 
	{
		/**
		 * Renvoie un TextField prédéfinis.
		 * @param	width		Number		Largeur du texte.
		 * @param	height		Number		Hauteur du texte.
		 * @param	multiline	Boolean		Si le texte est multiligne ou non.
		 * @param	selectable	Boolean		Si l'on peut sélectionner le texte ou non.
		 * @return
		 */
		static public function text( width:Number, height:Number,  multiline:Boolean = true, selectable:Boolean = false ):TextField
		{
			var field:TextField = new TextField();
			field.width = width;
			field.height = height;
			field.wordWrap = multiline;
			field.multiline = multiline;
			field.selectable = selectable;
			
			return field;
		}
		
		
		/**
		 * Renvoie un TextFormat prédéfinis.
		 * @param	font	String	Font à utliser.
		 * @param	size	Number	Taille de la Font du texte.
		 * @param	color	uint	Couleur du texte.
		 * @return
		 */
		static public function format( font:String = "Verdana", size:Number = 10, color:uint = 0x000000 ):TextFormat
		{
			var format:TextFormat = new TextFormat();
			format.font = font;
			format.size = size;
			format.color = color;
			
			return format;
		}
		
		
		/**
		 * Remplace les caractères accentués les plus couramment utilisés par des caractères non accentués.
		 * @param	t	String	Texte à analyser.
		 * @return
		 */
		static public function replace( t:String ):String
		{
			var i:int = t.search( /[àâèéêëêÉÈËÂÁ]/g );
			if ( i >= 0 )
			{
				t = t.replace( /[èéëê]/g, "e").replace( /[ÉÈËÊ]/g, "E" );
				t = t.replace( /[àâ]/g, "a").replace( /[ÂÁ]/g, "A" );
			}
			i = 0;
			
			i = t.search( /[ôöîïùüÖÔÏÎÛÙ]/g );
			if ( i >= 0 )
			{
				t = t.replace( /[ôö]/g, "o").replace( /[ÖÔ]/g, "O" );
				t = t.replace( /[îï]/g, "i").replace( /[ÏÎ]/g, "I" );
				t = t.replace( /[ùü]/g, "u").replace( /[ÛÙ]/g, "U" );
			}
			
			return t;
		}
		
		/**
		 * Méthode de création et de paramétrage d'un nouveau textField
		 * 
		 * @param	pParams		Object		propriétés du textField
		 * @param	pJustFormat	TextField	textField à formater
		 * @return	TextField
		 */
		static public function newTextField(pParams:Object, pJustFormat:TextField = null):TextField
		{
			var t:TextField = !pJustFormat?new TextField():pJustFormat;
			for (var i:String in pParams)
				t[i] = pParams[i];
			return t;
		}
		
		static public function isMailValid( mail:String ):Boolean
		{
			//^[^a-z0-9][a-z0-9_\.\-]*[a-z0-9]@^[^a-z0-9][a-z0-9\.\-]*[a-z0-9](\.[a-z]{2-7}){1,2}$/i;
			
			var regexp:RegExp = /^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			return regexp.test( mail );
		}
		
		static public function isTextNumber( value:String ):Boolean
		{
			var regexp:RegExp = /^[0-9]*$/i;
			return regexp.test( value );
		}
	}
}




