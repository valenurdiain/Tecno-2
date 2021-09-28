class Ventilador extends FCircle {
  Ventilador () {
    super(15);
    ventilador = loadImage("ventilador_2.1.png");
  }
  void iniciarV() {
    setPosition (100, height/2+150);
    setName ("ventilador");
    attachImage(ventilador);
    setFriction(0);
    setStatic(true);
  }
  void moverVentilador() {
    float factor1 = map (rotacion, 0, PI, 0, 50);
    float factor2 = map (rotacion, PI, TAU, -50, 0);
    float factor = rotacion > PI ? factor2:factor1;
    addTorque (factor);
    setRotation(rotacion);
  }
}
