<?php

mysql_connect( "localhost", "diner", "diner" ) or die ( "Erreur de connection" );
mysql_select_db( "diner" ) or die ( "Erreur lors de la sélection de la database" );

$mail = mysql_real_escape_string(stripslashes($_POST['mail']));

$requete = "INSERT INTO liste_mails( mails ) VALUES ( '$mail' )";
if ( mysql_query( $requete ) )
{
	trace( "Succès !" );
}
else
{
	trace ( "Echec de l'ajout" );
}

function trace( $text )
{
	echo( $text );
}

?>