

//Jakob
class Effekt {	
	
	void draw() {}

	void remove(float dur) {	
		if (millis() > dur) {
			effekts.remove(this);
		}
	}
}
class Explotion extends Effekt {
	color c;
	float rad;
	float maxRad;
	float radPerFrame;
	PVector pos;
	
	float timeSpawned;
	float timeOut;
	
	boolean done = true;

	Explotion(float x, float y) {
		explotionSound.play();
		done = false;
		pos = new PVector(x,y);
		c = color(255, 13, 0);
		rad = 0;
		maxRad = 25;

		timeSpawned = millis();
		timeOut = 0.5f * 1000;

		radPerFrame = (maxRad/30)/0.5f;
	}

	void draw() {

		if(rad <= maxRad && done == false) {
			rad += radPerFrame;
		}
		else {
			done = true;
			rad -= radPerFrame;
		}

		fill(c);
		stroke(c);
		ellipse(pos.x, pos.y, rad, rad);
		
		fill(color(255, 124, 0));
		stroke(color(255, 124, 0));
		ellipse(pos.x, pos.y, rad/1.5, rad/1.5);


		fill(color(255, 180, 0));
		stroke(color(255, 180, 0));
		ellipse(pos.x, pos.y, rad/3, rad/3);
		super.remove(timeSpawned + timeOut);
	}
}

class MuzzleFlash extends Effekt {
	
	color c;
	
	float timeOut;
	float timeSpawned;
	
	PVector pos;
	float muzzleSizeX;
	
	MuzzleFlash(float x, float y, float t, color c, float sizeX) {
		pos = new PVector(x,y);
		this.timeOut = t * 1000;
		this.c = c;
		this.timeSpawned = millis();
		muzzleSizeX = sizeX;
	}

	void draw() {
		fill(c);
		stroke(c);
		rect(pos.x - muzzleSizeX/2, pos.y, muzzleSizeX, 2, 20);
		super.remove(timeSpawned + timeOut);
	}
}

class Star extends Effekt {
  
  //kopierad rakt av, några tweaks samt lite omptimisering gjord å små förbättringar
  //https://www.openprocessing.org/sketch/65037/#
  int xPos, yPos, starSize;
  float flickerRate, light;
  boolean rise;
  
  Star() {
    flickerRate = random(2,5); 
    starSize = int(random(2,5));
    xPos = int(random(0,width - starSize));
    yPos = int(random(0,height/3 - starSize));
    light = random(10,256);
    rise = true;
  }

  void draw() {   
    
    if(light >= 245) {
      rise = false;
    }

    else if(light <= 10) {
      flickerRate = random(2,5);
      starSize = int(random(2,5));
      xPos = int(random(0,width - starSize));
      yPos = int(random(0,height/3 - starSize));
      rise = true;
    }

    if(rise) {
      light += flickerRate;
    }

    else if(!rise) {
      light -= flickerRate;
    }

    fill(light);
    noStroke();
    rect(xPos, yPos,starSize,starSize);

  }
}  

