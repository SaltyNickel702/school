//Niko Wolf | Calculator App | September 30 2024

import java.awt.event.KeyEvent;

ArrayList<Button> btns = new ArrayList<Button>();
int sp;
int bW;
int bH;
    
void setup () {
  size(300, 400);
  pixelDensity(2);

  sp = 75;
  bW = width/4;
  bH = (height - sp)/6;

  btns.add(new Button("C", #CC4444));
  btns.add(new Button("MS", #333333));
  btns.add(new Button("√", #333333));
  btns.add(new Button("del", #333333));
  btns.add(new Button("MC", #333333));
  btns.add(new Button("MR", #333333));
  btns.add(new Button("^", #333333));
  btns.add(new Button("÷", #333333));
  btns.add(new Button("7", #666666));
  btns.add(new Button("8", #666666));
  btns.add(new Button("9", #666666));
  btns.add(new Button("×", #333333));
  btns.add(new Button("4", #666666));
  btns.add(new Button("5", #666666));
  btns.add(new Button("6", #666666));
  btns.add(new Button("-", #333333));
  btns.add(new Button("1", #666666));
  btns.add(new Button("2", #666666));
  btns.add(new Button("3", #666666));
  btns.add(new Button("+", #333333));
  btns.add(new Button("±", #333333));
  btns.add(new Button("0", #666666));
  btns.add(new Button(".", #333333));
  btns.add(new Button("=", #55BB55));
  //distribute buttons
  for (int i = 0; i < btns.size(); i++) {
    int x = i%4;
    int y = (int)i/4;

    Button b = btns.get(i);

    b.x = x * bW + bW/2;
    b.y = y * bH + bH/2 + sp;
  }
}


void draw () {
  background(#222222);
  updateScreen();
  //println("Left:" + last + " RIGHT:" + current + " Operator:" + operation);
}


void updateScreen () {
  for (int i = 0; i < btns.size(); i++) {
    btns.get(i).drawBtn();
  }

  //Text Formatting :(
  textAlign(RIGHT, CENTER);
  textSize(40);
  float cur = Float.parseFloat(current);
  if (current == "0") cur = Float.parseFloat(last);
  String curT = cur + "";
  if ((int)cur == cur) curT = (int)cur + "";
  if (current.contains("-") && !curT.contains("-")) curT = "-" + curT;
  text(curT, 300 - 10, sp/2);

  //Options
  textAlign(LEFT, TOP);
  textSize(15);
  text(operation, 10, 7);

  //Memory Indicator
  text((mem.length() == 0 || Float.parseFloat(mem) > 0 ? "M" : ""), 30, 7);
}


void mousePressed () {
  for (int i = 0; i < btns.size(); i++) {
    Button b = btns.get(i);
    if (b.mouseOver()) {
      btnPress(b.title);
      break;
    }
  }
}


void keyPressed () {
  try {
    int num = Integer.parseInt(key + "");
    btnPress(num+"");
  }
  catch (NumberFormatException e) {
    switch(key) {
    case '+':
      btnPress("+");
      break;
    case '-':
      btnPress("-");
      break;
    case '*':
      btnPress("×");
      break;
    case '/':
      btnPress("÷");
      break;
    case '=':
    case '\n':
      btnPress("=");
      break;
    case '.':
      btnPress(".");
      break;
    case '': //del key
    case '': //backspace key
      btnPress("del");
      break;
    default:
      switch(keyCode) {
        case KeyEvent.VK_CLEAR:
          btnPress("C");
          break;
        case KeyEvent.VK_PAGE_UP:
          btnPress("^");
          break;
        case KeyEvent.VK_PAGE_DOWN:
          btnPress("√");
          break;
        case KeyEvent.VK_END:
          btnPress("±");
          break;
        default:
          println(keyCode);
      }
    }
  }
}


String[] lastCalc = {"0","+"};
String mem = "0";
String current = "0";
String last = "0";
String operation = "";
void btnPress (String btn) {
  try {
    int num = Integer.parseInt(btn);
    current+=num;
  }
  catch (NumberFormatException e) {
    switch (btn) {
    case "C":
      current = "0";
      last = "0";
      operation = "";
      break;

    case "+":
    case "-":
    case "×":
    case "÷":
    case "^":
      calculate(false);
      operation = btn;
      break;
    case "√":
      float op = Float.parseFloat(current);
      if (op == 0) {
        op = Float.parseFloat(last);
      }
      if (op < 0) {
        last = "ERR";
      } else {
        last = Math.pow(op, 0.5) + "";
      }
      current = "0";
      operation = "";
      break;

    case "=":
      calculate(true);
      break;

    case ".":
      if (!current.contains(".")) current+=".";
      break;
    case "±":
      if (current.contains("-")) {
        current = current.substring(1, current.length());
      } else {
        current = "-" + current;
      }
      break;

    case "del":
      if (current.length() > 0) {
        current = current.substring(0, current.length() - 1);
      }
      if (current.length() <= 1) {
        current = "0";
      }
      break;

    case "MS":
      mem = (Float.parseFloat(current) != 0) ? current : last;
      break;
    case "MR":
      current = mem;
      break;
    case "MC":
      mem = "0";
      break;

    default:
      //println("Button not added yet");
    }
  }
  //println(current);
}
void calculate(boolean full) {
  double l;
  double cur;
  String op;
  if (operation == "") {
    if (current == "0" && full) {
      l = Float.parseFloat(last);
      cur = Float.parseFloat(lastCalc[0]);
      op = lastCalc[1];
    } else {
      last = (current != "0") ? current : last;
      current = "0";
      return;
    }
  } else {
    l = Float.parseFloat(last);
    cur = Float.parseFloat(current);
    op = operation;
  }
  
  
  switch (op) {
  case "+":
    l+=cur;
    break;
  case "-":
    l-=cur;
    break;
  case "×":
    l*=cur;
    break;
  case "÷":
    l/=cur;
    break;
  case "^":
    l = (float)Math.pow(l, cur);
    break;
  default:
    l = cur;
  }
  
  lastCalc[0] = cur + "";
  lastCalc[1] = op;
  
  last = "" + l;
  current = "0";
  operation = "";
}
