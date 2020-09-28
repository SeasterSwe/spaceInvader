public class Player {
	PVector position = new PVector(100, height - 100);
	PVector velocity = new PVector(0, 0);
	PVector acceleration = new PVector();
	PlayerProjectile playerProjectile;
	int health = 3;
	float speed = 100;
	float maxSpeed = 12;
		
	public Player () {
		
	}
	void update(){
		//acceleration.set(movementInput());

		
	

	//println(acceleration);
	position.add(movementInput().mult( speed * deltaTime));
	playerCollision();
	projectile();
	
	}

	void draw() {
		fill(255, 0, 0);
		rect(position.x, position.y, 50, 25 , 10);
		rect(position.x +20, position.y - 15, 10, 15, 10, 10, 0,0);
	}
	void playerCollision() {
		if (position.x < 0) {
			position.x = 0;
		}
		if (position.x > width - 50) {
			position.x = width - 50; 
		}
	} 

	void projectile() {
		if (fire && playerProjectile == null) {
		playerProjectile = new PlayerProjectile(position.x + 25, position.y);
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