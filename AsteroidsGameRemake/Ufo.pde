class Ufo {
  PShape shape;
  PVector pos, vel;
  PVector target;

  float size;
  //float rotation;
  float moveSpeed = 100;

  float shootDelay = 3;
  float shootTime = 0;

  Ufo(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    size = 30;

    target = new PVector(random(width), random(height));

    shape = createShape();
    shape.beginShape();
    shape.vertex(-size/2, -size/2);
    shape.vertex(-size/2, size/2);
    shape.vertex(size/2, 0);
    shape.endShape();
  }
  void show() {
    //////////////////////////////////////////ERROR////////////////////////////////
    //fill
    //stroke ect.
    //push();
    //translate(pos.x, pos.y);
    //rotate(rotation);
    //noFill();
    //stroke(255);
    //strokeWeight(2);
    //shape(shape);
    ////ellipse(0, 0, size, size);
    //pop();
    fill(255);
    stroke(255);
    strokeWeight(2);
    ellipse(pos.x, pos.y, size, size);
  }
  void update() {
    move();
    updateShooting();
    //rotateToPlayer();
  }
  void updateShooting() {
    shootTime += deltaTime;
    if (shootTime >= shootDelay) {
      shootTime = 0;
      shoot();
    }
  }
  void shoot() {
    UfoBullet ub = new UfoBullet(pos, PVector.sub(player.pos, pos).normalize());
    bullets.add(ub);
  }
  void destroy() {
    ufos.remove(this);
  }
  //void rotateToPlayer() {
  //  rotation = PVector.angleBetween(player.pos, pos);
  //  rotation -= 45;
  //}
  void move() {

    if (PVector.dist(pos, target) <= size) {
      target.set(random(width), random(height));
    }

    vel.set(PVector.sub(target, pos).normalize().mult(moveSpeed));
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
}
