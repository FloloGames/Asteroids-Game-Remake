class PlayerBullet extends Bullet {
  PlayerBullet (PVector p, PVector v) {
    //Position, velocity, size, speed
    super(p, v, 10, 500);
  }
  @Override
    void testIfCollide() {
    super.testIfCollide();
    for (int i = 0; i < ufos.size(); i++) {
      Ufo u = ufos.get(i);
      float dist = PVector.dist(u.pos, pos);
      if (dist <= size/2 + u.size/2) {
        playerScore += floor(random(100));

        u.destroy();
        destroy();
      }
    }
  }
}
