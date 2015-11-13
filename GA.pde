
class GA {
  int population, generationCount, mutationRate, eliteLength, bitLength;
  
  Gene[] genes;
  Simulation[] sims;

  GA(int _population, int _mutationRate, int _eliteLength, int _bitLength){
    population = _population;
    mutationRate = _mutationRate;
    eliteLength = _eliteLength;
    bitLength = _bitLength;
    generationCount = 1;
    genes = new Gene[population];
    for(int i=0; i<population; i++)
      genes[i] = new Gene(bitLength);
    sims = new Simulation[population];
  }
  
  void exec(){
    while(!(isFinished())){
      eval();    // gene.score value being fixed
      sort();    // genes array sorted 
      dump();    // dump all scores
      nextGen(); // increments generationCount and breed new generation
    
    }
    dump();
  }
  
  boolean isFinished(){
    return false;
  }

  void eval(){
    Simulation s;
    for(int i=0; i<population; i++){
      s =  new Simulation(new Stage(new PVector(10,10)), genes[i].dna ) ;
      sims[i] = s;
    }

    while(true){
      boolean allfinish = true;
      for(int i=0; i<population; i++){
        if(!(sims[i].f)){
          allfinish = false;
          sims[i].step();
        }
      }
      if(allfinish) break;
    }
    
    for(int i=0; i<population; i++)
      genes[i].score = sims[i].l;
  }

  void sort(){
    Arrays.sort(genes); // sorted by score
  }

  void dump(){
    println("generation : " + str(generationCount));
    for(int i=0;i<population;i++){
      println( " score : " + str(genes[i].score));
      
    }
      
    output.println("generation : " + str(generationCount)+ ": score :" + str(genes[0].score));
    output.println(genes[0].dna );
    output.flush();
    
  }
  
  String crossOver(String dna1, String dna2){
    
    assert(bitLength % 6 == 0);
    
    String mask = getRandomBinary(bitLength/6);
    String child1 = "", child2 = "";
    
    for(int i=0; i<bitLength/6; i++){
      if(mask.charAt(i) == '1'){
        for(int k=0; k<6; k++){
          child1 += dna1.charAt(6*i+k);
          child2 += dna2.charAt(6*i+k);
        }
      }else{
        for(int k=0; k<6; k++){
          child1 += dna2.charAt(6*i+k);
          child2 += dna1.charAt(6*i+k);
        }
      }
    
    }
    //println(child1.length());
    assert(child1.length() == bitLength && child2.length() == bitLength);
    
    return child1 + "," + child2;
    
    //int pos = int(random(12, bitLength/12)*12)-12;
    //int range = 12;
    
    //return dna1.substring(0,pos) + (dna2.substring(pos, pos+range)) + dna1.substring(pos+range) + "," + dna2.substring(0,pos) + (dna1.substring(pos, pos+range)) + dna2.substring(pos+range);
    
    //int crosspos = int(random(1,bitLength-1));
    //return (dna1.substring(0,crosspos) + dna2.substring(crosspos) + "," + dna2.substring(0,crosspos) + dna1.substring(crosspos));
  }
  
  String genMask(int len){
    String ret = "";
    int ran = int(random(1, len-1));
    for(int i=0; i<len; i++)
      if(i < ran)
        ret += "1";
      else
        ret += "0";
    return ret;  
  }
  
  String breed(String dna1, String dna2){
    String childDna = crossOver(dna1, dna2);
    String muta = childDna.split(",")[0];
    if( int(random(50)) < mutationRate )  // 1/100 = 1/50 * 1/2
      muta = mutation(muta);
    return muta + "," + childDna.split(",")[1];
  }
  
  String bitReverse(String str){
    //println(str);
    //println(binary(~unbinary(str), str.length()));
    return binary(~unbinary(str), str.length());
  }
  
  String mutation(String dna){
    int pos = int(random(bitLength-37));
    int range = int(random(1, 3))*12;
    dna = dna.substring(0,pos) + bitReverse(dna.substring(pos, pos+range)) + dna.substring(pos+range);
    assert(dna.length() == bitLength);
    return dna;
  }
  
  String getRandomBinary(int strLength){
    String ret = "";
    for(int i=0; i<strLength; i++){
      ret += str(int(random(0,2)));
      //// println(i%2);
      //ret += "1";
    }
    assert( ret.length() == strLength );
    return ret;
   
    // use below when strlen < 32 (limit of int 2^32)
    // return binary( int(random(0,pow(2,strLength))), strLength );
  }

  void nextGen(){
    generationCount++;
    selection();
    int c = eliteLength;
    String children;
    for(int i=eliteLength;i<((population-eliteLength)/2)+eliteLength;i++){
      children = breed(genes[i].dna, genes[i+1].dna);
      genes[c] = new Gene(children.split(",")[0]);
      genes[c+1] = new Gene(children.split(",")[1]);
      c += 2;
    }
  }
  
  void selection(){
    int parent = int(random(eliteLength, eliteLength+3));
    
    int c = eliteLength;
    for(int i=eliteLength;i<((population-eliteLength)/2)+eliteLength;i++){
      genes[c] = genes[parent];
      genes[c+1] = genes[parent+1];
      
      c += 2;
    }
    
    
  }
  
}