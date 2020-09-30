public class Ui {

	void draw() {
		floorLine();
		typeScore();
		DrawLives();
		gameOver();
	}

	void floorLine()
{
	stroke(255, 146, 0);
	line(0, player.position.y + player.sizeH, width, player.position.y + player.sizeH);
}

	void typeScore()
{
	textSize(15);
	fill(249, 236, 194);
	textAlign(LEFT);
	text("Score: " + score,10,20);
}

	void DrawLives()
	{
		for (int i = 0; i < player.lives; ++i) {
			player.playerShape(10 + 70 * i, height - player.sizeH);
		}
	}

	void gameOver()
{
	if(!alive)
	{
		fill(210);
		textSize(40);
		textAlign(CENTER, CENTER);
		text("Game over", width/2, height/2 -20);
		
	}
}
	
}