class Menu {
	boolean hidden = false;

	ArrayList<Rect> rects = new ArrayList<Rect>();
	ArrayList<TextElement> text = new ArrayList<TextElement>();
	ArrayList<Sprite> sprites = new ArrayList<Sprite>();
	ArrayList<Button> buttons = new ArrayList<Button>();


	void display () {
		if (!hidden) {
			for (Rect r : rects) {
				r.display();
			}
			for (TextElement t : text) {
				t.display();
			}
			for (int i = 0; i < sprites.size(); i++) {
				sprites.get(i).display(0,0);
			}
		}
		
	}
	void interact () {
		if (hidden) return;
		for (Button b : buttons) {
			b.check();
		}
	}

	void removeSprite (Sprite s) {
		sprites.removeIf((n) -> n == s);
	}
}

class Rect {
	int x,y,w,h,r;
	color clr;

	Rect (int x, int y, int w, int h, int r, color clr) {
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.r = r;
		this.clr = clr;
	}

	void display () {
		noStroke();
		fill(clr);
		rect(x,y,w,h,r);
	}
}
class TextElement {
	int x, y, fontSize;
	String txt;
	color clr;
	
	TextElement (String txt, int x, int y, int fontSize, color clr) {
		this.txt = txt;
		this.x = x;
		this.y = y;
		this.fontSize = fontSize;
		this.clr = clr;
	}

	void display () {
		fill(clr);
		textSize(fontSize);
		text(txt,x,y);
	}
}
class Button {
	int x,y,w,h;
	Runnable handler;
	
	Button (int x, int y, int w, int h, Runnable handler) {
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.handler = handler;
	}

	void check () {
		if (mouseX < x+w/2 && mouseX > x-w/2) {
			if (mouseY < y+h/2 && mouseY > y-h/2) {
				handler.run();
			}
		}
	}
}
