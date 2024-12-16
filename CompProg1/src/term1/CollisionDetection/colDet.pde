//Niko Wolf | Collision Detection | September 11 2024

ArrayList<Float[]> pos = new ArrayList<Float[]>();
ArrayList<Float[]> vel = new ArrayList<>();
ArrayList<Integer> radius = new ArrayList<>();
void addBall(float x,float y, float velX, float velY, int rad) {
  Float xy[] = {x,y};
  pos.add(xy);
  
  Float v[] = {velX,velY};
  vel.add(v);
  
  radius.add(rad);
}


float animSpeed = 1;
final float GRAVITY = 9.98 * 96;
final float FRICTION = 0.08;
void ballPhysics () {
  float frameOffset = animSpeed / frameRate;
  
  for (int i = 0; i < pos.size(); i++) {
    Float p[] = pos.get(i);
    Float v[] = vel.get(i);
    int r = radius.get(i);
    
    //collision
    boolean bounced = false;
    if (p[0] < r || p[0] > width - r) {
      bounced = true;
      if (p[0] < r) {
        p[0] = (float)r;
        v[0] = abs(v[0]);
      } else {
        p[0] = (float)width - r;
        v[0] = -abs(v[0]);
      }
    }
    if (p[1] < r || p[1] > height - r) {
      bounced = true;
      if (p[01] < r) {
        p[1] = (float)r;
        v[1] = abs(v[1]);
      } else {
        p[1] = (float)height - r;
        v[1] = -abs(v[1]);
      }
    }
    if (bounced) {
      v[0] *= 1 - FRICTION;
      v[1] *= 1 - FRICTION;
      //print("bounced\n");
    }
    
    //Gravity
    v[1] += GRAVITY * frameOffset;
    
    p[0]+=v[0] * frameOffset;
    p[1]+=v[1] * frameOffset;
    
    //Update Variables
    pos.set(i,p);
    vel.set(i,v);
    radius.set(i,r);
    
    //Draw
    fill(255);
    noStroke();
    ellipse(p[0],p[1],2*r,2*r);
  }
}

void setup () {
  size(500,500);
  frameRate(60);
  background(0);
  
  addBall(50,50,100,0,20);
  addBall(width-50,50,-70,0,10);
}

void draw () {
  background(0);
  ballPhysics();
}
