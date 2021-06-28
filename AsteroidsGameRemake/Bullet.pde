class Bullet {
  PVector pos, vel;
  float size;
  float speed;
  float lifeTime = 1.5;//seconds
  Bullet(PVector p, PVector v, float s, float sp) {
    pos = p.copy();
    vel = v.copy();
    size = s;
    speed = sp;

    vel.mult(speed);
  }
  void show() {
    noFill();
    stroke(255);
    ellipse(pos.x, pos.y, size, size);
  }
  void update() {
    testIfCollide();
    move();
    lifeTime -= deltaTime;
    if (lifeTime <= 0) {
      destroy();
    }
  }
  void move() {
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
  void destroy() {
    bullets.remove(this);
  }
  void testIfCollide() {
    for (int i = 0; i < asteroids.size(); i++) {
      Asteroid a = asteroids.get(i);
      float dist = PVector.dist(a.pos, pos);
      if (dist <= size/2 + asteroidSizes[a.sizeIndex]/2) {
        playerScore += floor(random(100));
        a.breakDown();
        destroy();
      }
    }
  }
}
