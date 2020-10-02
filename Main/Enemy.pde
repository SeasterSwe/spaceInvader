

//Jakob
class Enemy {
	color baseColor;
	color eyeColor;

	PVector pos;
	PVector oldPos = new PVector(); //för riktningsändring

	float eSize = 20;
	float eSizeY = 20;

	float amountToAddToScore;

	//behövdes för arv
	Enemy(){}

	Enemy(float x, float y, float scoreGive) {
		baseColor = color(16, 121, 23);
		eyeColor = color(152, 196, 155);
		
		ellipseMode(CENTER);
		pos = new PVector(x,y);
		amountToAddToScore = scoreGive;
	}

	void draw(float x) {
		boarderCheck();
		stroke(baseColor);
		fill(baseColor);
		strokeWeight(3);
		pos.x += x;
		ellipse(pos.x, pos.y, eSize, eSizeY);
		animation();
	}

	void animation() {
		pushMatrix();
		translate(pos.x,pos.y);
		
		legs(10, 0.2);
		eyes(); //hhaahah i tried
		mouth(); //ganskailla

		popMatrix(); 
	}

	void eyes() {
        stroke(eyeColor);
        fill(eyeColor);
        strokeWeight(2);
        line(-6, -6, -2, -5);
        line(6, -6, 2, -5); 
        ellipse(eSize/4, -eSize/4, 4, 2);
        ellipse(-eSize/4, -eSize/4, 4, 2);
	}

	void legs(float length, float legSpeed) {
		float f = sin(frameCount * legSpeed);
		strokeWeight(3);
		stroke(baseColor);
		line(-eSize/2, eSize/2, -eSize + f * 6f, length + f * 6f);
		line(eSize/2, eSize/2, eSize + f * 6f, length + f * 6f);
	}

	void mouth() {
		stroke(eyeColor);
		noFill();
		rotate(180);
		arc(-8, -8, eSize/2, eSize/2, -0.2, 1.6);
	}

	void killed() {
		enemyManager.increaseSpeed();
		score += amountToAddToScore;
		//effekts.add(new Explotion(pos.x,pos.y));
		enemyManager.enemys.remove(this);
	}

	void boarderCheck() {
		if (pos.x > width - (eSize * 2)) {
			dirX = -1;
			oldPos.x = pos.x;
			enemyManager.moveDown(2);
		}
		else if(pos.x < eSize*2) {
			dirX = 1;
			oldPos.x = pos.x;
			enemyManager.moveDown(2);
		}
	}
}

class RedShip extends Enemy{

	float speed;
	int amountOfTimesToBounce = 2;
	
	RedShip(int bounces) {
		amountOfTimesToBounce = bounces;
		eSizeY = 12;
		pos = new PVector(eSize, eSizeY * 2);
		speed = 2.5f;
		baseColor = color(255, 186, 48);
		eyeColor = color(7);
		amountToAddToScore = 300;

		float r = random(-1,2);
		if (r > 0) 
			pos.x = 800 - eSize/2 - 5;	//800 = wídth
		else
			pos.x = eSize/2 + 5;
	
	}

	void draw() {
		super.draw(speed);
	}

	void boarderCheck() {
		if (pos.x > width - eSize/2 && amountOfTimesToBounce > 0) {
			pos.x = width - eSize/2 - 5;
			speed *= -1;
			amountOfTimesToBounce--;
		}
		else if(pos.x < eSize/2 && amountOfTimesToBounce > 0) {
			speed *= -1;
			pos.x = eSize/2 + 5;
			amountOfTimesToBounce--;
		}
	}
}

class EnemyProjectile {
	PVector pos;
	float speed = 2;
	float sizeW = 4;
	float sizeH = 15;

	EnemyProjectile(float x, float y) {
		pos = new PVector(x, y);
	}

	void draw() {
		pos.y += speed;
		
		float f = sin(frameCount * 0.2);
		
		stroke(206, 176, 0); //stor
		strokeWeight(4.5);
		line(pos.x + sizeW/2, pos.y, pos.x + sizeW/2 + f * 1.5, pos.y - 7);
		
		strokeWeight(2.5); //liten
		stroke(206, 121, 0);
		line(pos.x + sizeW/2, pos.y, pos.x + sizeW/2 + f * 1.5, pos.y - 7);

		color c = color(204, 0, 5); //bullet
		stroke(c);
		fill(c);
		strokeWeight(1);
		rect(pos.x - sizeW, pos.y + sizeW, 8 + sizeW, 2);
		rect(pos.x, pos.y, sizeW, sizeH, 2,2,10,10);
		collison();

		outOfScreen();
	}

	void collison()	{

		if (shields.size() >= 1) {
			for (int i = 0; i < shields.size(); i++) {
				float shieldX = shields.get(i).pos.x;
				float shieldY = shields.get(i).pos.y;
				int shieldW = shields.get(i).sizeW;
				int shieldH = shields.get(i).sizeH;
			
			if ((pos.x >  shieldX && pos.x < shieldX + shieldW) ||
			 (pos.x + sizeW >  shieldX && pos.x + sizeW < shieldX + shieldW)) {
					if (pos.y + sizeH < shieldY + shieldH && pos.y + sizeH >shieldY) {
						shields.remove(i);
						remove();
						break;
					}
				}	
		}	
	}

		float x1 = player.position.x;
		float x2 = player.sizeW + x1;
		if(abs(player.position.y - pos.y) < player.sizeH - 10) {
			if (pos.x + sizeW > x1 && pos.x < x2) {
				player.killed();
				remove();
			}
		}
	}

	void outOfScreen() {
		if (pos.y > player.position.y + player.sizeH - sizeH) {
			remove();
		}
	}

	void remove() {
		//explotions.add(new Explotion(pos.x,pos.y));
		effekts.add(new MuzzleFlash(pos.x + sizeW/2, pos.y + sizeH - 5, 0.2f, color(255, 207, 0), 30));
		enemyManager.shoot();
		bullets.remove(this);
	}
}
