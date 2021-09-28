void Obstaculos () {
  if (frameCount % 40 == 0) {
    FBox obstaculos = new FBox (50, 60);
    obstaculos.setPosition( 1200, random (80, 460) );
    obstaculos.setVelocity(-900, 20);
    obstaculos.setName( "obstaculos1" );
    obstaculos.setRotatable(false);
    obstaculos.setDensity(6000);
    rango = int (random(4));
    if (rango >= 0 && rango <= 4) {
      obstaculos.attachImage(loadImage("obstaculo5.png"));
    }
    if (rango >= 0 && rango <= 2) {
      obstaculos.attachImage(loadImage("obstaculo1.png"));
    }
    mundo.add(obstaculos);
  }
}

void Pajaros () {
  if (frameCount % 30 == 0) {
    FCircle pajaros = new FCircle (30);
    pajaros.setPosition( 1200, random (80, 500) );
    pajaros.setName( "pajaros" );
    pajaros.setDensity(5000);
    pajaros.setVelocity(-850, pajaros.getVelocityX());
    pajaros.attachImage(loadImage("obstaculo3.png"));
    mundo.add(pajaros);
  }
}
