<?php


//path to storage
$storage = '';

//allow path to be changed dynamically
if($_GET['uploadDir'] != "") {
	$storage = $_GET['uploadDir'];
}

//path name of file for storage
if( empty( $_FILES ) )
{
	echo( "0" );
	return;
}
$uploadfile = "$storage/" . $_FILES['Filedata']['name'];

//if the file is moved successfully
if ( move_uploaded_file( $_FILES['Filedata']['tmp_name'] , $uploadfile ) ) {
	echo( $_FILES['Filedata']['name']);
//file failed to move
}else{
	echo( "0" );
}

?>
