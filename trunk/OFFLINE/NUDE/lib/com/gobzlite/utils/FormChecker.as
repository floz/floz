package com.gobzlite.utils
{
	/**
	 * Simple tool to check form
	 *
	 * ---------------------
	 * + usage
	 * ---------------------
	 * 
	 * FormChecker.isValidEmail( email:String );
	 * FormChecker.isValidPhone( phone:String );
	 * FormChecker.isValidLenght( text:String, min:int, max ); 
	 * 
	 * ---------------------
	 * + todo
	 * ---------------------
	 * 
	 * improve valide phone number..
	 * 
	 * 
	 * @version 0.1 : first implementation
	 * 
	 * @author David Ronai
	 */
	public class FormChecker
	{
		
		public function FormChecker() 
		{
			throw new Error("You can't create an instance of FormUtility");
		}
		
		public static function isValidEmail(s:String):Boolean 
		{			
            var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
            var result:Object = pattern.exec(s);
            return (result != null);
        }
		
        public static function isValidPhone(s:String):Boolean
		{
            var pattern:RegExp = /^\d{10}$/;
            var result:Object = pattern.exec(s);
            return (result != null);
        }
		
		public static function isValidLenght(s:String, minLenght:uint = 3, maxLenght:uint = 32 ):Boolean
		{
            return (s.length>=minLenght && s.length<=maxLenght);
        }
		
	}

}