
import java.util.Arrays;

GA ga;
PrintWriter output;
Simulation sim;

void setup(){
  size(1200,1000);
  frameRate(2);
  
  study();
  //test();
}

void study(){
  output = createWriter("dna.txt"); 
  ga = new GA(20, 30, 1, 90);
  ga.exec();
}

void test(){
  String d = "101111101000000001001101111010110110101101001100000111001100011100001001110111100111101101";
  sim = new Simulation(new Stage(new PVector(10, 10)), d);
}

void draw(){
  background(255);  
  sim.step();
  //sim2.step();
}