public class Player {
	PVector position = new PVector(100, 100);
	PVector velocity;
	int health = 3;
	float speed = 30;
	public Player () {
		
	}

	void draw() {
		fill(255, 0, 0);
		rect(position.x, position.y, 50, 25);
	}

}