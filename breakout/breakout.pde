//Created by Matthew Ablott

Paddle paddle;
Ball ball;
ArrayList <Brick> bricks;
boolean ballStart;
boolean playGame;
int score = 0;
int lives = 3;
int level = 1;
int gameState = 0;
final int LEVEL_1 = 0;
final int LEVEL_2 = 1;
final int LEVEL_3 = 2;
PImage cityBackground;

/*
* Color of bricks per each level
*/
color brickColorsLevel1[]= {color(214, 214, 214, 220), color(214, 214, 214, 220), color(214, 214, 214, 220),
color(214, 214, 214, 220), color(214, 214, 214, 220) , color(214, 214, 214, 220)};

color brickColorsLevel2[]= {color(79, 79, 79, 220), color(79, 79, 79, 220), color(79, 79, 79, 220),
color(79, 79, 79, 220), color(79, 79, 79, 220), color(79, 79, 79, 220),
color(79, 79, 79, 220), color(79, 79, 79, 220)};

color brickColorsLevel3[]= {color(33, 33, 33, 220), color(33, 33, 33, 220), color(33, 33, 33, 220),
color(33, 33, 33, 220), color(33, 33, 33, 220), color(33, 33, 33, 220), color(33, 33, 33, 220),
color(33, 33, 33, 220), color(33, 33, 33, 220), color(33, 33, 33, 220)};

void setup() {
  size(1000, 800);
  smooth();
  noStroke();
  cityBackground = loadImage("city.jpg");
  noCursor();
  ballStart = false;
  ball = new Ball();
  paddle = new Paddle();
  bricks = new ArrayList<Brick>();

  if (gameState == 0) {
    for (int brickRowAcross = 0; brickRowAcross < 10; brickRowAcross++) {
      for (int brickColumnDown = 0; brickColumnDown < 6; brickColumnDown++) {
        color brickColor = brickColorsLevel1[brickColumnDown];
        Brick level1Brick = new Brick(brickColor);
        level1Brick.setLocation((brickRowAcross*100), brickColumnDown*41);
        bricks.add(level1Brick);
      }
    }
  }
  
  if (gameState == 1) {
    for (int brickRowAcrossLev2 = 0; brickRowAcrossLev2 < 10; brickRowAcrossLev2++) {
      for (int brickColumnDownLev2 = 0; brickColumnDownLev2 < 8; brickColumnDownLev2++) {
        color brickColor = brickColorsLevel2[brickColumnDownLev2];
        Brick level2Brick = new Brick(brickColor);
        level2Brick.setLocation((brickRowAcrossLev2*100), brickColumnDownLev2*41);
        bricks.add(level2Brick);
      }
    }
  }
  
  if (gameState == 2) {
    for (int brickRowAcrossLev3 = 0; brickRowAcrossLev3 < 10; brickRowAcrossLev3++) {
      for (int brickColumnDownLev3 = 0; brickColumnDownLev3 < 10; brickColumnDownLev3++) {
        color brickColor = brickColorsLevel3[brickColumnDownLev3];
        Brick level3Brick = new Brick(brickColor);
        level3Brick.setLocation((brickRowAcrossLev3*100), brickColumnDownLev3*41);
        bricks.add(level3Brick);
      }
    }
  }
}

void draw() {   
  cityBackground.resize(1000,800);
  background(cityBackground);
  frameRate(60);   
  ball.display();
  ball.bordersBounce(); 
  paddle.displayEasy();
  statsBox();
  
  for (int buildBricks = bricks.size()-1; buildBricks >= 0; buildBricks--) {
    Brick brickWall = (Brick) bricks.get(buildBricks);
    brickWall.display();
    
    if (brickWall.intersectBrickAndBall(ball)) { //Checking for a collision between ball and bricks. If so, reverse the balls y-position
      ball.speedY *= -1;
      bricks.remove(brickWall);
      score += 10;
    }
  }
  
    if (keyCode == ENTER) { //Game starts paused until user presses ENTER to commence game
      ballStart = true;
    }
  
    if (key == 'p' || key == 'P') {
      ballStart = false; 
      gamePause();
    }  
   //Check to see if ball has exceeded height of the window. If so, the game is reset (score/bricks and a life is deducted) on current level.
    if (ball.ballY - ball.ballDiameter/2 > height) { 
      ballStart = false;
      ball.ballY = 720;
      ball.ballX = 500;
      restartIfDie();
    }

    if (ballStart) {
      ball.ballY -= ball.speedY;
      ball.ballX -= ball.speedX;
    }
  //Checks if ball has intersected with the paddle. If so, the y-position of the ball is reversed
    if (paddle.intersectPaddleAndBall(ball)) {
      ball.speedY *= -1;
    }
  
    if (keyPressed) {
      if (ballStart) {
        if (keyCode == RIGHT) {
          paddle.moveRight();
        }
        if (keyCode == LEFT) {
          paddle.moveLeft();
        }
      }
    }  
   //Switch cases between each of the 3 levels. Checks are done if lives < 0 (then game is over) and if all bricks have been destroyed (then game enters next level)
    switch (gameState) {
      case LEVEL_1:
        
        if (lives < 0) {
          gameOver();
        }     
    
        if (bricks.isEmpty()) {
          ballStart = false;
          gameState = 1;
          setup();
        }  
        break;
       
      case LEVEL_2:
        level = 2;
      
        if (lives < 0) {
          gameOver();
        }    
        
        if (bricks.isEmpty()) {
          ballStart = false;
          gameState = 2;
          setup();
        }  
        break;  
    
      case LEVEL_3:
        level = 3;
      
        if (lives < 0) {
          gameOver();
        }  
    
        if (bricks.isEmpty()) {
          ballStart = false;
          winner();
        } 
        break;
    }
}
 //Stats of game displayed in green text (black box) at bottom of screen. Lives, Level & Score.
void statsBox() {
  fill(0);
  rect(0, 790, 1000, 50);
  fill(0, 196, 26);
  textSize(16);
  text("SCORE = "+score, 20, 791); 
  text("LEVEL = "+level+" of 3", 200, 791);
  text("LIVES = "+lives, 428, 791);  
}
 
void gamePause() {
  textSize(30);
  fill(255);
  text("Game paused. Press ENTER to continue", 225, height/2);
}
  
void restartIfDie() {
  score = 0;
  lives -= 1;
  setup();
}
 
void gameOver() {
  background(0);
  fill(255);
  textSize(45);
  text("Game Over!", 380, height/2);
  textSize(20);
  text("Press Q to quit", 435, height/2 +50);
    
  if (key == 'q' || key == 'Q') {
    exit();
  }
}
  
void winner() {
  background(0);
  fill(255);
  textSize(45);
  text("Congratulations, bozo!", 250, height/2);
}