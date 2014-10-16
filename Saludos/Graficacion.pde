
//
//
//Clase para hacer dos gráficas
//Gráfica circular con el total de conexiones entre el total de personas
//Gráfica de líneas, para llevar el historial de los saludos
//
//

class Graficacion {

  private PVector _vecCenter, _vecGraphSize, _vecGraphPosition;
  private float _fRadius, _PI, _fTheta, _fRadiansSumar, _fStartRadians, _fPaddingGraph;
  private int _iSumaColor, _index;
  private ArrayList<SaludoLinea> _aSaludos;
  private PImage _imgPersona;


  Graficacion( PVector center, float radius ) {

    _vecCenter = center;

    _vecGraphSize = new PVector( width - 300, ( height / 22 ) * 8 );
    _vecGraphPosition =  new PVector( ( width - _vecGraphSize.x ) / 2, ( height / 12 ) * 7 );

    _fRadius = radius;
    _PI = 3.14159265;
    _fTheta = ( 90 * _PI ) / 180;
    _fRadiansSumar = 0;
    _fStartRadians = 0;
    _fPaddingGraph = ( _vecGraphSize.x - 10 ) / 16;
    _iSumaColor = 0;
    _index = 0;
    
    _imgPersona = loadImage( "persona.png" );
    imageMode( CENTER );

    _aSaludos = new ArrayList<SaludoLinea>( );
  }

  public void graficarSaludos( int nPersonas ) {

    if ( !this.testEntradaDato( nPersonas ) ) return;
    this.prepararTotalSaludos( nPersonas );
    this.graficarTotalSaludosCirculo( nPersonas );
    this.cleanGraph( );
    this.graficarTotalSaludosLineas( nPersonas );
    this.drawTexts( );
  }

  private boolean testEntradaDato( int nPersonas ) {

    if ( nPersonas > 16 || nPersonas < 1 ) return false;

    return true;
  }

  private void prepararTotalSaludos( int nPersonas ) {

    _fRadiansSumar = ( ( 360 / nPersonas ) * _PI ) / 180;
    _fStartRadians = _fTheta;
    _iSumaColor = 440 / ( nPersonas );
  }

  private void graficarTotalSaludosCirculo( int nPersonas ) {

    for ( int i = nPersonas - 1; i >= 0; --i ) {

      _fStartRadians += _fRadiansSumar;

      float x = _fRadius * cos( _fStartRadians );
      float y = _fRadius * sin( _fStartRadians );

      if ( nPersonas == 1 ) y = 0;

      for ( int j = 0; j < i; ++j ) {

        float fRadiansLinea = _fStartRadians + ( _fRadiansSumar * ( j + 1 ) );

        float x1 = _fRadius * cos( fRadiansLinea );
        float y1 = _fRadius * sin( fRadiansLinea );

        float fColorRed = ( _iSumaColor * i ) > 220 ? 235 : _iSumaColor * i;
        float fColorGreen = ( _iSumaColor * i ) > 220 ? ( _iSumaColor * i ) - 220 : 0;
        stroke( fColorRed, fColorGreen, 125 - ( i * 5 ) );
        strokeWeight( 2 );   
        line( _vecCenter.x + x, _vecCenter.y + y, _vecCenter.x + x1, _vecCenter.y + y1 );
      }

      fill( 100, 255 - ( i * 25 ), 70 );
      ellipse( _vecCenter.x + x, _vecCenter.y + y, 5, 5 );
      image( _imgPersona, _vecCenter.x + ( x  ), _vecCenter.y + ( y  ) );
    }
  }

  private void cleanGraph( ) {

    fill( 44 );
    noStroke( );
    rect( _vecGraphPosition.x, _vecGraphPosition.y, _vecGraphSize.x, _vecGraphSize.y );
    this.graphicDataNumbers( );
  }

  private void graphicDataNumbers( ) {

    int iEscala = 0;
    for ( int i = 0; i <= 16; ++i ) {
      
      fill( 9, 44, 55 );
      textSize( 12 );
      textAlign( CENTER );
      text( i, ( _fPaddingGraph * ( i ) ) + _vecGraphPosition.x, _vecGraphSize.y + _vecGraphPosition.y + 15 );
      
      if ( i < 9 ) {
        textSize( 12 );
        float yGraph = ( ( ( iEscala * 100 ) / 130 ) * _vecGraphSize.y ) / 100;
        text( iEscala, _vecGraphPosition.x - 15, _vecGraphSize.y + _vecGraphPosition.y - yGraph  );
        iEscala += 15;
      }
      
    }
    fill( 255, 70, 90 );
    textSize( 16 );
    text( "Saludos", _vecGraphPosition.x - 65, _vecGraphPosition.y );
    text( "Personas", _vecGraphPosition.x + 45 + _vecGraphSize.x, _vecGraphPosition.y + _vecGraphSize.y + 28 );
  }

  private void graficarTotalSaludosLineas( int nPersonas ) {

    int iTamano = _aSaludos.size( );

    for ( int i = 0; i <= iTamano; ++i ) {

      if ( nPersonas > 0 && ( i >= _aSaludos.size( ) || nPersonas < _aSaludos.get( i ).iNPersonas ) ) {

        this.ingresarSaludoAtIndex( i, nPersonas, i - 1 );
        _index = i;
        nPersonas = 0;
      } else {
        float yPosLast = i == 0 ? 0 : _aSaludos.get( i - 1 ).yPosGraph;
        float iNLastPersonas = i == 0 ? 0 : _aSaludos.get( i - 1 ).getPosicionGraphX( );
        this.paintGraphLine( new PVector( _fPaddingGraph * _aSaludos.get( i ).getPosicionGraphX( ), _aSaludos.get( i ).yPosGraph ), new PVector( _fPaddingGraph * iNLastPersonas, yPosLast ), i );
      }
    }
  }

  private void ingresarSaludoAtIndex( int index, int nPersonas, int lastIndex ) {

    float yPosLast = lastIndex < 0 ? 0 : _aSaludos.get( lastIndex ).yPosGraph;
    float iNLastPersonas = lastIndex < 0 ? 0 : _aSaludos.get( lastIndex ).getPosicionGraphX( );

    if ( index >= _aSaludos.size( ) )
      _aSaludos.add( new SaludoLinea( nPersonas, _vecGraphSize.y ) );
    else 
      _aSaludos.add( index, new SaludoLinea( nPersonas, _vecGraphSize.y ) );

    this.paintGraphLine( new PVector( _fPaddingGraph * (nPersonas), _aSaludos.get( index ).yPosGraph ), new PVector( _fPaddingGraph * iNLastPersonas, yPosLast ), index );
  }

  private void paintGraphLine( PVector pos, PVector lastPoint, int index ) {

    stroke( 20, 180, 190 );
    strokeWeight( 1 );
    line( _vecGraphPosition.x + lastPoint.x, _vecGraphSize.y + _vecGraphPosition.y - lastPoint.y, pos.x + _vecGraphPosition.x, _vecGraphPosition.y + _vecGraphSize.y - pos.y );

    fill( 233, 233, 33 );
    noStroke( );
    ellipse( _vecGraphPosition.x + pos.x, _vecGraphPosition.y + _vecGraphSize.y - pos.y, 5, 5);
    
    fill( 222, 22, 126 );
    textSize( 8 );
    text( _aSaludos.get( index ).iTotalSaludos, _vecGraphPosition.x + pos.x + 15, _vecGraphPosition.y + _vecGraphSize.y - pos.y + 8 );
  }

  private void drawTexts( ) {

    fill( 33 );
    textAlign( LEFT );
    textSize( 18 );
    text( "Número de Personas " + _aSaludos.get( _index ).iNPersonas, 20, 30 );
    fill( 33, 55, 60 ); 
    text( "Total de Saludos " + _aSaludos.get( _index ).iTotalSaludos, 20, 60 );
  }
}

