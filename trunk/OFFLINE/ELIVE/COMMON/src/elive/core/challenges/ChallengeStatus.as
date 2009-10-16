
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.core.challenges 
{
	
	public class ChallengeStatus 
	{
		private static const ELIVE_STATUS:String = "elive_status::";
		
		public static const PENDING:String = ELIVE_STATUS + "pending";
		public static const CURRENT:String = ELIVE_STATUS + "current";
		public static const ENDED_WON:String = ELIVE_STATUS + "ended_won";
		public static const ENDED_LOST:String = ELIVE_STATUS + "ended_lost";
		public static const ENDED_REFUSED:String = ELIVE_STATUS + "ended_refused";
	}
	
}