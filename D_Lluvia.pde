void Lluvia () {
  for (int i=0; i<3; i++) {
    FCircle bolita = new FCircle(15);
    bolita.setNoStroke();
    bolita.setFill(0, 0, 255);
    bolita.setPosition(random(width), -2);
    bolita.setDensity(3000);
    bolita.setName("lluvia");
    bolita.setVelocity(-700, 600);
    bolita.setRestitution(0);
    bolita.attachImage(loadImage("lluvia.png"));
    mundo.add(bolita);
  }
}
