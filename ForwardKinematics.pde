Segment tentacle;

void setup() {
  size(600,400);

  float t = random(1000);
  float sw = 34;
  
  tentacle = new Segment(width/2,400,10,0,t,sw);
  Segment current = tentacle;
  for (int i = 0; i < 30; i++) {
    t += 0.1;
    sw -=1;

    Segment next = new Segment(current,10,0,t,sw);
    current.child = next;
    current = next;
  }
}
void draw() {
  background(51);
 
  Segment next = tentacle;
  while(next !=null) {
    next.wiggle();
    next.update();
    next.show();
    next = next.child; 
  }
}
