package  {
import flash.display.*;
import flash.text.*;
import flash.utils.*;
import flash.events.*;
import com.urbansquall.metronome.*;

public class Main extends Sprite {
	private var m_ticker : Ticker;
	private var m_timer : Timer;
	private var m_output : TextField;
	
	public function Main()
	{
		var testTicker : Boolean = true;
		
		if( testTicker )
		{
			createTicker();
		}
		else
		{
			createTimer();
		}
		
		m_output = new TextField();
		m_output.autoSize = TextFieldAutoSize.LEFT;
		addChild( m_output );
	}
	
	private function createTicker() : void
	{
		m_ticker = new Ticker( 100 );
		m_ticker.addEventListener( TickerEvent.TICK, tick );
		m_ticker.start();
	}
	
	private function tick( a_event : TickerEvent ) : void
	{
		process( a_event.interval );
	}
	
	private function createTimer() : void
	{
		m_timer = new Timer( 1000 );
		m_timer.addEventListener( TimerEvent.TIMER, time );
		m_timer.start();
	}
	
	private function time( a_event : TimerEvent ) : void
	{
		process( 1000 );
	}
	
	private function createArbitraryDelay() : void
	{
		// just a code intensive function created merely to introduce
		// a delay into the game loop
		var array : Array = new Array();
		var count : int = 100000;
		for( var i : int = 0; i < count; i++ )
		{
			array.push( Math.pow( i, i++ ) );
		}
	}
	
	private function process( a_interval : Number ) : void
	{
		m_output.text = "At time <" + getTimer() + ">, the interval was <" + a_interval +">.\n" + m_output.text;
		
		if( getTimer() > 10000 )
		{
			m_output.text = "KILLED.\n" + m_output.text;
			
			if( m_ticker != null )
			{
				m_ticker.stop();
				m_ticker = null;
			}
			
			if( m_timer != null )
			{
				m_timer.stop();
				m_timer = null;
			}
		}
		
		createArbitraryDelay();
	}
	
} // c
} // p