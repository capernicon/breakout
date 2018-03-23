class Ball {
  float ballDiameter, speedX, speedY, ballX, ballY;
  boolean ballStart = true;
  
Ball() {
  ballDiameter = 20;
  ballX = 500;
  ballY = 720;
  speedX = random(4, 9);
  speedY = random(-8, -12);
}
  
void display() {
  fill(255);
  noStroke();
  ellipse(ballX, ballY, ballDiameter, ballDiameter);
}
//Condition check for ball to bounce of the invisbile border around the screen. Left, Top and Right.
void bordersBounce() {
  if (ballX + ballDiameter/2 > width || ballX - ballDiameter/2 < 0) {
    speedX = -speedX;
  }
  if (ballY - ballDiameter/2 < 0) {
    speedY = -speedY;
  }
}
}