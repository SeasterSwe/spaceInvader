float deltaTime;
float time;
Player player;
Ui ui = new Ui();
EnemyManager enemyManager = new EnemyManager();
ArrayList<EnemyProjectile> bullets = new ArrayList<EnemyProjectile>();

static boolean alive = true;
static int score = 0;
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

	drawBullets();
	player.update();
	enemyManager.draw();
	ui.draw();

	restart();
	time = currentTime;
}


void drawBullets()
{
	if(bullets.size() > 0)
	for (int i = 0; i < bullets.size(); ++i) {
		bullets.get(i).draw();
	}
}

void clearBackground()
{ 	//wowbagger
	//Fill screen with rect, with alpha for cool effect.
	fill(0, 0, 0, 80);
	//stroke(0);
	strokeWeight(1);
	rect(-100, -110, width + 100, height + 300); 
}


void spawnNewEnemys()
{
	enemyManager = new EnemyManager();
	enemyManager.spawnEnemys();
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
		}
	}
	
}
