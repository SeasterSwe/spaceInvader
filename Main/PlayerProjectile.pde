public class PlayerProjectile  {
	PVector position;
	float speed = 200;
	float sizeW = 4;
	float sizeH = 10;
	public PlayerProjectile (float x, float y) {
		position = new PVector(x - 2, y-10);
	}
	void update(){
		position.y -= speed * deltaTime;
		
	}
	void draw(){
		rect(position.x, position.y, sizeW, sizeH, 10);
		
		
	}
	boolean collision() {

	//	println(enemyManager);
		for (int i = 0; i < enemyManager.enemys.size(); ++i) {
			float enemyXPos = enemyManager.enemys.get(i).pos.x;
			float enemyYPos = enemyManager.enemys.get(i).pos.y;
		
			if (position.x + sizeW > enemyXPos && position.x < enemyXPos + enemyManager.enemys.get(i).eSize ) {
				if (position.y + sizeH > enemyYPos && position.y < enemyYPos + enemyManager.enemys.get(i).eSize ) {
						enemyManager.enemys.get(i).killed();
						return true;
				}	
			}
		}
	
		if (position.y < 0) {
			return true;
		}
	return false;
	}
}