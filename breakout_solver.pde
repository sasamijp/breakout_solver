
import java.util.Arrays;

GA ga;
PrintWriter output;
Simulation sim;

void setup() {
  size(1200, 1000);
  frameRate(60);

  study();
  //test();
  //randomTest();
}

void study() {
  output = createWriter("dna.txt"); 
  ga = new GA(15, 10, 1, 90, 90);
  ga.exec();
}

void test() {
  //String d = "101111101000000001001101111010110110101101001100000111001100011100001001110111100111101101";
  String d= "111001110010111111110101001101101110011011010100001101010100111000101010110101110011010100";
  sim = new Simulation(new Stage(new PVector(10, 10)), d);
}

void randomTest(){
  output = createWriter("random.csv"); 
  int n = 1000;
  float[] scores = new float[n];
  Simulation[] sims = new Simulation[n];
  for(int i=0; i<n; i++){
    sims[i] = new Simulation(new Stage(new PVector(10, 10))); // no dna mode
  }
  
  while(true){
    boolean allfinish = true;
    for(int i=0; i<n; i++){
      if(!(sims[i].f)){
        allfinish = false;
        sims[i].step();
      }
    }
    if(allfinish) break;
  }
  
  for(int i=0; i<n; i++){
    scores[i] = sims[i].l;
    output.println(scores[i]);
  }
  output.flush();
  exit();
}

void draw() {

  background(255);
  sim.step();
  //sim2.step();

  if (sim.f)
    for (int i=0; i<sim.orbits.size()-1; i++) {
      stroke((float(i)/(sim.orbits.size()-1))*255, 100,100);
      line(sim.orbits.get(i).x+500, sim.orbits.get(i).y, sim.orbits.get(i+1).x+500, sim.orbits.get(i+1).y);
    }
}