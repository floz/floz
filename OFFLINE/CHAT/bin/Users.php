<?php

class Users
{
	private $host = "mysql5-6";
	private $login = "flozjsxc";
	private $pass = "ytJQKvTa";
	private $bdd = "users";
	private $connection;
	
	public function Users()
	{
		$this->connection = mysql_connect( "mysql5-6", "flozjsxc", "ytJQKvTa" );
		if( !$this->connection )
		{
			die( "Impossible de se connecter à la bdd" );
			return false;
		}
		mysql_select_db( "users", $this->connection );
		return true;
	}
	
	public function addUser( $datas )
	{		
		return mysql_query( "INSERT INTO flozjsxc.users (id, pseudo) VALUES ('".$datas[ 'id' ]."', '".$datas[ 'pseudo' ]."')", $this->connection);
	}
	
	public function deleteUser( $id )
	{
		return mysql_query( "DELETE FROM flozjsxc.users WHERE id='".$id."'", $this->connection);
	}
	
	public function close()
	{
		mysql_close();
	}
	
	public function getUserList()
	{
		$list = mysql_query( "SELECT id, pseudo FROM flozjsxc.users", $this->connection);
		$return = array();
		while( $donnee = mysql_fetch_assoc( $list ) )
			array_push( $return, $donnee );
		
		return $return;
	}
}

?>