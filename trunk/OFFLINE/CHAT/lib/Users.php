<?php

class Users
{
	private $host = "localhost";
	private $login = "root";
	private $pass = "";
	private $bdd = "stratus";
	private $connection;
	
	public function Users()
	{
		$this->connection = mysql_connect( "localhost", "root", "" );
		if( !$this->connection )
		{
			die( "Impossible de se connecter à la bdd" );
			return false;
		}
		mysql_select_db( "stratus", $this->connection );
		return true;
	}
	
	public function addUser( $datas )
	{		
		return mysql_query( "INSERT INTO users (id, pseudo) VALUES ('".$datas[ 'id' ]."', '".$datas[ 'pseudo' ]."')", $this->connection);
	}
	
	public function deleteUser( $id )
	{
		return mysql_query( "DELETE FROM users WHERE id='".$id."'", $this->connection);
	}
	
	public function close()
	{
		mysql_close();
	}
	
	public function getUserList()
	{
		$list = mysql_query( "SELECT id, pseudo FROM users", $this->connection);
		$return = array();
		while( $donnee = mysql_fetch_assoc( $list ) )
			array_push( $return, $donnee );
		
		return $return;
	}
}

?>