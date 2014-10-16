//
//
//
///Código por Maxmiliano Oviedo
///13/10/2014
//
///Graficar el total de saludos
//
///Para agregar números de personas
//desde la letra a minus., 
//hasta la tecla p minus.
//
//



Graficacion oGraficacion;

void setup( ) {

  size( 1024, 730 );

  oGraficacion = new Graficacion( new PVector( width / 2, 200 ), 180 );

  this.setSomeInitialSaludos( );
}

void setSomeInitialSaludos( ) {

  IntList aInitSaludos = new IntList( );

  for ( int i = 1; i < 17; ++i ) aInitSaludos.append( i ); 
  aInitSaludos.shuffle( );

  for ( int i = 0; i < 5; i++ ) this.agregarSaludo( aInitSaludos.get( i ) );
}

void agregarSaludo( int nPersonas ) {
  background( 233 );
  oGraficacion.graficarSaludos( nPersonas );
}

void draw( ) {
}

public void keyPressed( ) {
  if ( keyCode >= 65 && keyCode <= 80 ) this.ingresarSaludo( );
}

public void ingresarSaludo( ) {
  int personas = keyCode - 64;
  this.agregarSaludo( personas );
}

