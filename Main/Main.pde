float deltaTime;
float time;
Player player;

EnemyManager enemyManager = new EnemyManager();
ArrayList<EnemyProjectile> bullets = new ArrayList<EnemyProjectile>();
void setup() {
	frameRate(60);
	size(800, 500);
	player = new Player();
	enemyManager.spawnEnemys();
}

void draw() {
	clearBackground();
	long currentTime = millis();
	deltaTime = (currentTime - time) * 0.001f;
	//background(255,255,255);
	drawBullets();
	player.update();
	player.draw();
	time = currentTime;

	enemyManager.draw();
}

void drawBullets()
{
	if(bullets.size() > 0)
	for (int i = 0; i < bullets.size(); ++i) {
		bullets.get(i).draw();
	}
}

void clearBackground()
{
	//Fill screen with rect, with alpha for cool effect.
	fill(0, 0, 0, 80);
	//stroke(0);
	strokeWeight(1);
	rect(-100, -110, width + 100, height + 300); 
}
