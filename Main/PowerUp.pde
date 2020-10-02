class PowerUp {

	PVector pos;
	color c;
	boolean active;
	float time;
	float pickUpTime;
	
	PowerUp() {
		float x = random(20, width - 20);
		float y = player.position.y + player.sizeH;
		pos = new PVector(x,y);
		c = color(200);
		active = false;
	}

	void draw() {
		if(!active)	{
			stroke(c + 50);
			fill(c);
			ellipse(pos.x, pos.y, 20, 20);
			coll();
		}
		else if (active) {
			remove();
		}
	}

	void coll() {
		if(PVector.dist(player.position, pos) < 40) {
			pickUpTime = millis();
			active = true;
			powerUpSound.play();
			start();
		}
	}

	void remove() {
		if (millis() > time) {
			end();
			powerUps.remove(this);
		}
	}

	void start(){}

	void end(){}
}

class SpeedBoost extends PowerUp {	
	
	float duration;
	color playerOgColor;

	SpeedBoost(float time) {
		duration = time * 1000;
		c = color(255, 209, 48);
	}

	void start() {
		playerOgColor = player.playerColor;
		player.playerColor = color(255, 209, 48);
		time = pickUpTime + duration;
		player.speed *= 2;
		playerProjectileSizeW += 4;
		playerProjectileSizeH += 10;
		playerProjectileSpeed += 150;
	}

	void end() {
		player.speed = player.speed/2;
		player.playerColor = playerOgColor;
		playerProjectileSizeW -= 4;
		playerProjectileSizeH -= 10;
		playerProjectileSpeed -= 150;
	}
}

class ExtraLife extends PowerUp {
	
	ExtraLife() {
		c = color(255, 72, 48);
	}

	void start() {
		player.lives += 1;
	}
}

class LargerBullets extends PowerUp {
	
	float duration;

	LargerBullets(float time) {
		duration = time * 1000;
	}

	void start() {
		time = pickUpTime + duration;
		playerProjectileSizeW += 10;
		playerProjectileSizeH += 14;
	}

	void end() {
		playerProjectileSizeW -= 10;
		playerProjectileSizeH -= 14;
	}
}

class ScoreDoubler extends PowerUp {

}