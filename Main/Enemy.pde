class Enemy
{
	color baseColor;
	color eyeColor;

	PVector pos;
	PVector oldPos = new PVector(); //för riktningsändring

	float eSize = 20;

	Enemy(float x, float y)
	{
		float redval = random(60, 81);
		baseColor = color(redval, (200 - redval), 0);
		eyeColor = color(random(60, 200));
		
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

	Enemy[][] enemys = new Enemy[xRow][yRow];
	boolean canChange = true;

	void spawnEnemys()
	{
		float xStart = 100;
		float yStart = 50;

		float xDist = (width - xStart * 2)/xRow;
		float yDist = 25; //bör va lite större än eSize

		for (int x = 0; x < xRow; ++x) {
			for (int y = 0; y < yRow; ++y) {
				enemys[x][y] = new Enemy(xStart + x * xDist, yStart + y * yDist);
			}		
		}
	}
	
	void draw()
	{
		for (int x = 0; x < xRow; ++x) {
			if(x == 0)
			{
				currentSpeed = dirX * speedMag; //speed = dirX * 2;
			}

			for (int y = 0; y < yRow; ++y) {
				enemys[x][y].draw(currentSpeed);
			}
		}
	}

	void moveDown(float distDown)
	{
		for (int x = 0; x < xRow; ++x) {
			for (int y = 0; y < yRow; ++y) {
				enemys[x][y].pos.y += distDown;
			}
		}
	}

}