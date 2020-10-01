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

		if (shields.size() >= 1) {
			for (int i = 0; i < shields.size(); i++) {
				float shieldX = shields.get(i).pos.x;
				float shieldY = shields.get(i).pos.y;
				int shieldW = shields.get(i).sizeW;
				int shieldH = shields.get(i).sizeH;
			
			if ((position.x >  shieldX && position.x < shieldX + shieldW) ||  (position.x + sizeW >  shieldX && position.x + sizeW < shieldX + shieldW)) {

					if (position.y < shieldY + shieldH && position.y >shieldY) {
						shields.remove(i);
						return true;
					}
				}	
		}	
	}

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
			float radiusEnemy = enemyManager.enemys.get(i).eSize / 2;
			float enemyXPos = enemyManager.enemys.get(i).pos.x;
			float enemyYPos = enemyManager.enemys.get(i).pos.y;
		
			if ((position.x  > enemyXPos - radiusEnemy && position.x < enemyXPos + radiusEnemy) || (position.x + sizeW > enemyXPos - radiusEnemy && position.x + sizeW < enemyXPos + radiusEnemy)) {
				if ((position.y > enemyYPos - radiusEnemy && position.y  < enemyYPos + radiusEnemy) || (position.y + sizeH > enemyYPos - radiusEnemy && position.y + sizeH  < enemyYPos + radiusEnemy)) {
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