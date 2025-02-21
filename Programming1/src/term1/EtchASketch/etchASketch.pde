ArrayList<String> keysDown = new ArrayList<String>();
void keyPressed () {
  String k;
  if (key == CODED) {
    k = keyCode + "";
  } else {
    k = (key + "").toLowerCase();
  }
  if (!keysDown.contains(k)) keysDown.add(k + "");
}
void keyReleased () {
  String k;
  if (key == CODED) {
    k = keyCode + "";
  } else {
    k = (key + "").toLowerCase();
  }
  keysDown.removeIf(n -> k.equals(n));
}


float x, y;
PImage e1;
void setup() {
  size(800, 658);
  background(180);
  e1 = loadImage("Etch.png");

  x = width/2;
  y = height/2;
  
  frameRate(30);
}

float spd = 50;
ArrayList<Float[]> pnts = new ArrayList<Float[]>();
void draw () {
  background(180);

  if (keysDown.contains("a") || keysDown.contains(LEFT + "")) x-=spd/frameRate;
  if (keysDown.contains("d") || keysDown.contains(RIGHT + "")) x+=spd/frameRate;
  if (keysDown.contains("w") || keysDown.contains(UP + "")) y-=spd/frameRate;
  if (keysDown.contains("s") || keysDown.contains(DOWN + "")) y+=spd/frameRate;
  
  
  //Adds point to list
  Float[] pnt = {x,y};
  if (pnts.size() > 1) {
    Float[] last = pnts.get(pnts.size() - 1);
    if (!(pnt[0].equals(last[0]) && pnt[1].equals(last[1]))) pnts.add(pnt);
  } else {
    pnts.add(pnt);
  }
  
  //Draws line between points
  for (int i = 1; i < pnts.size(); i++) {
    Float[] p1 = pnts.get(i-1);
    Float[] p2 = pnts.get(i);
    strokeWeight(3);
    stroke((float)i/pnts.size() * 255,0,255 - (float)i/pnts.size() * 255);
    line(p1[0],p1[1],p2[0],p2[1]);
  }


  image(e1, 0, 0);
}

void mousePressed() {
  saveFrame("line-#####.png");
}
