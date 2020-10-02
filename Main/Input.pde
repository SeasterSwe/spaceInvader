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
	
	if (keyCode == LEFT || key == 'a') {
		moveLeft = true;
	}
	else if (keyCode == RIGHT || key == 'd') {
		moveRight = true;
	}
	if (key == ' ') {
		shoot = true;
	}
}

void keyReleased() {
	if (keyCode == LEFT || key == 'a') {
		moveLeft = false;
	}
	else if (keyCode == RIGHT || key == 'd') {
		moveRight = false;
	}
	if (key == ' ') {
		shoot = false;
	}
}