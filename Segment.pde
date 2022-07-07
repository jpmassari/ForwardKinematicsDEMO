class Segment {
  PVector a;
  float len;
  float angle;
  float selfAngle;
  
  //perly noise
  float t;
  float sw;
  
  //b is what you calculate based on a position, length and angle
  PVector b;
  
  Segment parent = null;
  Segment child = null;

  //Instead of taking x and y on length and angle , its going to take another segment on length and angle
  Segment(Segment parent_ , float len_ , float angle_,float t_,float sw_) {
    parent = parent_;
    a = parent.b;
    len = len_;
    angle = angle_;  
    selfAngle = angle;
    t = t_;
    sw = sw_;
    calculateB();
  }
  Segment(float x , float y , float len_ , float angle_,float t_,float sw_){
    a = new PVector(x,y);
    len = len_;
    angle = angle_;   
    t = t_;
    sw = sw_;
    calculateB();
    parent = null;
  }
  void wiggle() { 
    //lets make the range of angle , small for sin and a bit bigger for perlin noise
    float maxAngle = 0.1;
    float minAngle = -0.1;
    
    //doing some perlyn noise for rotation
    selfAngle = map(noise(t),0,1,maxAngle,minAngle);
    //selfAngle = map(sin(t),-1,1,maxAngle,minAngle); //sin wave
    t += 0.03;
  }
  void update() {
    angle = selfAngle;
    if(parent != null) {
      a = parent.b;   
      //also pass the parents angle
      angle += parent.angle;
      calculateB();
      return;
    } 
    angle += -PI/2;
    calculateB();
  }
  void calculateB() {
    float dx = len * cos(angle);
    float dy = len * sin(angle);
    b = new PVector(a.x+dx , a.y+dy);
  }
  void show() {
    stroke(255);
    strokeWeight(sw);
    line(a.x , a.y , b.x , b.y); 
  }
}
