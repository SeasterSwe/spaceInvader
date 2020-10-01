float deltaTime;
float time;
Player player;
Ui ui = new Ui();

EnemyManager enemyManager = new EnemyManager();
ArrayList<EnemyProjectile> bullets = new ArrayList<EnemyProjectile>();

ArrayList<Effekt> effekts = new ArrayList<Effekt>();

RedShip redship;
float timeToSpawnRedShip;


ArrayList<Shield> shields = new ArrayList<Shield>();

static boolean alive = true;
static int score = 0;

void setup() {
	frameRate(60);
	size(800, 500);
	player = new Player();
	enemyManager.spawnEnemys();

	timeToSpawnRedShip = 7000;

	createShields();

}

void draw() {
	clearBackground();
	long currentTime = millis();
	deltaTime = (currentTime - time) * 0.001f;

	drawBullets();
	player.update();
	enemyManager.draw();


	gameClearCheck();
	

	drawEffekts();

	drawSheilds();
	ui.draw();
	//shield.draw();

	restart();
	time = currentTime;
	if(redship != null)
		redship.draw();

	spawnRedShip();
}


void drawBullets()
{
	if(bullets.size() > 0)
	for (int i = 0; i < bullets.size(); ++i) {
		bullets.get(i).draw();
	}
}


void drawEffekts()
{
	if (effekts.size() > 0) {
		for (int i = 0; i < effekts.size(); ++i) {
			effekts.get(i).draw();
		}		
	}
}	

void createShields() {
	int sizeW = 15;
	int sizeH = 10;
	for(int j = 1; j <= 4; j++) {
			int x = width / 5 * j - 4 * sizeW;
			int y = 140;

			for(int i = 1; i <=21; i++) {
				    shields.add(new Shield(x, height - y));
				if (i % 3 == 0 && i != 0) {

					x += sizeW ; 
					
					if (i < 12) {
						y-= sizeH * 2;
					}
					else {
					y-= sizeH * 4;
					}
				}
				
				y += sizeH;
			}
		}
		println(shields.size());
}
void drawSheilds() {
	fill(0);
	stroke(152, 196, 155);
	for (int i = 0; i < shields.size(); i++) {
		rect(shields.get(i).pos.x, shields.get(i).pos.y, shields.get(i).sizeW, shields.get(i).sizeH);

	}
}

void clearBackground()
{ 	//wowbagger
	//Fill screen with rect, with alpha for cool effect.
	fill(0, 0, 0, 80);
	strokeWeight(1);
	rect(-100, -110, width + 100, height + 300); 
}


void spawnNewEnemys()
{
	enemyManager = new EnemyManager();
	enemyManager.spawnEnemys();
}

void gameClearCheck()
{
	if(enemyManager.enemys.size() < 1)
	{
		spawnNewEnemys();
		enemyManager.maxSpeed += 1f;
	}
}

void spawnRedShip()
{
	if (timeToSpawnRedShip < millis()) {
		int b = int(random(1,4));
		redship = new RedShip(b);
		float r = random(24, 34);
		r *= 1000;
		timeToSpawnRedShip = millis() + r;
	}
}

void restart()
{
	if (!alive) {
		if (keyPressed) {
			score = 0;
			spawnNewEnemys();
			alive = true;	
			bullets.clear();
			player = new Player();
			if (bullets.size() == 0) {
				enemyManager.shoot();
			}
		}
	}
	
}
