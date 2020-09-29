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
		fill(165,165,165);
		stroke(165,165,165);
		rect(position.x, position.y, sizeW, sizeH, 10);
		
		
	}
	boolean collision() {

		if(bullets.size() >= 1) {
			for (int i = 0; i < bullets.size(); ++i) {

				if ((position.x >= bullets.get(i).pos.x - 5 && position.x <= bullets.get(i).pos.x + bullets.get(i).sizeW + 5) || (position.x + sizeW >= bullets.get(i).pos.x - 5 && position.x + sizeW <= bullets.get(i).pos.x + bullets.get(i).sizeW + 5)) {
					
					if (position.y > bullets.get(i).pos.y && position.y < bullets.get(i).pos.y + bullets.get(i).sizeH) {
						bullets.get(i).remove();
						return true;
					}
				}


				
			}
		}
		for (int i = 0; i < enemyManager.enemys.size(); ++i) {
			float enemyXPos = enemyManager.enemys.get(i).pos.x;
			float enemyYPos = enemyManager.enemys.get(i).pos.y;
		
			if (position.x + sizeW > enemyXPos && position.x < enemyXPos + enemyManager.enemys.get(i).eSize ) {
				if (position.y + sizeH > enemyYPos && position.y + sizeH < enemyYPos + enemyManager.enemys.get(i).eSize ) {
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