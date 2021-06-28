class Asteroid {
  PVector pos, vel;
  float speed;
  int sizeIndex;
  Asteroid(float x, float y, int s) {
    pos = new PVector(x, y);
    vel = PVector.random2D();
    speed = 50;
    sizeIndex = s;

    vel.mult(speed);
  }
  void breakDown() {
    sizeIndex--;
    if (sizeIndex >= 0) {
      float size = asteroidSizes[sizeIndex];
      asteroids.add(new Asteroid(pos.x+random(-size/2, size/2), pos.y+random(-size/2, size/2), sizeIndex));
      asteroids.add(new Asteroid(pos.x+random(-size/2, size/2), pos.y+random(-size/2, size/2), sizeIndex));
    }
    asteroids.remove(this);
  }
  void show() {
    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(pos.x, pos.y, asteroidSizes[sizeIndex], asteroidSizes[sizeIndex]);
  }
  void update() {
    move();
    testIfCollide();
  }
  void testIfCollide() {
    float dist = PVector.dist(pos, player.pos);
    if (dist <= asteroidSizes[sizeIndex]/2 + player.size/2) {
      damagePlayer();
      breakDown();
    }
    for (int i = 0; i < ufos.size(); i++) {
      Ufo u = ufos.get(i);
      dist = PVector.dist(u.pos, pos);
      if (dist <= asteroidSizes[sizeIndex]/2 + u.size/2) {
        u.destroy();
        breakDown();
      }
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
}
