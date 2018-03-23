class Brick {
  float xBrickPosition, yBrickPosition, brickLength, brickHeight;
  color brickColour;
  
Brick(color Colour) {
  brickLength = 99;
  brickHeight = 40;
  brickColour = Colour;
} 
  
void setLocation(float xBrickPosition, float yBrickPosition) {
  this.xBrickPosition = xBrickPosition;
  this.yBrickPosition = yBrickPosition;
}

void display() {
  fill(brickColour);
  rectMode(CORNER);
  stroke(0);
  rect(xBrickPosition, yBrickPosition, brickLength, brickHeight);
}

//Boolean check between x and y position of ball object against the brciks x and y position are done.
boolean intersectBrickAndBall(Ball a) {
  if (a.ballX + a.ballDiameter + a.speedX > xBrickPosition &&
  a.ballX + a.speedX < xBrickPosition + brickLength + 10 &&
  a.ballY + a.ballDiameter > yBrickPosition &    
  a.ballY < yBrickPosition + brickHeight + 10) {
    return true;
  }
  else {
    return false;
  }
  }
}