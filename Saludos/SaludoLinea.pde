//
//
//Clase para guardar el total de saludos por el numero de personas
//Tambien guardar la posicion en 'y', en la gráfica
//
//

class SaludoLinea {
  
  public int iTotalSaludos, iNPersonas;
  public float yPosGraph;
  
  SaludoLinea( int _iNPersonas, float rectHeight ) {
    
    iTotalSaludos = this.getTotalSaludos( _iNPersonas );
    iNPersonas = _iNPersonas;
    yPosGraph = this.getPositionGraphLines( iTotalSaludos, rectHeight ); 
    
  }
  
  public int getPosicionGraphX( ) {
   
   return iNPersonas; 
    
  }
  
  private int getTotalSaludos( int nPersonas ) {
    
    return nPersonas * ( nPersonas - 1 ) / 2;
    
  }
  
  private float getPositionGraphLines( int totalSaludos, float rectHeight ) {
    
     float porcentaje = ( totalSaludos * 100 ) / 130;
     float yGraph = ( porcentaje * rectHeight ) / 100;
     return yGraph;
    
  }
  
}
