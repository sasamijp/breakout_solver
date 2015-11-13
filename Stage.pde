
class Stage{
  PVector set;
  Line lines[] = new Line[150];
  PVector blocksize = new PVector(44, 30);
  
  int colliedline = 100000;
  PVector colliedintersection = new PVector(0,0);
  
  Stage(PVector _set){
    set = _set;
    
    // outer frames
    lines[0] = new Line(0, 'x', set.x, new Range(set.y, set.y+500));
    lines[1] = new Line(1, 'y', set.y, new Range(set.x, set.x+500));
    lines[2] = new Line(2, 'x', set.x+500, new Range(set.y, set.y+500));
    lines[3] = new Line(3, 'y', set.y+500, new Range(set.x, set.x+500)); 
    
    // blocks
    for(int i=0; i<10; i++)
      for(int k=0; k<3; k++){
        //setBlock(4*(1+3*i+k), new PVector(set.x+random(30, 450), set.y+random(30,200)));
        setBlock(4*(1+3*i+k), new PVector(set.x+30+blocksize.x*i, set.y+30+blocksize.y*k));
        //setBlock(4*(1+3*i+k), new PVector(set.x+5+(blocksize.x+5)*i, set.y+30+(blocksize.y+5)*k));
      }
        
    // bar
    lines[124] = new Line(124, 'y', set.y+450, new Range(set.x+200-30 + 50, set.x+200+30 + 50));
  }
  
  void setBlock(int id, PVector p){
    lines[id] = new Line(id, 'x', p.x, new Range(p.y, p.y+blocksize.y));
    lines[id+1] = new Line(id+1, 'y', p.y, new Range(p.x, p.x+blocksize.x));
    lines[id+2] = new Line(id+2, 'x', p.x+blocksize.x, new Range(p.y, p.y+blocksize.y));
    lines[id+3] = new Line(id+3, 'y', p.y+blocksize.y, new Range(p.x, p.x+blocksize.x));
  }
  
  void deleteBlock(int id){
    lines[id+0 - (id % 4)].deleted = true;
    lines[id+1 - (id % 4)].deleted = true;
    lines[id+2 - (id % 4)].deleted = true;
    lines[id+3 - (id % 4)].deleted = true;
  }
  
  Line getCollidedOrbit(Line orbit, PVector ball){
    String[] list = getIntersectionLinesIDList(orbit).split(",");
    PVector[] id_dist = new PVector[list.length];
    float dist;
    PVector point;
    for(int i=0; i<list.length; i++){
      point = getIntersectionPoint(lines[int(list[i])], orbit);
      if(!(point.equals(colliedintersection)))
        dist = ball.dist(point);
      else
        dist = 1000000000;
      if(dist == 0.0)
        dist = 1000000000;
      id_dist[i] = new PVector(int(list[i]) , dist);
    }
    
    PVector smallest = id_dist[0];
    for(int i=1; i<list.length; i++)
      if(id_dist[i].y < smallest.y)
        smallest = id_dist[i];

    PVector intersection = getIntersectionPoint(lines[int(smallest.x)], orbit);
    float m;
    if(int(smallest.x) == 124){
      m = getBarColliedSlope(orbit.m, 60, intersection.x - lines[124].r.getSmaller())*-1;
    }else{
      m = -1*orbit.m;
    }
    Range range;
   
    colliedline = int(smallest.x);
    colliedintersection = intersection;
    
    if((4 <= colliedline) && (colliedline <= 123))
      deleteBlock(colliedline);
    
    stroke(0,255,0);
    ellipse(intersection.x, intersection.y, 10,10);
    
    if(lines[int(smallest.x)].xy == 'y'){
      if(intersection.x > ball.x)
        range = new Range(intersection.x, 500+set.x);
      else
        range = new Range(set.x, intersection.x);
    }else{
      if(intersection.x > ball.x)
        range = new Range(set.x, intersection.x);
      else
        range = new Range(intersection.x, 500+set.x);
    }
    
    if(int(smallest.x) == 124)
        if(m < 0) 
          range = new Range(intersection.x, 500+set.x);
        else
          range = new Range(set.x, intersection.x);

    return new Line(orbit.id+1, m, intersection.x, intersection.y, range);
  }
  
  String getIntersectionLinesIDList(Line l){
    String list = "";
    for(int i=0; i<125; i++)
      if((hasIntersectionPoint(lines[i], l)) && (i != colliedline) && (lines[i].deleted == false))
        list += str(i) + ",";
    return list;
  }
 
  boolean hasIntersectionPoint(Line line, Line mline){
    if(line.xy == 'x'){
      return (line.r.isIn(mline.getY(line.v)) && mline.r.isIn(line.v));
    }else{
      return (line.r.isIn(mline.getX(line.v)) && mline.r.isIn(mline.getX(line.v)));
    }
  }
  
  PVector getIntersectionPoint(Line line, Line mline){
    // line's line type is y = v or x = v
    // mline's line type is y = m(x-a)+b
    
    if(line.xy == 'x'){
      return new PVector(line.v, mline.getY(line.v));
    }else{
      return new PVector(mline.getX(line.v), line.v);
    }
  }
  
  float getBarColliedSlope(float m, float w, float a){
    return tan( PI/2 * (1.5 - a/w) );
  }
  
  void draw(){
    for(int i=0; i<125; i++)
      if(lines[i].deleted == false)
        lines[i].draw();
  }

}
