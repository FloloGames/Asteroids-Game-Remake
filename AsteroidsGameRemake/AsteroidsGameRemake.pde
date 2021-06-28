ArrayList<Asteroid> asteroids;
ArrayList<Bullet> bullets;
ArrayList<Ufo> ufos;
Player player;

boolean animation = false;

float deltaTime = 0;

float asteroidSpawnDelay = 2;//Every 3 seconds another asteroid get spawned
float asteroidSpawnTime = 0;

float ufoSpawnDelay = 15;//Every 3 seconds another asteroid get spawned
float ufoSpawnTime = 0;

float animationTime = 0;
float animationDelay = 3;//Seconds 

int[] asteroidSizes = new int[]{25, 50};

int playerScore = 0;
int playerLives = 3;

void setup() {
  noCursor();
  frameRate(60);
  //fullScreen();
  size(1080, 720);

  asteroids = new ArrayList<Asteroid>();
  bullets = new ArrayList<Bullet>();
  ufos = new ArrayList<Ufo>();

  player = new Player(width/2, height/2, 20, radians(90));
}
void draw() {
  //println(frameRate);
  deltaTime = 1 / frameRate;
  background(0);
  player.show();
  player.update();
  updateUfos();
  updateBullets();
  updateAsteroids();
  updateAsteroidSpawner();
  updateUfoSpawner();
  upadteAnimation();
  drawUI();
}
void mousePressed() {
  ufos.add(new Ufo(mouseX, mouseY));
}
void restart() {
  playerLives = 3;
  playerScore = 0;
  animation = true;

  asteroids.clear();
  ufos.clear();
  bullets.clear();
}
void updateUfoSpawner() {
  ufoSpawnTime += deltaTime;
  if (ufoSpawnTime < ufoSpawnDelay) return;
  ufoSpawnTime = 0;

  /*
  is the same as:
   if(random(1) > 0.5){
   x = 0;
   } else {
   x = width;
   }
   but in short ;)
   */
  float x = (random(1) > 0.5) ? 0 : width;
  float y = (random(1) > 0.5) ? 0 : height;
  ufos.add(new Ufo(x, y));
}
void drawUI() {
  fill(255);
  textSize(40);
  textAlign(LEFT, TOP);
  text("Lives: " + str(playerLives), 0, 0, width, height);
  textAlign(RIGHT, TOP);
  text("Score: " + str(playerScore), 0, 0, width, height);
}
void upadteAnimation() {
  if (!animation) return;
  animationTime += deltaTime;
  if (animationTime >= animationDelay) {
    animationTime = 0;
    animation = false;
    player.pos.set(width/2, height/2);
  }
}
void damagePlayer() {
  if (animation) return;

  playerLives--;
  animation = true;

  if (playerLives <= 0) {
    restart();
  }
}
void updateAsteroidSpawner() {
  asteroidSpawnTime += deltaTime;
  if (asteroidSpawnTime < asteroidSpawnDelay) return;
  asteroidSpawnTime = 0;

  /*
  is the same as:
   if(random(1) > 0.5){
   x = 0;
   } else {
   x = width;
   }
   but in short ;)
   */
  float x = (random(1) > 0.5) ? 0 : width;
  float y = (random(1) > 0.5) ? 0 : height;
  asteroids.add(new Asteroid(x, y, 1));
}
void updateUfos() {
  for (int i = 0; i < ufos.size(); i++) {
    Ufo u = ufos.get(i);
    u.show();
    u.update();
  }
}
void updateAsteroids() {
  for (int i = 0; i < asteroids.size(); i++) {
    Asteroid a = asteroids.get(i);
    a.show();
    a.update();
  }
}
void updateBullets() {
  for (int i = 0; i < bullets.size(); i++) {
    Bullet b = bullets.get(i);
    b.show();
    b.update();
  }
}
