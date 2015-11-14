
class Simulation {
  
  Stage stage;
  Line orbit;
  PVector ball;
  float l;
  boolean f = false;
  String dna;
  int eventc = 0;
  int limit = 15;
  ArrayList<PVector> orbits = new ArrayList<PVector>();
  
  Simulation(Stage _s, String _dna){
    stage = _s;
    dna = _dna;
    ball = new PVector(stage.set.x+250, stage.set.y+150);
    orbit = new Line(500, 5, ball.x, ball.y, new Range(ball.x, stage.set.x+500));
    l = 0;
  }
  
  void step(){
    Line norbit;
    stroke(255,0,0);
    orbit.draw();
    stroke(0);
    stage.draw();
    
    if(!f) orbits.add(ball);
    
    norbit = stage.getCollidedOrbit(orbit, ball);
      
    if( stage.colliedintersection.y > stage.lines[124].v ){
      float movedrange = orbit.getX(stage.lines[124].v);
      //float point = random(1,59);
      float point = getPointFromDNA(eventc);
      stage.lines[124].r = new Range(movedrange+point-60, movedrange+point+0);
      norbit = stage.getCollidedOrbit(orbit, ball);
      eventc++;
    }
      
    l += ball.dist(new PVector(norbit.a, norbit.b));
      
    orbit = norbit;
      
    ball = new PVector(norbit.a, norbit.b);
    
    

    boolean finished = true;
    for(int i=4; i<=123; i++)
      if(!(stage.lines[i].deleted))
        finished = false;
          
     
    if((finished) || (eventc >= 30)) onFinished();
  }
  
  void onFinished(){
    //println("length : "+l);
    //println("eventc : "+eventc);
    //println("===============================================");
    f = true;
    //exit();
  }
  
  float getPointFromDNA(int e){
    String actbin = "";
    for(int i=0; i<6; i++){
      if(e >= limit){
        actbin += "0";
        
      }else{
        actbin += str(dna.charAt(e*6+i));
      }
    }
    return unbinary(actbin);
  }

}