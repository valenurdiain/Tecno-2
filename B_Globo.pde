class Globo extends FBox {
  float fpx = width/2-500;
  float fpy = height/2;
  PImage personaje;
  PImage [] explosion = new PImage [18];
  int imagenActualC=0;
  Globo (float _w, float _h) {
    super(_w, _h);
    personaje = loadImage("personaje.png");
  }
  void inicializar() {
    float my = map (globo.getY(), height, 0, movy, movy1);
    setName("personaje");
    setPosition(fpx, my);
    setRotatable(false);
    setGrabbable (false);
    setDensity(10);
    attachImage(personaje);
  }
  void arriba () {
    addForce (0, -40000);
    addImpulse (0, -40000);
  }
  void abajo () {
    addForce (0, 40000);
    addImpulse (0, 40000);
  }
  void actualizar() {
    ArrayList <TuioObject> listadoObjetosTuio = tuioClient.getTuioObjectList();
    for (int i=0; i<listadoObjetosTuio.size(); i++) {
      TuioObject patronAux= listadoObjetosTuio.get(i);
      int ID = patronAux.getSymbolID();
      if (ID == 0) {
        pushMatrix();
        setStatic (false);
        if ( patronAux.getAngle() > PI ) {
          abajo();
          println("PI" + "ABAJO");
        } else if ( patronAux.getAngle() < TAU ) {
          arriba();
          println ("TAU" + "ARRIBA");
        }
        popMatrix();
      }
    }
  }
  void morir() {
    tiempoEstado = tiempoEstado +1;
    iniciarColision();
    animarColision();
    if (tiempoEstado>=30) {
      estado=3;
    }
  }
  void iniciarColision () {
    for ( int i = 0; i < 18; i++) {
      explosion[i] = loadImage("0"+i+".gif");
    }
    imagenActualC = int (random(explosion.length));
  }
  void animarColision () {
    attachImage(explosion[imagenActualC%50]);
    imagenActualC++;
    imagenActualC = imagenActualC>17 ? 0 : imagenActualC;
  }
}
