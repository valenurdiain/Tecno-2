String conseguirNombre (FBody cuerpo) {
  String nombre = "nada";
  if (cuerpo != null) {
    nombre = cuerpo.getName();
    if (nombre == null) {
      nombre = "nada";
    }
  }
  return nombre;
}

void nubes() {
  ////-------------------- nubes izquierda
  if (tiempo >= 300 && estado == 2 || estado==5) {
    image(images[0], movx, 5, 312, 130);
    image(images[2], movx3, 150, 212, 130);
    image(images[1], movx1, 30, 230, 130);
    image(images[0], movx4, 150, 212, 130);
    image(images[0], movx2, 50, 312, 130);
    movx2 = movx2 + 2;
    movx1 = movx1 - 2;
    movx4 = movx4 - 2;
    movx = movx + 2;
    movx3 = movx3 + 2;
    if (movx>=150 && movx3>=150) {
      movx= 150;
      movx3= 150;
    }
    if (movx1<=700 && movx4<=700) {
      movx1 = 700;
      movx4 = 700;
    }
    if (movx2>=400) {
      movx2=400;
    }
    if (tiempo>=800) {
      movx2 = movx2 -5;
      movx1 = movx1 + 5;
      movx4 = movx4 + 5;
      movx = movx - 5;
      movx3 = movx3 - 5;
      lluv.pause();
    }
  }
  if (estado != 3 && estado!=4 && estado != 1) {
    mundo.draw(this);
  }
}
