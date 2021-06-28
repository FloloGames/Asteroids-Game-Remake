public class Player {
  PShape shipShape;
  PShape boostShape;

  PVector pos, vel;

  boolean left = false;
  boolean right = false;
  boolean forward = false;
  boolean shooting = false;

  float size;
  float rotation;
  float rotationSpeed = radians(200);
  float moveSpeed = 10;

  float shootRate = 3;
  float shootTime = 0;

  Player(float x, float y, float s, float r) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    size = s;
    rotation = r;

    createShipShape();
    createBoostShape();


    registerMethod("keyEvent", this);
  }
  void createBoostShape() {
    boostShape = createShape();
    boostShape.beginShape();

    boostShape.noFill();
    boostShape.stroke(255);
    boostShape.strokeWeight(2);

    boostShape.vertex(-size, -size/3);

    boostShape.vertex(-size*1.5, 0);

    boostShape.vertex(-size, size/3);

    boostShape.endShape();
  }
  void createShipShape() {
    shipShape = createShape();
    shipShape.beginShape();

    shipShape.noFill();
    shipShape.stroke(255);
    shipShape.strokeWeight(2);

    shipShape.vertex(-size, -size/2);//Up Point
    shipShape.vertex(size, 0);//Right Point
    shipShape.vertex(-size, size/2);//Down Point
    shipShape.vertex(-size, -size/2);//Up Point

    shipShape.endShape();
  }
  void show() {
    if (animation) return;

    push();
    translate(pos.x, pos.y);
    rotate(rotation);
    noFill();
    stroke(255);
    strokeWeight(2);
    shape(shipShape);

    if (forward) {
      if (frameCount%4 == 0) {
        shape(boostShape);
      }
    }

    pop();
  }
  void update() {
    if (animation) return;

    updateRotate();
    updateForward();
    updateShooting();
  }
  void updateShooting() {
    shootTime += deltaTime;
    if (shootTime >= 1 / shootRate && shooting) {
      shootTime = 0;
      shoot();
    }
  }
  void shoot() {
    PlayerBullet pb = new PlayerBullet(pos, PVector.fromAngle(rotation));
    bullets.add(pb);
  }
  void updateForward() {
    vel.mult(0.99);

    if (forward) {
      PVector currRotation = PVector.fromAngle(rotation);
      currRotation.mult(moveSpeed);
      vel.add(currRotation);
    }

    pos.add(vel.copy().mult(deltaTime));

    if (pos.x > width) {
      pos.x = 0;
    }
    if (pos.x < 0) {
      pos.x = width;
    }
    if (pos.y > height) {
      pos.y = 0;
    }
    if (pos.y < 0) {
      pos.y = height;
    }
  }
  void updateRotate() {
    if (left) {
      rotation -= rotationSpeed * deltaTime;
    } 
    if (right) {
      rotation += rotationSpeed * deltaTime;
    }
  }
  void keyPressed() {
    if (keyCode == LEFT || key == 'a' || key == 'A') {
      left = true;
    } 
    if (keyCode == RIGHT || key == 'd' || key == 'D') {
      right = true;
    }
    if (keyCode == UP || key == 'w' || key == 'W') {
      forward = true;
    }
    if (key == ' ') {
      shooting = true;
    }
  }
  void keyReleased() {
    if (keyCode == LEFT || key == 'a' || key == 'A') {
      left = false;
    } 
    if (keyCode == RIGHT || key == 'd' || key == 'D') {
      right = false;
    }
    if (keyCode == UP || key == 'w' || key == 'W') {
      forward = false;
    }
    if (key == ' ') {
      shooting = false;
    }
  }
  public void keyEvent(KeyEvent evt) {
    switch(evt.getAction()) {
    case KeyEvent.PRESS:
      keyPressed();
      break;
    case KeyEvent.RELEASE:
      keyReleased();
      break;
    }
  }
}
