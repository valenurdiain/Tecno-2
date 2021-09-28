boolean verbose = false;
boolean callback = true;
float xPuntero1, yPuntero1;
float xPuntero2, yPuntero2;
int id1 = 0;
boolean id1Presente = false;
boolean id2Presente = false;
// --------------------------------------------------------------
void addTuioObject(TuioObject patronAux) {
  if ( patronAux.getSymbolID() == id1 ) {
    xPuntero1 = patronAux.getX() + width;
    yPuntero1 = patronAux.getY() * height;
    id1Presente = true;
  }
}
void updateTuioObject (TuioObject patronAux) {
  if ( patronAux.getSymbolID() == id1 ) {
    xPuntero1 = patronAux.getX() * width;
    yPuntero1 = patronAux.getY() * height;
  }
}
void removeTuioObject(TuioObject patronAux) {
  if ( patronAux.getSymbolID() == id1 ) {
    id1Presente = false;
  }
}
// --------------------------------------------------------------
//void addTuioCursor(TuioCursor tcur) {
//}
//void updateTuioCursor (TuioCursor tcur) {
//}
//void removeTuioCursor(TuioCursor tcur) {
//}
// --------------------------------------------------------------
/*void addTuioBlob(TuioBlob tblb) {
 }
 void updateTuioBlob (TuioBlob tblb) {
 }
 void removeTuioBlob(TuioBlob tblb) {
 } */
// --------------------------------------------------------------
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}
