boolean moveLeft;
boolean moveRight;
boolean shoot;

public PVector movementInput() {
	PVector acceleration = new PVector(0, 0);
	if (moveLeft) {
		acceleration.x -= 1;
	}
	if (moveRight) {
		acceleration.x += 1;
	}
	return acceleration;
}


void keyPressed() {
	if (alive) {
		if (keyCode == LEFT || key == 'a' || key == 'A') {
			moveLeft = true;
		}
		else if (keyCode == RIGHT || key == 'd' || key == 'D') {
			moveRight = true;
		}
		if (key == ' ') {
			shoot = true;
		}
	}
}

void keyReleased() {
	if (alive) {
		if (keyCode == LEFT || key == 'a' ||  key == 'A') {
			moveLeft = false;
		}
		else if (keyCode == RIGHT || key == 'd' ||  key == 'D') {
			moveRight = false;
		}
		if (key == ' ') {
			shoot = false;
		}
	}
}