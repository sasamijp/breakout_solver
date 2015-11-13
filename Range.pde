
class Range{
  
  float s, e;
  
  Range(float _s, float _e){
    s = _s;
    e = _e;
  }
  
  boolean isIn(float x){
    if(e > s){
      return( (s <= x) && (x <= e)  );
    }else{
      return( (e <= x) && (x <= s)  );
    }
  }
  
  float getBigger(){
    if(e > s){
      return(e);
    }else{
      return(s);
    }
  }
  
  float getSmaller(){
    if(e > s){
      return(s);
    }else{
      return(e);
    }
  
  }

}
