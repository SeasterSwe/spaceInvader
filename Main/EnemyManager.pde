

//Jakob
static float dirX = 1;
class EnemyManager {
	int xRow = 12;
	int yRow = 8;

	float speedMag = 1; // lite oklart ska inte ljuga
	float currentSpeed = 1;
	float speedIncreasePerDeath;
	float maxSpeed = 3f;
	float t;

	ArrayList<Enemy> enemys = new ArrayList<Enemy>();
	boolean canChange = true;
	 //debugTimer sätter variablar till true

	void spawnEnemys() {
		float xStart = 100;
		float yStart = 50;

		float xDist = (width - xStart * 2)/xRow;
		float yDist = 25; //bör va lite större än eSize

		speedIncreasePerDeath = maxSpeed/xRow/yRow;
		
		color startColor = color(16, 121, 23);
		color endColor = color(171,23,0); //111,19,0(röd) //154,44,20(orange)
		float startVal = 1;
		float lerpVal = 1f/yRow; 

		for (int y = 0; y < yRow; ++y) {
			startVal -= lerpVal;
			color baseColor = lerpColor(startColor, endColor, startVal);
			
			for (int x = 0; x < xRow; ++x) {
				float amountOfScoreToGive = 10 * (2+yRow - y);
				enemys.add(new Enemy(xStart + x * xDist, yStart + y * yDist, amountOfScoreToGive, baseColor));
			}		
		}
		shoot();
	}
	
	void draw() {
		debugBoarder();
		for (int i = 0; i < enemys.size(); ++i) 
		{
			if(i == 0)
			{
				currentSpeed = dirX * speedMag; //speed = dirX * 2;
			}
			enemys.get(i).draw(currentSpeed);
		}
	}

	boolean moveDownActive = true;
	void moveDown(float distDown) {		
		if(moveDownActive) {
			t = millis() + 1000;
			moveDownActive = false;

			for (int i = 0; i < enemys.size(); ++i) {
				enemys.get(i).pos.y += distDown;
			}
		}
	}

	void debugBoarder() {
		if (t < millis()) {
			enemyManager.canChange = true;
			enemyManager.moveDownActive = true;
		}
	}

	void increaseSpeed() {
		speedMag += speedIncreasePerDeath;
	}

	void shoot() {		
		if(enemys.size() > 0) {	
			int r = (int)random(0, enemys.size());
			PVector temp = enemys.get(r).pos;
			bullets.add(new EnemyProjectile(temp.x, temp.y));
		}
	}
}
