class Vector {
	double x,y;

	double angle () {
		return Math.atan(y/x) + ((x < 0) ? Math.PI : 0);
	}
	double magnitude () {
		return Math.sqrt(Math.pow(x,2) + Math.pow(y,2));
	}
	Vector normal () {
		return new Vec2d(x/magnitude(),y/magnitude());
	}

	Ray ray (double x, double y) {
		return new Ray(x,y,this);
	}
}
class VecRM extends Vector {
	VecRM (double rot, double mag) {
		x = Math.cos(rot) * mag;
		y = Math.sin(rot) * mag;
	}
}
class Vec2d extends Vector {
	Vec2d (double x, double y) {
		this.x = x;
		this.y = y;
	}
}
class Ray extends Vector { //Vector with spacial displacement
	double dx, dy; //coordinate of ray
	Ray (double x, double y, Vector v) {
		this.x = v.x;
		this.y = v.y;
		this.dx = x;
		this.dy = y;
	}

	boolean intersect (Ray r) {
		//See Intersection of Vector Rays on Desmos School Account
		double s = (r.y*(dx-r.dx) - r.x*(dy-r.dy))/(y*r.x - x*r.y);
		if (s < 0 || s > 1) return false;

 		double t = (dx + s*x - r.dx)/(r.x);
		if (Double.isNaN(t) || t == Double.POSITIVE_INFINITY || t == Double.NEGATIVE_INFINITY) t = (dy + s*y - r.dy)/(r.y);
		if (t < 0 || t > 1) return false;
		return true;
	}
	double[] intersectPoint (Ray r) {
		double s = (r.y*(dx-r.dx) - r.x*(dy-r.dy))/(y*r.x - x*r.y);
		if (s < 0 || s > 1) return null;

 		double t = (dx + s*x - r.dx)/(r.x);
		if (Double.isNaN(t) || t == Double.POSITIVE_INFINITY || t == Double.NEGATIVE_INFINITY) t = (dy + s*y - r.dy)/(r.y);
		if (t < 0 || t > 1) return null;

		double[] ret = {dx + s*x, dy + s*y};
		return ret;
	}

	void debugDisplay () {
		int[] p1 = CAMERA.sceneToCamera((int)dx,(int)dy);
		int[] p2 = CAMERA.sceneToCamera((int)(dx + x),(int)(dy + y));
		stroke(#ff0000);
		strokeWeight(1);
		line(p1[0],p1[1],p2[0],p2[1]);
	}
}
