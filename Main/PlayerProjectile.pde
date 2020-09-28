public class PlayerProjectile  {
	PVector position;
	float speed = 200;
	public PlayerProjectile (float x, float y) {
		position = new PVector(x - 2, y-10);
	}
	void update(){
		position.y -= speed * deltaTime;
		
	}
	void draw(){
		rect(position.x, position.y, 4, 10, 10);
		
		
	}
	boolean collision() {
		if (position.y < 0) {
			return true;
		}
		return false;
	}
}