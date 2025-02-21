class Projectile extends GameObject {
	Vector vec;
	int w,l;
	int dmg;
	color clr;
	ArrayList<String> ignoredTags = new ArrayList<String>();

	Weapon weaponType;


	Projectile (double X, double Y, Vector Vec, color Clr, int W, int L, int Dmg, String[] ignored) {
		tags.add("Projectile");

		x = X;
		y = Y;
		vec = Vec;

		clr = Clr;
		w = W;
		l = L;
		dmg = Dmg;

		for (String t : ignored) {
			ignoredTags.add(t);
		}

		this.logic = () -> {
			x+=vec.x * timeCoef();
			y+=vec.y * timeCoef();

			if (x < -width || x > width || y < -height || y > height * 2) {
				remove();
			}
		};
	}


	void display () {
		stroke(clr);
		strokeWeight(w);

		
        int[] from = CAMERA.sceneToCamera((int)x,(int)y);
		Vector toC = new VecRM(vec.angle(),l);
		int[] to = CAMERA.sceneToCamera((int)(x+toC.x),(int)(y+toC.y));
		if (!DEBUG.drawProjectileRay) line(from[0],from[1],to[0],to[1]);


		//Debug Renderer
		noStroke();
		int[] camCoor = CAMERA.sceneToCamera((int)x,(int)y);
		if (DEBUG.showObjCenter) {
			fill(#ff0000);
            ellipse(camCoor[0],camCoor[1],10,10);
        }
		if (DEBUG.showProjectileCheckRadius) {
			fill(255,0,0,80);
			ellipse(camCoor[0],camCoor[1],l*5 * 2,l*5 * 2);
		}
		if (DEBUG.drawProjectileRay) {
			Ray r = getRay();
			r.debugDisplay();
		}
	}

	Ray getRay () {
		Vector v = vec.normal();
		v.x*=l;
		v.y*=l;
		return v.ray(x,y);
	}

	boolean hits (GameObject obj) {
		try {
			for (String str : ignoredTags) {
				if (obj.tags.contains(str)) return false;
			}
			Collider c = obj.collider();
			Ray[] rays = c.getSides();
			Ray curRay = getRay();

			for (Ray r : rays) {
				if (r.intersect(curRay)) return true;
			}
		} catch (NullPointerException e) {}
		return false;
	}
}
