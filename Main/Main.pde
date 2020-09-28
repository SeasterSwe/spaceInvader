float deltaTime;
float time;
Player player;

EnemyManager enemyManager = new EnemyManager();
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
	player.update();
	player.draw();
	time = currentTime;

	enemyManager.draw();
}

void clearBackground()
{
	//Fill screen with rect, with alpha for cool effect.
	fill(0, 0, 0, 50);
	rect(-10, 10, width, height);
}
