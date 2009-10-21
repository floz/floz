package main
{
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	
	public class Main extends MovieClip
	{
		public var ticker:MovieClip;
		private var _btRight:SimpleButton;
		private var _cntTextes:MovieClip;
		private var _datas:Datas;
		
		private var _dateActuelle:Number;
		private var _dates:Array;
		private var _currentIdx:int;
		private var _infos:Array;
		private var _currentInfos:Array;
		
		private var _txt:String;
		private var _finPhase:Number;
		private var _compteur:Boolean;
		private var _textWidth:int;
		private var _txt1:TextField;
		private var _txt2:TextField;
		private var _txt3:TextField;
		
		private var _args:Array;
		private var _request:URLRequest;
		
		private var _dAct:Date;
		private var _dFin:Date;
		private var _heure:int;
		private var _min:int;
		private var _timer:Timer;
		private var _txtMorceaux:Array;
		private var _txtMorceauxTaille:int;
		
		public function Main () 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENT
		
		private function onAddedToStage( e:Event ):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			_btRight = ticker.ButtonRight;
			
			_cntTextes = ticker.affichage.cnt;
			
			_datas = new Datas( path_xml );
			_datas.addEventListener( Datas.COMPLETE, onDatasComplete );
			_datas.load();			
		}
		
		private function onRemovedFromStage( e:Event ):void 
		{			
			_timer.removeEventListener( TimerEvent.TIMER, chgtText );
			_timer = null;
			
			_btRight.removeEventListener( MouseEvent.CLICK, onBtClicked );
		}
		
		private function onDatasComplete(e:Event):void 
		{
			_datas.removeEventListener( Datas.COMPLETE, onDatasComplete );
			
			_dAct = new Date();
			_dateActuelle = _dAct.getTime();
			
			_dates = _datas.getDates();
			
			_currentIdx = getIndex();
			if ( _currentIdx < 0 ) return;
			
			_infos = _datas.getInfos();
			_currentInfos = _infos[ _currentIdx ];
			
			initialize();
		}
		
		private function onTextFrame( e:Event ):void 
		{
			e.target.x -= 2;
			
			if ( e.target.x < -( e.target.width + 5 ) ) e.target.x = ( _textWidth * 2 ) + 5*2;
		}
		
		private function onBtClicked(e:MouseEvent):void 
		{
			if ( _currentInfos[ 3 ] == "js" )
			{
				trace ( "JavaScript" );
				var t:String = _currentInfos[ 5 ];
				_args = t.split( "|" );
				
				ExternalInterface.call( _currentInfos[ 4 ], _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ] );
			} 
			else
			{
				trace ( "HTML" );
				_request = new URLRequest( _currentInfos[ 2 ] );
				navigateToURL( _request, "_blank" );
			}
		}
		
		private function chgtText( e:TimerEvent ):void 
		{
			trace ( "------------------------------------ \n" );
			trace( "_dAct.getTime() : " + _dAct.getTime() );
			trace( "_dFin.getTime() : " + _dFin.getTime() );
			
			trace( "_dAct : " + _dAct );
			trace( "_dFin : " + _dFin );
			
			if ( _dAct.getTime() < _dFin.getTime() )
			{
				trace ( "Date actuelle inférieure à la date finale" );
				defineText();
			}
			else
			{
				trace ( "Date actuelle supérieure à l'ancienne date finale" );
				_timer.reset();
				_timer.removeEventListener( TimerEvent.TIMER, chgtText );
				_timer = null;
				
				_btRight.removeEventListener( MouseEvent.CLICK, onBtClicked );
				
				var t:TextField;
				var i:int = 0;
				for each ( t in _cntTextes )
					t.removeEventListener( Event.ENTER_FRAME, onTextFrame );
					
				_dateActuelle = 0;
				_dAct = null;
				_currentIdx = 0;
				_infos = null;
				_currentInfos = null;
				
				//
				
				_dAct = new Date();
				_dateActuelle = _dAct.getTime();
				
				_currentIdx = getIndex();
				if ( _currentIdx < 0 ) return;
				
				_infos = _datas.getInfos();
				_currentInfos = _infos[ _currentIdx ];
				
				if ( _currentInfos[ 4 ] == "refreshPromoJeu" )
				{
					trace ( "Cas : Vrai" );
					ExternalInterface.call( _currentInfos[ 4 ] );
				}
				else
				{
					trace ( "Cas : faux" );
					initialize();
				}
			}
		}
		
		// PRIVATE
		
		private function initialize():void
		{
			while ( _cntTextes.numChildren ) _cntTextes.removeChildAt( 0 );
			
			_txt = _currentInfos[ 0 ];
			( _txt.indexOf( "#" ) > 0 ) ? compteurOn() : ( _compteur = false );
			
			_finPhase = _dates[ _currentIdx ][ 1 ] * 1000;			
			_dFin = new Date( _finPhase );
			
			_txt1 = new TextField;
			_cntTextes.addChild( _txt1 );	
			
			_txt2 = new TextField;
			_cntTextes.addChild( _txt2 );
			
			_txt3 = new TextField;
			_cntTextes.addChild( _txt3 );
			
			defineText();
			
			var i:int = 0;
			var fin:int = _cntTextes.numChildren;
			var t:TextField;
			for ( i; i < fin; i++ )
			{
				t = _cntTextes.getChildAt( i ) as TextField;
				t.autoSize = "left";
				t.y = 5;
				t.x = ( i != 0 ) ? ( _cntTextes.getChildAt( i - 1 ).x + _cntTextes.getChildAt( i - 1 ).width + 5 ) : 0;
				t.addEventListener( Event.ENTER_FRAME, onTextFrame );
			}
			
			_textWidth = _txt1.width;
			
			t = null;
			
			_timer = new Timer( 1000 * 60 );
			_timer.addEventListener( TimerEvent.TIMER, chgtText );
			_timer.start();
			
			_btRight.addEventListener( MouseEvent.CLICK, onBtClicked );
		}
		
		private function compteurOn():void
		{
			_compteur = true;
			
			_txtMorceaux = new Array;
			_txtMorceaux = _txt.split( "#" );
			_txtMorceauxTaille = _txtMorceaux.length;
		}
		
		private function defineText():void
		{
			_dAct = new Date();
			
			if ( _compteur == true )
			{
				_heure = ( _dFin.getDay() - _dAct.getDay() ) * 24 + ( _dFin.getHours() - _dAct.getHours() );				
				_min = ( 60 - _dAct.getMinutes() ) + _dFin.getMinutes();
				
				if ( _heure != 0 ) _heure--;				
				if ( _min > 59 ) _min = _min - 60;
				
				_txtMorceaux[ 1 ] = _heure + "h " + _min + "min";
				
				_txt1.htmlText = _txt2.htmlText = _txt3.htmlText = "<b><font face='Tahoma' size='13' color='#e4001c'>"
				for ( var i:int = 0; i < _txtMorceauxTaille; i++ )
					_txt1.htmlText = _txt2.htmlText = _txt3.htmlText += _txtMorceaux[ i ];
					
				_txt1.htmlText = _txt2.htmlText = _txt3.htmlText += " </font><font face='Tahoma' size='13' color='#454545'>-</font>";
				
				_textWidth = _txt1.width;
			}
			else
			{
				_txt1.htmlText = _txt2.htmlText = _txt3.htmlText = "<b><font face='Tahoma' size='13' color='#e4001c'>" + _txt + " </font><font face='Tahoma' size='13' color='#454545'>-</font></b>";
			}
		}
		
		private function getIndex():int
		{			
			var i:int;
			var fin:int = _dates.length;
			for ( i; i < fin; i++ )
			{
				if ( _dateActuelle > _dates[ i ][ 0 ] * 1000 && _dateActuelle < _dates[ i ][ 1 ] * 1000 ) return i;
			}
			
			return -1;
		}
		
		private function get path_xml():String
		{
			return loaderInfo.parameters[ "path_xml" ] || "http://nrjv4.intranet/dynamic/xml_promo_jeux.php";
			//return loaderInfo.parameters[ "path_xml" ] || "datas.xml";
		}
		
		// PUBLIC
		
	}
}