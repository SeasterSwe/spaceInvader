public class Player {
	int lives = 3;
	float speed = 100;
	float maxSpeed = 12;
	float sizeW = 50;
	float sizeH = 25;
	PVector position = new PVector(width / 2 -sizeW / 2, height - 100);
	PVector velocity = new PVector(0, 0);
	PVector acceleration = new PVector();
	PlayerProjectile playerProjectile;
	

	color playerColor = color(60, 30,150);

	public Player () {
		
	}
	void update(){
	position.add(movementInput().mult( speed * deltaTime));
	playerCollision();
	projectile();
	draw();
	}

	void draw() { 
		playerShape(position.x, position.y);
		
	}
	void playerCollision() {
		if (position.x < 0) {
			position.x = 0;
		}
		if (position.x > width - sizeW) {
			position.x = width - sizeW; 
		}
		
	}
	void killed() {
		lives--;
		dmgTakenSound.play();
		if(lives <= 0)
		{
			alive = false;
		}
	} 

	

	void playerShape(float x, float y)
	{
		fill(playerColor);
		stroke(color(80,30,200));
		rect(x, y, sizeW, sizeH , 10);
		rect(x + sizeW/2 - 5, y - 15, 10, 15, 10, 10, 0,0);
		rect(x + sizeW/2 - 8, y - 15, 16, 6, 10);
		fill(60);
		stroke(70);
	}

	void projectile() {
		if (fire && playerProjectile == null) {
		playerProjectile = new PlayerProjectile(position.x + 2.5 + sizeW/2 - playerProjectileSizeW/2, position.y - playerProjectileSizeH);
		effekts.add(new MuzzleFlash(position.x + sizeW/2, position.y - sizeH/2 - 5, 0.15f, color(255), 25));
		shootSound.play();
	}
		if (playerProjectile != null) {
		playerProjectile.update();
		playerProjectile.draw();
		if(playerProjectile.collision()) {
			effekts.add(new Explotion(playerProjectile.position.x,playerProjectile.position.y));
			playerProjectile = null;
		}
	}
	}

}