

import processing.sound.*;
SoundFile backSound;
SoundFile explotionSound;
SoundFile dmgTakenSound;
SoundFile shootSound;
SoundFile powerUpSound;

EnemyManager enemyManager = new EnemyManager();
ArrayList<EnemyProjectile> bullets = new ArrayList<EnemyProjectile>();
ArrayList<Effekt> effekts = new ArrayList<Effekt>();
ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<PowerUp> powerUps = new ArrayList<PowerUp>();
ArrayList<Shield> shields = new ArrayList<Shield>();

RedShip redship;
float timeToSpawnRedShip;

static boolean alive = true;
static int score = 0;
boolean startGame = false;
float deltaTime;
float time;
Player player;
Ui ui = new Ui();

void setup() {
	frameRate(60);
	size(800, 500);

	player = new Player();
	enemyManager.spawnEnemys();

	timeToSpawnRedShip = 7000;

	for(int i = 1; i <= 30; i++){
   		stars.add(new Star());
   	}

   	powerUps.add(new SpeedBoost(10));
   	powerUps.add(new ExtraLife());
	powerUps.add(new LargerBullets(20));
	createShields();
	getSounds();
}

void getSounds() {
	powerUpSound = new SoundFile(this, "PowerUp.wav");
	explotionSound = new SoundFile(this, "Explotion.wav");
	dmgTakenSound = new SoundFile(this, "Hurt.wav");
	shootSound = new SoundFile(this, "Shoot.wav");
	backSound = new SoundFile(this, "Backround.wav");

	powerUpSound.amp(0.005);
	shootSound.amp(0.01);
	dmgTakenSound.amp(0.05);
	explotionSound.amp(0.008);
	backSound.amp(0.005);
	
}

void draw() {
	clearBackground();
	long currentTime = millis();
	deltaTime = (currentTime - time) * 0.001f;

	if (!startGame) {
		startGame();	
	}
	else {
		
		player.update();

		draws();

		gameClearCheck();
		
		ui.draw();

		spawnRedShip();

		restart();
	}

	time = currentTime;
}

void draws() {
	drawStars();
	drawBullets();
	enemyManager.draw();
	drawPowerUps();
	drawEffekts();
	drawSheilds();

	if(redship != null)
		redship.draw();
}

void drawStars()
{
	for (int i = 0; i < stars.size(); ++i) {
		stars.get(i).draw();
	}
}

void drawPowerUps() {
	if(powerUps.size() > 0) {
		for (int i = 0; i < powerUps.size(); ++i) {
			powerUps.get(i).draw();	
		}
	}
}

void drawBullets() {
	if(bullets.size() > 0)
	for (int i = 0; i < bullets.size(); ++i) {
		bullets.get(i).draw();
	}
}

void drawEffekts() {
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
		
}

void drawSheilds() {
	fill(0);
	stroke(152, 196, 155);
	for (int i = 0; i < shields.size(); i++) {
		rect(shields.get(i).pos.x, shields.get(i).pos.y, shields.get(i).sizeW, shields.get(i).sizeH);
	}
}

//wowbagger
//Fill screen with rect, with alpha for cool effect.
void clearBackground() { 
	fill(0, 0, 0, 80);
	strokeWeight(1);
	rect(-100, -110, width + 100, height + 300); 
}


void spawnNewEnemys() {
	enemyManager = new EnemyManager();
	enemyManager.spawnEnemys();
}

void gameClearCheck() {
	if(enemyManager.enemys.size() < 1) {
		spawnNewEnemys();
		enemyManager.maxSpeed += 1f;
		shields.clear();
		createShields();
	}
}

void spawnRedShip() {
	if (timeToSpawnRedShip < millis()) {
		int b = int(random(1,4));
		redship = new RedShip(b);
		float r = random(24, 34);
		r *= 1000;
		timeToSpawnRedShip = millis() + r;
	}
}
void startGame() {
	ui.drawMenu();
	if (key == ' ') {
			backSound.loop();
			startGame = true;
		}
}

void restart() {
	if (!alive) {

		if (key == 'r') {
			backSound.stop();
			shields.clear();
			createShields();
			score = 0;
			spawnNewEnemys();
			alive = true;	
			bullets.clear();
			player = new Player();
			startGame = false;
			if (bullets.size() == 0) {
				enemyManager.shoot();
			}
		}
	}	
}
