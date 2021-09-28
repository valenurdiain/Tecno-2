class Fondo {
  PImage fondo;
  float juego;
  int x= -200, y, vy=0;
  int ox[]= new int [2], oy[]=new int [2];

  Fondo () {
    fondo= loadImage("fondo-illustrator1.png");
  }
  void inicializar() {
    imageMode(CORNER);
    image(fondo, x, 0);
    image(fondo, x+fondo.width, 0);
    x-=4;
    if (x < -fondo.width) {
      x=0;
    }
  }
}
