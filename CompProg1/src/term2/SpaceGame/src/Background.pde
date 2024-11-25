class Background extends GameObject {
	
	float speed;

	Background (String name, float scale, float speed) {
		this.speed = speed;
		ignore = true;

		Sprite b1 = new Sprite(name,0,height/2,-1,-1);
		b1.scale = scale;
		sprites.add(b1);

		Sprite b2 = new Sprite(name,0,height*3/2,-1,-1);
		b2.scale = scale;
		sprites.add(b2);

		b1.tick = () -> {
			b1.dy -= height/(speed*frameRate);
			if (b1.dy < -height/2) {
				b1.dy = height*3/2;
			}
		};
		b2.tick = () -> {
			b2.dy -= height/(speed*frameRate);
			if (b2.dy < -height/2) {
				b2.dy = height*3/2;
			}
		};
	}
}
