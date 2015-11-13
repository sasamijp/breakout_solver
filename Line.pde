
class Line{
  
  // support 3 types of lines
  // y = m(x - a) + b
  // y = v
  // x = v
  
  float m, a, b, v;
  char xy;
  Range r;
  int len, id;
  boolean is_vertical, deleted;
  
  Line(int _id, float _m, float _a, float _b, Range _r){
    m = _m;
    a = _a;
    b = _b;
    r = _r;
    id = _id;
    len = width + height;
    is_vertical = false;
    deleted = false;
  }
  
  Line(int _id, char _xy, float _v, Range _r){
    xy = _xy;
    v = _v;
    r = _r;
    id = _id;
    len = width + height;
    is_vertical = true;
    deleted = false;
  }
  
  float getY(float _x){
    if(is_vertical){
      if(xy == 'y'){
        return v;
      }else{
        assert(0 == 1); // don't run this line 
        return 0;
      }
    }else{
      return m*(_x-a)+b;
    }
  }
  
  float getX(float _y){
    if(is_vertical){
      if(xy == 'x'){
        return v;
      }else{
        assert(0 == 1); // don't run this line 
        return 0;
      }
    }else{
      return (1/m)*(_y-b)+a;
    }
  
  }
  
  void draw(){
    if(is_vertical){
      
      if(xy == 'x'){
        line(v, r.s, v, r.e); 
      }else{
        line(r.s, v, r.e, v);
      }
      
    }else{
      line(r.s, getY(r.s), r.e, getY(r.e));
    }
  
  }

}