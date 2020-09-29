public class Player {
	PVector position = new PVector(100, height - 100);
	PVector velocity = new PVector(0, 0);
	PVector acceleration = new PVector();
	PlayerProjectile playerProjectile;
	int lives = 3;
	float speed = 100;
	float maxSpeed = 12;
	float sizeW = 50;
	float sizeH = 25;

	color playerColor = color(60, 30,150);

	public Player () {
		
	}
	void update(){
	position.add(movementInput().mult( speed * deltaTime));
	playerCollision();
	projectile();
	
	}

	void draw() {
		fill(playerColor);
		stroke(color(80,30,200));
		rect(position.x, position.y, sizeW, sizeH , 10);
		rect(position.x +20, position.y - 15, 10, 15, 10, 10, 0,0);
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
		if(lives <= 0)
		{
			alive = false;
		}
	} 

	void projectile() {
		if (fire && playerProjectile == null) {
		playerProjectile = new PlayerProjectile(position.x + sizeH, position.y);
	}
		if (playerProjectile != null) {
		playerProjectile.update();
		playerProjectile.draw();
		if(playerProjectile.collision()) {
			playerProjectile = null;
		}
	}
	}

}