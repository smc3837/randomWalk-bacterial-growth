ArrayList<Walker> holder;

int numberOfLines = 1000;
int theOne;

void setup(){
  size(1000 , 1000, P2D);
  colorMode(HSB, 360, 100, 100, 1);
  smooth(4);

  holder = new ArrayList<Walker>(1);
  
  for(int i=0; i<numberOfLines; i++){
    Walker w = new Walker(width/2, height/2, this);
    holder.add(w);
  }
  
  background(128);
  stroke(255);
  
  theOne = int(random(numberOfLines));
}

void draw(){
  for (Walker item : holder){
    item.advance();
  }
  
  String count = String.format("%06d", frameCount);
  if (frameCount%24 == 0){
    //save("frames/"+count+".tif");
  }
}




class Walker{
  int scale = 1; //needs to be at least 1
  
  ArrayList<Walker> holder;
  randomWalk parent;
  
  PVector prev = new PVector();
  PVector cur = new PVector();
  
  PVector delta = new PVector();
  
  PVector heading = new PVector();
  
  Walker (int x, int y, randomWalk parent){
    prev.x = x;
    prev.y = y;
    
    this.parent=parent;
    holder = parent.holder;
  }
  
  void advance(){
    int index = holder.indexOf(this);
    //map index to 360
    float reg = map(index, 0, holder.size(), 0, 360);
    
    float deg = reg + randomGaussian()*90;//noise(index*1000 + frameCount/1000)*;
    
    
    
    heading = PVector.fromAngle(radians(deg));
    
    cur = PVector.add(prev, heading);
    
    delta = PVector.sub(cur, prev);
    
    for (int i=0; i < scale; i++){
      cur.add(delta);
    }
    
    float hue = map(holder.indexOf(this), 0,holder.size(), 0, 360);
    float hueMod = map(holder.indexOf(this), 0,holder.size(), 160, 200);
    //stroke(hue, 100, (index%10)*10);
    //stroke(hueMod, 50, (index%10)*5);
    stroke(0,0,(index%10)*10);

    line (prev.x, prev.y, cur.x, cur.y);
    
    prev = cur;
  }
}
