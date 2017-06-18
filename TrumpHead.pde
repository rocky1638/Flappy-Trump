class Trump {

  float x;
  float y;
  PVector vel;

  Trump(float xCoord, float yCoord) {
    vel = new PVector(0, 0);
    x = xCoord;
    y = yCoord;
  }

  void show() {
    ellipse(x, y, 50, 50);
    this.y += vel.y;
    if (vel.y >0) {
      image(trumpHead, x - 50, y - 50, trumpHead.width/3, trumpHead.height/3);
      //Different image pops up when jumping
    } else if (vel.y <= 0) {
      image(trumpHeadHappy, x - 45, y - 45, trumpHeadHappy.width/2, trumpHeadHappy.height/2);
    }
  }

  void jump() {
    vel.y = -10;
  }


  void applyGrav() {
    vel.y += grav.y;
  }

  void detectCollision() {
    for (int i = 0; i < 5; i++) {
      if (blocks.get(i).x <= 375 && blocks.get(i).x >=300) {

        if (y < blocks.get(i).z + 25 || y > blocks.get(i).z + hole - 25) {
          //noFill();
          //rect(100, 100, 500, 500);
          gameState = -1;
          gameOver();
        } else if (blocks.get(i).x < 304 && blocks.get(i).x > 300) {
          score ++;
          if(score > highscore){
            highscore = score;
          }
        }
        return;
      }
    }
  }
}