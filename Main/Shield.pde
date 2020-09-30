public class Shield {
	PVector pos = new PVector();
	int sizeW = 15;
	int sizeH = 10;
	
			Shield(float x, float y)
			{
				pos = new PVector(x, y);
				
			}
		
	}
	// void draw() {
			
	// 	for(int j = 1; j <= 4; j++) {
	// 		int x = width / 5 * j - 4 * sizeW;
	// 		int y = 140;


	// 		for(int i = 1; i <=21; i++) {
	// 			rect(x, height - y ,sizeW, sizeH);
	// 			if (i % 3 == 0 && i != 0) {

	// 				x += sizeW ; 
					
	// 				if (i < 12) {
	// 					y-= sizeH * 2;
	// 				}
	// 				else {
	// 				y-= sizeH * 4;
	// 				}
	// 			}
				
	// 			y += sizeH;
	// 		}
	// 	}
		

	//}

