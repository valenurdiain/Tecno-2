class Fuego extends FBox {
  PImage[]secuencia= new PImage[27];
  int imagenActual=0;
  Fuego (float x_, float y_) {
    super (x_, y_);
  }
  void iniciarFuego (float _x, float _y) {
    setPosition (_x, _y);
    setName ("fuego");
    setStatic (true);
    setGrabbable (false);
    for ( int i = 0; i < 27; i++) {
      secuencia[i] = loadImage("secuencia"+i+".png");
    }
    imagenActual = int (random(secuencia.length));
  }
  void animar () {
    attachImage(secuencia[imagenActual]);
    imagenActual++;
    imagenActual = imagenActual>26 ? 0 : imagenActual;
  }
}
