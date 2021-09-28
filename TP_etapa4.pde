//agrego camara
import TUIO.*;
TuioProcessing tuioClient;
import ddf.minim.*;
import fisica.*;
//------------------------
FWorld mundo;
Fondo f;
Globo globo;
FCircle bolita;
FCircle cajas;
FCircle obstaculos;
FCircle pajaros;
Minim minim;
AudioPlayer mfondo, perder, gan, lluv, fueg, pajaroC, exp;
Ventilador v;
ArrayList <Fuego> fuego;
boolean fuegoInicializado, resultado;
PImage fondop, fondog, fondoi, tiempoDib, ventilador, iconoventilador, muere;
PImage [] images = new PImage [3];
PFont tipog1;
int tiempoEstado, rango;
int tiempo = -200;
int estado=1;
float rotacion;
float movy = height*6.45;
float movy1 = height+32;
int movx=-200;
int movx1=1300;
int movx2=-100;
int movx3= -200;
int movx4= 1300;
boolean conTUIO = true;
void setup () {
  size (1200, 800);
  tuioClient = new TuioProcessing(this);
  //  smooth();
  minim=new Minim(this);
  mfondo= minim.loadFile("musicfondo.mp3");
  mfondo.setGain(-10);
  perder=minim.loadFile("perd.mp3");
  gan= minim.loadFile("gan.mp3");
  lluv=minim.loadFile("lluvia_1.mp3");
  fueg=minim.loadFile("fueg.mp3");
  pajaroC = minim.loadFile("pajaroC.mp3");
  pajaroC.setGain(-5);
  exp = minim.loadFile("explosion.mp3");
  Fisica.init(this);
  mundo = new FWorld();
  globo= new Globo (100, 100);
  v = new Ventilador();
  fondog= loadImage("ganaste_1.png");
  fondop= loadImage("perdiste_1.png");
  fondoi= loadImage("pantallaprincipal_1.png");
  tiempoDib = loadImage("tiempo.png");
  iconoventilador = loadImage("icono_ventilador.png");
  muere = loadImage ("obstaculo3-muere.png");
  images[0] = loadImage("nub.png");
  images[1] = loadImage ("nub1.png");
  images[2] = loadImage ("nub5.png");
  tipog1=createFont("Sushi Delivery.ttf", 16);
  f= new Fondo();
  fuego = new ArrayList <Fuego> ();

  mundo.drawDebug();
}
void draw () {
  if (estado==1) {
    mfondo.play();
    lluv.pause();
    background (0);
    image(fondoi, 0, 0);
    mundo.remove(globo);
    noStroke();
    noFill();
    rect (width/2-580, height/2-300, width/2-290, height/2-140 );
    if ( conTUIO ) {
      if ( id1Presente ) {
        image (iconoventilador, xPuntero1, yPuntero1, 100, 100);
        println (xPuntero1 + " ; " + yPuntero1);
        if ( xPuntero1 > width/2-580 && xPuntero1 < width/2-580 + width/2-290 && yPuntero1 > height/2-300 && yPuntero1 < height/2-300 + height/2-140 ) {
          inicializarObjetos();
        }
      }
    }
  }
  if (estado==2) {
    globo.inicializar();
    for ( int i = 0; i< fuego.size(); i++) {
      fuego.get(i).animar();
    }
    f.inicializar();
    float m = map (tiempo, 0, 1400, height/20, width/2-370);
    textFont(tipog1);
    fill(255);
    text ("Tiempo", 10, 40);
    tiempo = tiempo +1;
    image(tiempoDib, 10, 50, 210, 30);
    fill(#EA7D07);
    rectMode(CORNER);
    rect (13, 53, m, 24, 15);
  }
  if (estado==3) {
    if (mfondo.isPlaying() ) {
      mfondo.pause();
    }
    if (fueg.isPlaying() ) {
      fueg.pause();
    }
    if (lluv.isPlaying() ) {
      lluv.pause();
    }
    if (pajaroC.isPlaying()) {
      pajaroC.pause();
    }
    perder.play();
    resultado = true;
    image(fondop, 0, 0);
    fill(255);
  }
  if (estado==4) {
    if (mfondo.isPlaying() ) {
      mfondo.pause();
    }
    if (fueg.isPlaying() ) {
      fueg.pause();
    }
    if (lluv.isPlaying() ) {
      lluv.pause();
    }
    if (pajaroC.isPlaying()) {
      pajaroC.pause();
    }
    gan.play();
    resultado = true;
    image(fondog, 0, 0);
  }
  if (estado==5) {
    float my = map (globo.getY(), height, 0, movy, movy1);
    globo.setPosition(globo.fpx, my);
    f.inicializar();
    textFont(tipog1);
    fill(255);
    float m = map (tiempo, 0, 1400, height/20, width/2-370);
    text ("Tiempo", 10, 40);
    tiempo = tiempo +1;
    image(tiempoDib, 10, 50, 210, 30);
    fill(#EA7D07);
    rectMode(CORNER);
    rect (13, 53, m, 24, 15);
    globo.morir();
  }
  if (tiempo >= -100 && tiempo <= 790) {
    mundo.setGravity(0, 0);
    if (frameCount % 70 == 0) {
      Obstaculos ();
    }
    if (frameCount % 80 == 0) {
      Pajaros();
    }
  }
  if (tiempo >= 300 && tiempo <=800) {
    if ( frameCount % 40 == 0) {
      lluv.play();
      lluv.setGain(600);
      Lluvia ();
    }
  }
  if (tiempo >= 740) {
    if ( frameCount % 150 == 0) {
      Cajas();
    }
  }
  if (tiempo >= 1200) {
    estado=4;
  }
  if (estado==5 && tiempoEstado<=20) {
    perder.rewind();
    perder.play();
  }
  mundo.step();
  ArrayList <TuioObject> listadoObjetosTuio = tuioClient.getTuioObjectList();
  for (int i=0; i<listadoObjetosTuio.size(); i++) {
    TuioObject patronAux= listadoObjetosTuio.get(i);
    int ID = patronAux.getSymbolID();
    if (estado == 2) {
      rotacion = patronAux.getAngle();
      if (ID == 0) {
        pushMatrix();
        v.moverVentilador();
        globo.actualizar();
        popMatrix();
      }
      println(patronAux.getAngle());
    }
  }
  //----------------------- REINICIO
  if (estado == 4) {
    if ( conTUIO ) {
      if ( id1Presente ) {
        image (iconoventilador, xPuntero1, yPuntero1, 100, 100);
        mfondo.pause();
        if ( xPuntero1 > width/2+210 && xPuntero1 < width/2+210 + width/2-290 && yPuntero1 > height/2+245 && yPuntero1 < height/2+245 + height/2-330 ) {
          estado=1;
          tiempo=-200;
          fuegoInicializado = false;
          resultado=false;
          mfondo.rewind();
          globo.resetForces();
          resetearObjetos();
          if (estado==1) {
            if ( xPuntero1 > width/2-580 && xPuntero1 < width/2-580 + width/2-290 && yPuntero1 > height/2-300 && yPuntero1 < height/2-300 + height/2-140 ) {
              inicializarObjetos();
            }
          }
        }
      }
    }
  }
  if ( estado == 3 ) {
    if ( conTUIO ) {
      if ( id1Presente ) {
        image (iconoventilador, xPuntero1, yPuntero1, 100, 100);
        mfondo.pause();
        if ( xPuntero1 > width/2+230 && xPuntero1 < width/2+230 + width/2-290 && yPuntero1 > height/2+262 && yPuntero1 < height/2+262 + height/2-330 ) {
          estado=1;
          tiempo=-200;
          fuegoInicializado = false;
          resultado=false;
          mfondo.rewind();
          globo.resetForces();
          resetearObjetos();
          if (estado==1) {
            if ( xPuntero1 > width/2-580 && xPuntero1 < width/2-580 + width/2-290 && yPuntero1 > height/2-300 && yPuntero1 < height/2-300 + height/2-140 ) {
              estado = 2;
              inicializarObjetos();
            }
          }
        }
      }
    }
  }
  nubes();
}
//TERMINA EL DRAW
//------------------  COLISIONES
void contactStarted(FContact contacto) {
  FBody cuerpo1 = contacto.getBody1();
  FBody cuerpo2 = contacto.getBody2();
  String nombre1 = conseguirNombre (cuerpo1);
  String nombre2 = conseguirNombre (cuerpo2);
  if (nombre1 == "personaje" && nombre2 == "obstaculos1") {
    resultado = true;

    if (!exp.isPlaying()) {
      exp.rewind();
      exp.play();
    }
    estado=5;
  }
  if (nombre1 == "personaje" && nombre2 == "pajaros") {
    if (!pajaroC.isPlaying()) {
      pajaroC.rewind();
      pajaroC.play();
      resultado = false;
      cuerpo2.attachImage(muere);
      cuerpo2.addImpulse (0, 900000 );
      cuerpo2.addForce (0, 900000 );
    }
  }
  if (nombre1 == "personaje" && nombre2 == "lluvia") {
    cuerpo2.addImpulse( 0, -0.001 );
    resultado = false;
  }
  if (nombre1 == "fuego" && nombre2 == "lluvia") {
    mundo.remove(cuerpo2);
  }
  if (nombre1 == "personaje" && nombre2 == "cajas") {
    resultado = true;
    if (!exp.isPlaying()) {
      exp.rewind();
      exp.play();
    }
    estado=5;
  }
  if (nombre1 == "ventilador" && nombre2 == "cajas") {
    mundo.remove(cuerpo2);
  } else if (nombre1 == "cajasedges" && nombre2 == "lluvia") {
    mundo.remove(cuerpo2);
  }
  if (nombre1 == "ventilador" && nombre2 == "lluvia") {
    mundo.remove(cuerpo2);
  }
}

void contactEnded (FContact contact) {
  FBody c1 = contact.getBody1();
  FBody c2 = contact.getBody2();
  if (c1.getName() == "personaje" && c2.getName() == "pajaros") {
    c2.adjustVelocity (0, c2.getVelocityY());
    c2.setRotatable(true);
    c2.setSensor(true);
    c2.addTorque( 1000 );
  }
}
boolean hayColisionEntre( FContact contact, String nombreUno, String nombreDos ) {
  FBody uno = contact.getBody1();
  FBody dos = contact.getBody2();
  String etiquetaUno = uno.getName();
  String etiquetaDos = dos.getName();
  if ( etiquetaUno != null && etiquetaDos != null ) {
    println( etiquetaUno+" <-> "+etiquetaDos);
    if (( nombreUno.equals( etiquetaUno ) && nombreDos.equals( etiquetaDos ) ) ||
      ( nombreDos.equals( etiquetaUno ) && nombreUno.equals( etiquetaDos ) ) ) {
      resultado = true;
    }
  }
  return resultado;
}
void inicializarObjetos () {
  estado = 2;
  mfondo.rewind();
  globo.inicializar();
  mundo.add(globo);
  v.iniciarV();
  mundo.add(v);
  tiempoEstado=0;
  if (!fuegoInicializado) {
    for (int i = 0; i < 8; i++)
    {
      Fuego p1 = new Fuego(140, 140);
      p1.iniciarFuego(i* 145 + 100, height - 100 - (i * 0));
      p1.setName ("fuego");
      mundo.add(p1);
      fuego.add(p1);
      fueg.loop();
    }
    fuegoInicializado = true;
    resultado=false;
  }
}

void resetearObjetos() {

  ArrayList <FBody> cuerpos = mundo.getBodies();

  for (FBody b : cuerpos) {

    if (b.getName() != null) {
      if (b.getName().equals("obstaculos1")) {
        if (b.getName().equals("lluvia")) {
          if (b.getName().equals("pajaros")) {
            if (b.getName().equals("cajas")) {
              b.resetForces();
            }
          }
        }
      }
    }
  }
}
