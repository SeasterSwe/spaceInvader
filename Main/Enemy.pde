
//Jakob
class Enemy
{
	color baseColor;
	color eyeColor;

	PVector pos;
	PVector oldPos = new PVector(); //för riktningsändring

	float eSize = 20;

	float amountToAddToScore;
	Enemy(float x, float y, float scoreGive)
	{
		//float redVal = random(80,250);
		//float blueVal = random(40, 60);
		//color c = color(redVal, 0, blueVal);
		baseColor = color(16, 121, 23);
		eyeColor = color(152, 196, 155);
		
		ellipseMode(CENTER);
		pos = new PVector(x,y);
		amountToAddToScore = scoreGive;
	}

	void draw(float x)
	{
		boarderCheck();
		stroke(baseColor);
		fill(baseColor);
		strokeWeight(3);
		pos.x += x;
		ellipse(pos.x, pos.y, eSize, eSize);
		animation();

	}

	void animation()
	{
		pushMatrix();
		translate(pos.x,pos.y);
		
		legs(10, 0.2);
		eyes(); //hhaahah i tried
		mouth(); //ganskailla

		popMatrix(); 
	}

	void eyes()
	{
        stroke(eyeColor);
        fill(eyeColor);
        strokeWeight(2);
        line(-6, -6, -2, -5);
        line(6, -6, 2, -5); 
        ellipse(eSize/4, -eSize/4, 4, 2);
        ellipse(-eSize/4, -eSize/4, 4, 2);
	}

	void legs(float length, float legSpeed)
	{
		float f = sin(frameCount * legSpeed);
		strokeWeight(3);
		stroke(baseColor);
		line(-eSize/2, eSize/2, -eSize + f * 6f, length + f * 6f);
		line(eSize/2, eSize/2, eSize + f * 6f, length + f * 6f);
	}

	void mouth()
	{
		stroke(eyeColor);
		noFill();
		rotate(180);
		arc(-8, -8, eSize/2, eSize/2, -0.2, 1.6);
	}

	void killed()
	{
		enemyManager.increaseSpeed();
		score += amountToAddToScore;
		//println("amountToAddToScore: "+amountToAddToScore);
		enemyManager.enemys.remove(this);
	}

	void boarderCheck()
	{
		if (pos.x > width - (eSize * 2))  {
			dirX = -1;
			oldPos.x = pos.x;
			enemyManager.moveDown(2);
		}
		else if(pos.x < eSize*2)
		{
			dirX = 1;
			oldPos.x = pos.x;
			enemyManager.moveDown(2);
		}
	}
}

class EnemyProjectile
{
	PVector pos;
	float speed = 2;
	float sizeW = 4;
	float sizeH = 15;

	EnemyProjectile(float x, float y)
	{
		pos = new PVector(x, y);
	}

	void draw()
	{
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

	void collison()
	{
		float x1 = player.position.x;
		float x2 = player.sizeW + x1;
		if(abs(player.position.y - pos.y) < player.sizeH - 10)
		{
			if (pos.x + sizeW > x1 && pos.x < x2) {
				player.killed();
				remove();
			}
		}
	}

	void outOfScreen()
	{
		if (pos.y > player.position.y + player.sizeH - sizeH) {
			remove();
		}
	}

	void remove()
	{
		enemyManager.shoot();
		bullets.remove(this);
	}
}

static float dirX = 1;

class EnemyManager
{
	int xRow = 12;
	int yRow = 8;

	float speedMag = 1; // lite oklart ska inte ljuga
	float currentSpeed = 1;
	float speedIncreasePerDeath;

	ArrayList<Enemy> enemys = new ArrayList<Enemy>();
	boolean canChange = true;

	float t; //debugTimer sätter variablar till true

	void spawnEnemys()
	{
		float xStart = 100;
		float yStart = 50;

		float xDist = (width - xStart * 2)/xRow;
		float yDist = 25; //bör va lite större än eSize

		speedIncreasePerDeath = 3f/xRow/yRow;

		for (int x = 0; x < xRow; ++x) {
			for (int y = 0; y < yRow; ++y) {
				float amountOfScoreToGive = 10 * (2+yRow - y);
				enemys.add(new Enemy(xStart + x * xDist, yStart + y * yDist, amountOfScoreToGive));
			}		
		}
		shoot();
	}
	
	void draw()
	{
		debugBoarder();
		for (int i = 0; i < enemys.size(); ++i) {
			if(i == 0)
			{
				currentSpeed = dirX * speedMag; //speed = dirX * 2;
			}
			enemys.get(i).draw(currentSpeed);
		}
	}

	boolean moveDownActive = true;
	void moveDown(float distDown)
	{
		if(moveDownActive)
		{
			t = millis() + 1000;
			moveDownActive = false;
			for (int i = 0; i < enemys.size(); ++i) {
				enemys.get(i).pos.y += distDown;
			}
		}
	}

	void debugBoarder()
	{
		if (t < millis()) {
			enemyManager.canChange = true;
			enemyManager.moveDownActive = true;
		}
	}

	void increaseSpeed()
	{
		speedMag += speedIncreasePerDeath;
	}

	void shoot()
	{
		if(enemys.size() > 0)
		{
			int r = (int)random(0, enemys.size());
			PVector temp = enemys.get(r).pos;
			bullets.add(new EnemyProjectile(temp.x, temp.y));
		}
	}
}