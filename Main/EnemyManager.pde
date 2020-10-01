

//Jakob
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
