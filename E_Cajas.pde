void Cajas() {
  FCircle cajas = new FCircle (40);
  cajas.setNoStroke();
  cajas.setFill(255, 0, 0);
  cajas.setPosition(random(600, 1200), -2);
  cajas.setDensity(2000);
  cajas.setVelocity(-700, 300);
  cajas.attachImage(loadImage("cajas.png"));
  cajas.setName("cajas");
  cajas.setRotatable(false);
  mundo.add(cajas);
}
