<?php
if (isset($GLOBALS["HTTP_RAW_POST_DATA"]))
{
	$jpg = $GLOBALS["HTTP_RAW_POST_DATA"];
	$m = imagecreatefromstring($jpg);
	imagejpeg($m, "dossier/de/ton/upload/tonfichier.jpg", 100);
	echo( "bouboup" );
}
?>