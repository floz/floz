class HorseConnection extends FCSService
{
	public function showWinner( index:String )
	{
		mx.core.Application.alert( "Horse " + index + " is the winner this time" );
	}

}
