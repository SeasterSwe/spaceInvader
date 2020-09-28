class Enemy
{
	color baseColor;
	color eyeColor;

	PVector pos;
	PVector oldPos = new PVector(); //för riktningsändring

	float eSize = 20;

	Enemy(float x, float y)
	{
		float redVal = random(80,250);
		float blueVal = random(40, 60);
		color c = color(redVal, 0, blueVal);
		baseColor = c;
		eyeColor = color(random(170, 210));
		
		ellipseMode(CENTER);
		pos = new PVector(x,y);
	}

	void draw(float x)
	{
		boarderCheck();
		debugBoarder();
		stroke(baseColor);
		fill(baseColor);
		
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


		popMatrix(); 
	}

	void eyes()
	{
        stroke(eyeColor);
        fill(eyeColor);
        circle(eSize/4, -eSize/4, eSize/5); //bättre med rect?
        circle(-eSize/4, -eSize/4, eSize/5);
	}

	void legs(float length, float legSpeed)
	{
		float f = sin(frameCount * legSpeed);
		strokeWeight(3);
		stroke(baseColor);
		line(-eSize/2, eSize/2, -eSize + f * 6f, length + f * 6f);
		line(eSize/2, eSize/2, eSize + f * 6f, length + f * 6f);
	}

	void boarderCheck()
	{
		if (pos.x > width - (eSize * 2))  {
			dirX = -1;
			oldPos.x = pos.x;
			enemyManager.moveDown(1);
		}
		else if(pos.x < eSize*2)
		{
			dirX = 1;
			oldPos.x = pos.x;
			enemyManager.moveDown(1);
		}
	}

	void debugBoarder()
	{
		if (oldPos.x - 60 > pos.x || oldPos.x + 60 < pos.x) {
			enemyManager.canChange = true;
		}
	}
}

static float dirX = 1;

class EnemyManager
{
	int xRow = 12;
	int yRow = 8;

	float speedMag = 2; // lite oklart ska inte ljuga
	float currentSpeed = 2;

	ArrayList<Enemy> enemys = new ArrayList<Enemy>();
	boolean canChange = true;

	void spawnEnemys()
	{
		float xStart = 100;
		float yStart = 50;

		float xDist = (width - xStart * 2)/xRow;
		float yDist = 25; //bör va lite större än eSize

		for (int x = 0; x < xRow; ++x) {
			for (int y = 0; y < yRow; ++y) {
				enemys.add(new Enemy(xStart + x * xDist, yStart + y * yDist));
			}		
		}
	}
	
	void draw()
	{
		for (int i = 0; i < enemys.size(); ++i) {
			if(i == 0)
			{
				currentSpeed = dirX * speedMag; //speed = dirX * 2;
			}
			enemys.get(i).draw(currentSpeed);
		}
	}

	void moveDown(float distDown)
	{
		for (int i = 0; i < enemys.size(); ++i) {
			enemys.get(i).pos.y += distDown;
		}
	}

}