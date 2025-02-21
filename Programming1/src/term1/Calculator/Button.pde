class Button {
  int x,y,w,h;
  
  String title;
  
  color background;
  
  Button(String t, color b) {
    x = 0;
    y = 0;
    w = bW-3;
    h = bH-3;
    
    this.title = t;
    
    this.background = b;
  }
  
  void drawBtn () {
    //Background
    rectMode(CENTER);
    fill(this.mouseOver() ? this.background + #222222 : this.background);
    noStroke();
    rect(this.x,this.y,this.w,this.h,(this.w + this.h)/2 * 0.1);

    //Text
    textSize(30);
    fill(255);
    textAlign(CENTER,CENTER);
    text(this.title,this.x,this.y);
  }
  
  boolean mouseOver () {
    if (mouseX > this.x - this.w/2 && mouseX < this.x + this.w/2) {
      if (mouseY > this.y - this.h/2 && mouseY < this.y + this.h/2) {
        return true;
      }
    }
    return false;
  }
}
