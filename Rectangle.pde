
class Rectangle {
  Range xrange;
  Range yrange;
  
  Rectangle(float x, float y, float w, float h){
    xrange = new Range(x, x+w);
    yrange = new Range(y, y+h);
  }
  
  boolean isIn(PVector v){
    return((xrange.isIn(v.x)) && (yrange.isIn(v.y)));
  }

  PVector getTransaction(Line mline){
    return new PVector(1,1);
  
  }

}