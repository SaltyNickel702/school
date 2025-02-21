class Weapon {
	int dmg, w, h;
	double speed, rate;
	color clr;
	int lvl;
	String name;

	Runnable ondeath = () -> {};
}

class BaseLaser extends Weapon {
	BaseLaser () {
		rate = 4;
		dmg = 100;
		speed = 750;
		clr = #00ff00;
		w = 4;
		h = 60;
		lvl = 1;
		name = "BaseLaser";
	}
}
class Minigun extends Weapon {
	Minigun () {
		rate = 30;
		dmg = 13;
		speed = 1500;
		clr = #ffff00;
		w=2;
		h = 175;
		lvl = 2;
		name = "Minigun";
	}
}
class Nuke extends Weapon {
	Nuke () {
		rate = 2;
		dmg = 0;
		speed = 500;
		clr = #ff8800;
		w = 7;
		h = 60;
		lvl = 3;
		name = "Nuke";
	}
}

class EnemyLaser extends Weapon {
	EnemyLaser () {
		rate = 0.25;
		dmg = 30;
		speed = 500;
		clr = #ff0000;
		w = 4;
		h = 50;
		lvl = 1;
		name = "EnemyLaser";
	}
}
