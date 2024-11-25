class Animation {
	Runnable next;

	int frame = 0;
	int ticks;
	int totalFrames;
	float animDur;

	Animation (int total, float dur) {
		totalFrames = total;
		animDur = dur;
	}

	void tick () {
		if (!physicsRunning) return;
		ticks++;
		if (ticks >= animDur/totalFrames * frameRate) {
			ticks = 0;
			frame++;
			if (frame >= totalFrames) frame = 0;
			next.run();
		}
	}
}