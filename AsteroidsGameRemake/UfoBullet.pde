class UfoBullet extends Bullet {
  UfoBullet (PVector p, PVector v) {
    //Position, velocity, size, speed
    super(p, v, 10, 400);
  }
  @Override 
    void show() {
    fill(255);
    stroke(255);
    strokeWeight(2);
    ellipse(pos.x, pos.y, size, size);
  }
  @Override
    void testIfCollide() {
    super.testIfCollide();
    float dist = PVector.dist(pos, player.pos);
    if (dist <= size/2 + player.size/2) {
      damagePlayer();
      destroy();
    }
  }
}
