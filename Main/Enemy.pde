
//Jakob
class Enemy
{
	color baseColor;
	color eyeColor;

	PVector pos;
	PVector oldPos = new PVector(); //för riktningsändring

	float eSize = 20;
	float eSizeY = 20;

	float amountToAddToScore;
	Enemy()
	{
		//behövdes för arv
	}
	Enemy(float x, float y, float scoreGive)
	{
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
		ellipse(pos.x, pos.y, eSize, eSizeY);
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
		explotions.add(new Explotion(pos.x,pos.y));
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

class RedShip extends Enemy{

	float speed;
	int amountOfTimesToBounce = 2;
	
	RedShip(int bounces)
	{
		amountOfTimesToBounce = bounces;
		eSizeY = 12;
		pos = new PVector(eSize, eSizeY);
		speed = 2.5f;
		baseColor = color(255, 13, 0);
		eyeColor = color(7);
		amountToAddToScore = 300;

		float r = random(-1,2);
		if (r > 0) 
			pos.x = 800 - eSize/2 - 5;	//800 = wídth
		else
			pos.x = eSize/2 + 5;
	
	}

	void draw()
	{
		super.draw(speed);
	}

	void boarderCheck()
	{
		if (pos.x > width - eSize/2 && amountOfTimesToBounce > 0)
		{
			pos.x = width - eSize/2 - 5;
			speed *= -1;
			amountOfTimesToBounce--;
		}
		else if(pos.x < eSize/2 && amountOfTimesToBounce > 0)
		{
			speed *= -1;
			pos.x = eSize/2 + 5;
			amountOfTimesToBounce--;
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
		//explotions.add(new Explotion(pos.x,pos.y));
		muzzleFlashes.add(new MuzzleFlash(pos.x + sizeW/2, pos.y + sizeH - 5, 0.2f, color(255, 207, 0), 30));
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
	float maxSpeed = 3f;

	ArrayList<Enemy> enemys = new ArrayList<Enemy>();
	boolean canChange = true;

	float t; //debugTimer sätter variablar till true

	void spawnEnemys()
	{
		float xStart = 100;
		float yStart = 50;

		float xDist = (width - xStart * 2)/xRow;
		float yDist = 25; //bör va lite större än eSize

		speedIncreasePerDeath = maxSpeed/xRow/yRow;

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
			//float s = enemys.get(r).eSize;
			//muzzleFlashes.add(new MuzzleFlash(temp.x, temp.y + s, 0.3f, color(255,255,255,40)));
			bullets.add(new EnemyProjectile(temp.x, temp.y));
		}
	}
}

//sätta ihop till effekt klass
class Explotion
{
	color c;
	float rad;
	float maxRad;
	float radPerFrame;
	PVector pos;
	float timeSpawned;
	float duration;
	boolean done = true;
	Explotion(float x, float y)
	{
		done = false;
		pos = new PVector(x,y);
		c = color(255, 13, 0);
		rad = 0;
		maxRad = 40;
		timeSpawned = millis();
		duration = 0.5f * 1000;
		radPerFrame = (maxRad/30)/0.5f;
	}

	void draw()
	{
		if(rad <= maxRad && done == false)
		{
			rad += radPerFrame;
		}
		else
		{
			done = true;
			rad -= radPerFrame;
		}

		fill(c);
		stroke(c);
		ellipse(pos.x, pos.y, rad, rad);
		
		fill(color(255, 124, 0));
		stroke(color(255, 124, 0));
		ellipse(pos.x, pos.y, rad/1.5, rad/1.5);


		fill(color(255, 180, 0));
		stroke(color(255, 180, 0));
		ellipse(pos.x, pos.y, rad/3, rad/3);
		remove();
	}

	void remove()
	{
		if (millis() > timeSpawned + duration) {
			explotions.remove(this);
		}
	}
}

class MuzzleFlash
{
	color c;
	float timeOut;
	PVector pos;
	float timeSpawned;
	float muzzleSizeX;
	
	MuzzleFlash(float x, float y, float t, color c, float sizeX)
	{
		pos = new PVector(x,y);
		timeOut = t * 1000;
		this.c = c;
		timeSpawned = millis();
		muzzleSizeX = sizeX;
	}

	void draw()
	{
		fill(c);
		stroke(c);
		rect(pos.x - muzzleSizeX/2, pos.y, muzzleSizeX, 2, 20);
		//rect(pos.x, pos.y - muzzleSizeX/2, 2, muzzleSizeX, 20);
		remove();
	}

	void remove()
	{
		if (millis() > timeSpawned + timeOut) {
			muzzleFlashes.remove(this);
		}
	}
}