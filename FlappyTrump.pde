void setup() {
  size(700, 700);
  colorMode(RGB);

  space = 50;
  spaces = space;
  hole = 250;
  grav = new PVector(0, 0.5);
  head = new Trump(350, 350); 
  timer = 0;
  blockSpeed = -3;
  score = 0;
  gameState = 0;
  rectX = 150;
  rectY = 125;
  colorshade = 0;
  highscore = 0;

  //Loading images for head
  trumpHead = loadImage("Trump_Head.png");
  trumpHeadHappy = loadImage("Trump_Head_Happy.png");


  //Loading initial blocks
  for (int i = 0; i < 5; i++) {
    blocks.add(new PVector(1525 - spaces, 0, random(50, 325)));
    spaces += 225;
  }


  //Loading font
  PFont numberFont = createFont("Cartoon_Font.ttf", 26);
  textFont(numberFont, 30);
  text("", 350, 350);
}


//Variables
int space;
int spaces;
ArrayList<PVector> blocks = new ArrayList<PVector>();
int hole;
PVector grav;
Trump head;
int timer;
int blockSpeed ;
int score;
PImage trumpHead;
PImage trumpHeadHappy;
int gameState;
int rectX; 
int rectY;
int colorshade; 
int highscore;

void draw() {

  println(mouseX, mouseY);

  if (gameState == 0) {
    mainMenu();
  } else if (gameState == 1 || gameState == -1) {

    //Background sky color
    background(50, 180, 250); 

    //Live score
    fill(255);
    text(score, 350, 100);

    //Creates moving blocks
    for (int i = 0; i < 5; i++) {
      fill(100, 255, 0);
      rect(blocks.get(i).x, blocks.get(i).y, space, blocks.get(i).z); 
      rect(blocks.get(i).x, blocks.get(i).z + hole, space, 800);
      blocks.get(i).x += blockSpeed;

      if (blocks.get(i).x <= -space) {
        blocks.remove(i);
        blocks.add(new PVector(1050, 0, random(50, 325)));
      }
    }

    //Physics for head
    head.show();
    head.applyGrav();
    head.detectCollision();

    //Delay at beginning of game
    if (timer < 3) {
      startScreen();
      delay(1000);
      timer ++;
    } else if (timer <= 5) {
      goScreen();
      delay(200);
      timer++;
    }
  }
}  

//Screen right before gameplay
void startScreen() {
  background(0);
  textSize(30);
  fill(255);
  stroke(0);
  text("Ready...", 300, 350);
}

void goScreen() {
  background(0);
  textSize(30);
  fill(255);
  stroke(0);
  text("Go!", 320, 350);
  delay(100);
}
//Called when player hits an obstacle
void gameOver() {
  for (int i = 0; i < 5; i++) {
    blockSpeed = 0;
    grav.y = 0;
  }
  playAgainMenu();
}


//Resets game state to Ready screen
void restart() {
  space = 50;
  spaces = space;
  hole = 250;
  grav = new PVector(0, 0.5);
  head = new Trump(350, 350); 
  timer = 0;
  blockSpeed = -3;
  score = 0;
  gameState = 1;

  blocks.clear();

  for (int i = 0; i < 5; i++) {
    blocks.add(new PVector(1525 - spaces, 0, random(50, 325)));
    spaces += 225;
  }
}

void mainMenu() {

  float anglestop = PI/12;
  float anglestart = 0;
  float angle = PI/12;

  for (int i = 0; i < 24; i++) {
    stroke(0);
    fill(random(50), random(50), random(50));
    arc(350, 350, 1000, 1000, anglestart, anglestop);
    anglestart += angle;
    anglestop += angle;
  }
  //highscore
  fill(255);
  textSize(30);
  text("Highscore: ", 10, 50);
  text(highscore, 250, 50);

  fill(#b04023);
  stroke(0);
  rect(200, 550, 300, 100, 50);
  fill(255);
  textSize(30);
  text("START", 290, 610);

  stroke(0);
  textSize(60);
  text("FLAPPY", 220, 200);
  text("TRUMP", 220, 400);

  if (mouseX > 200 && mouseX < 500 && mouseY > 550 && mouseY < 650) {
    fill(#ad0725);
    stroke(255);
    rect(200, 550, 300, 100, 50);

    fill(255);
    textSize(30);
    text("START", 290, 610);
  }

  if (mousePressed) {
    if (mouseX > 200 && mouseX < 500 && mouseY > 550 && mouseY < 650) {
      restart();
    }
  }
}

//Game Over menu
void playAgainMenu() {

  //Background rectangle in menu
  fill(#001900);
  rect(rectX, rectY, 400, 320, 25);

  //Play Again Button
  fill(#C6683B);
  rect(200, 165, 300, 100, 15);

  fill(255);
  textSize(30);
  text("Play Again?", 230, 225);

  //Main Menu Button
  fill(#C6683B);
  rect(200, 300, 300, 100, 15);

  fill(255);
  textSize(30);
  text("Main Menu", 240, 365);

  //Button mouse-over animation for play again button
  if (mouseX > 200 && mouseX < 500 && mouseY > 165 && mouseY < 265) {
    fill(#D7310C);
    stroke(255);
    rect(200, 165, 300, 100, 15);
    noStroke();

    fill(255);
    textSize(30);
    text("Play Again?", 230, 225);
  }


  //Actual button-press mechanic for play again button
  if (mousePressed) {
    if (mouseX > 200 && mouseX < 500 && mouseY > 165 && mouseY < 265) {
      println("reset");
      restart();
    }
  }

  //Button mouse-over animation for main menu button
  if (mouseX > 200 && mouseX < 500 && mouseY > 300 && mouseY < 400) {
    fill(#D7310C);
    stroke(255);
    rect(200, 300, 300, 100, 15);
    noStroke();

    fill(255);
    textSize(30);
    text("Main Menu", 240, 365);
  }


  //Actual button-press mechanic for main menu button
  if (mousePressed) {
    if (mouseX > 200 && mouseX < 500 && mouseY > 300 && mouseY < 400) {
      println("restart");
      gameState = 0;
    }
  }
}

//Detecting key presses
void keyPressed() {
  if (key == 'a') {
    head.jump();
  }
}