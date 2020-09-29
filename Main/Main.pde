float deltaTime;
float time;
Player player;

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
	player.draw();

	enemyManager.draw();
	gameOver();
	typeScore();
	time = currentTime;
}

void typeScore()
{
	textSize(15);
	fill(249, 236, 194);
	textAlign(LEFT);
	text("Score: " + score,10,20);
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

void gameOver()
{
	if(!alive)
	{
		fill(210);
		textSize(40);
		textAlign(CENTER, CENTER);
		text("Game over", width/2, height/2 -20);
		if (keyPressed) {
			restart();	
		}
	}
}

void restart()
{
	score = 0;
	enemyManager = new EnemyManager();
	alive = true;	
	bullets.clear();
	enemyManager.spawnEnemys();
	player = new Player();
}
