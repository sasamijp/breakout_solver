
class Gene implements Comparable {
  
  float score;
  String dna;
  int bitLength;
  
  Gene(int bitLength_){
    score = 0.0;
    bitLength = bitLength_;
    dna = getRandomBinary(bitLength);
  }
  
  Gene(String _dna){
    score = 0.0;
    dna = _dna;
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
   
    // use below when strlen < 32 (limit of int is 2^32)
    // return binary( int(random(0,pow(2,strLength))), strLength );
  }
 
  int compareTo(Object o){
    Gene other = (Gene)o;
    if(other.score > score) return -1;
    if(other.score == score) return 0;
    return 1;
  }
  
}
