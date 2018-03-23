class Paddle {
  float xPosition, yPosition, platformLength, platformHeight, platformCorners;
  color paddleColour = color(101, 101, 102);
 
Paddle() {
  xPosition = 500;
  yPosition = 745;
  platformLength = 120;
  platformHeight = 20;
  platformCorners = 20;
}
  
void displayEasy() {
  xPosition = constrain(xPosition, 0 + platformLength/2, width - platformLength/2 - 1);
  rectMode(CENTER);
  fill(paddleColour);
  rect(xPosition, yPosition, platformLength, platformHeight, platformCorners);
}

void moveRight() {
  xPosition += 8;
}

void moveLeft() {
  xPosition -= 8;
}

//Boolean check between x and y position of ball object against the paddles x and y position are done.
boolean intersectPaddleAndBall(Ball b) {
  if ((b.ballX > (xPosition - platformLength/2)) &&
  (b.ballX < (xPosition + platformLength/2)) &&
  (b.ballY < (yPosition)) &&
  (b.ballY > (yPosition - platformHeight))) {
    return true;
  }
  else {
    return false;
  }
}
}