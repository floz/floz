
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.xmls 
{
	import elive.core.challenges.Challenge;
	import elive.core.comments.Comment;
	import elive.core.groups.Group;
	import elive.core.users.User;
	import elive.core.users.UserStats;
	
	public class EliveXML 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const USER:String = "user";
		public static const CHALLENGE:String = "action";
		public static const COMMENT:String = "comment";
		public static const GROUP:String = "list";
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Renvoie un User.
		 * @param	datas	XML	Le noeud XML à partir du quel la rechercher sera faite.
		 * @return	User
		 */
		public static function parseUser( datas:XML ):User
		{
			if ( !datas ) return null;
			
			var stats:XMLList = datas.stats;			
			
			var user:User = new User();
			user.config( datas.id || datas.@id, datas.login, datas.location, datas.points, datas.url );			
			user.setStats( new UserStats( stats.pending, stats.current, stats.refused, stats.lost, stats.bad, stats.won ) );
			
			return user;
		}
		
		/**
		 * Renvoie un Vector qui contient des User.
		 * @param	datas	XML	Le noeud XML à partir du quel la rechercher sera faite.
		 * @param	scanDeeper	Boolean	Si vrai, la recherche sera aussi faite sur tous les enfants.
		 * @return	Vector.<User>
		 */
		public static function parseUsers( datas:XML, scanDeeper:Boolean = false ):Array
		{
			if ( !datas ) return null;
			
			var list:XMLList = !scanDeeper ? datas.children() : datas.descendants();
			list = list.( localName() == USER );
			
			var n:int = list.length();
			
			var users:Array = [];
			if ( n == 0 ) return users;
			
			for ( var i:int; i < n; ++i )
				users[ i ] = parseUser( list[ i ] );
			
			return users;
		}
		
		/**
		 * Renvoie un Challenge.
		 * @param	datas	XML	Le noeud XML à partir du quel la rechercher sera faite.
		 * @return	Challenge
		 */
		public static function parseChallenge( datas:XML ):Challenge
		{
			if ( !datas ) return null;
			
			var challenge:Challenge = new Challenge();
			challenge.config( datas.id || datas.@id, datas.title, datas.details, datas.end );
			challenge.setStatus( datas.status );
			challenge.setSender( parseUser( datas.sender.user[ 0 ] ) );
			challenge.setMediasUrls( parseMedias( datas.medias[ 0 ] ) );
			challenge.setTargets( parseUsers( datas.targets[ 0 ], true ) );
			challenge.setComments( parseComments( datas.comments[ 0 ] ) );
			
			return challenge;
		}
		
		/**
		 * Renvoie un Vector qui contient des Challenges.
		 * @param	datas	XML	Le noeud XML à partir du quel la rechercher sera faite.
		 * @param	scanDeeper	Boolean	Si vrai, la recherche sera aussi faite sur tous les enfants.
		 * @return	Vector.<Challenge>
		 */
		public static function parseChallenges( datas:XML, scanDeeper:Boolean = false ):Array
		{
			if ( !datas ) return null;
			
			var list:XMLList = !scanDeeper ? datas.children() : datas.descendants();
			list = list.( localName() == CHALLENGE );
			
			var n:int = list.length();
			
			var challenges:Array = [];
			if ( n == 0 ) return challenges;
			
			for ( var i:int; i < n; ++i )
				challenges[ i ] = parseChallenge( list[ i ] );
			
			return challenges;
		}
		
		/**
		 * Renvoie un objet de type Vector qui contient des String.
		 * Ces chaines de caractères correspondent aux urls des medias à télécharger.
		 * @param	datas	XML	Le noeud medias.
		 * @param	type	String	Le type de médias à récupérer. (Constantes dans MediasEnum)
		 * @return	Vector.<String>	La chaine des urls.
		 */
		public static function parseMedias( datas:XML, type:String = "picture" ):Array
		{
			if ( !datas ) return null;
			
			var list:XMLList = datas.children().( localName() == type );
			var n:int = list.length();
			
			if ( n == 0 ) return new Vector.<String>( n, true );
			
			var medias:Array = [];
			for ( var i:int; i < n; ++i )
				medias[ i ] = list[ i ].@url;
			
			return medias;
		}
		
		/**
		 * Renvoie un Comment.
		 * @param	datas	XML	Le noeud XML à partir du quel la rechercher sera faite.
		 * @return	Comment
		 */
		public static function parseComment( datas:XML ):Comment
		{
			var comment:Comment = new Comment();
			comment.config( datas.text, datas.date );
			comment.setUser( parseUser( datas.user[ 0 ] ) );
			
			return comment;
		}
		
		/**
		 * Renvoie un Vector qui contient des Comment.
		 * @param	datas	XML	Le noeud XML à partir du quel la rechercher sera faite.
		 * @param	scanDeeper	Boolean	Si vrai, la recherche sera aussi faite sur tous les enfants.
		 * @return	Vector.<Comment>
		 */
		public static function parseComments( datas:XML, scanDeeper:Boolean = false ):Array
		{
			if ( !datas ) return null;
			
			var list:XMLList = !scanDeeper ? datas.children() : datas.descendants();
			list = list.( localName() == COMMENT );
			
			var n:int = list.length();
			
			var comments:Array = [];
			if ( n == 0 ) return comments;
			
			for ( var i:int; i < n; ++i )
				comments[ i ] = parseComment( list[ i ] );
			
			return comments;
		}
		
		public static function parseGroup( datas:XML ):Group
		{
			if ( !datas ) return null;
			
			var group:Group = new Group( datas.id, datas.name );
			group.setMembers( parseUsers( datas.users[ 0 ] ) );
			
			return group;
		}
		
		public static function parseGroups( datas:XML, scanDeeper:Boolean = false ):Array
		{
			if ( !datas ) return null;
			
			var list:XMLList = !scanDeeper ? datas.children() : datas.descendants();
			list = list.( localName() == GROUP );
			
			var n:int = list.length();
			
			var groups:Array = [];
			if ( n == 0 ) return groups;
			
			for ( var i:int; i < n; ++i )
				groups[ i ] = parseGroup( list[ i ] );
			
			return groups;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}