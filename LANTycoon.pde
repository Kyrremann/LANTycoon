Game game;
int tycoonState;

void setup() {
  size(800, 500);
  background(0);
  game = new Game();
  tycoonState = 2;
}

void draw() {
  background(0);
  switch(tycoonState) {
  case 0: // intro
    fill(random(255), random(255), random(255));
    textAlign(CENTER);
    textSize(56);
    text("LAN Tycoon", 250, 250);
    fill(random(255), random(255), random(255));
    textSize(21);
    text("Press the any-key", 250, 280);
    break;
  case 1: // howto
    fill(255);
    textAlign(CENTER);
    textSize(21);
    text("How\nto play\nthe game", 250, 250);
    textAlign(RIGHT);
    textSize(21);
    text("Press the any-key again", 495, 495);
    break;
  case 2: // game
    game.draw();
    break;
  case 3: // score
    break;
  }
}

void mousePressed() {
  switch(tycoonState) {
  case 0: // intro
    break;
  case 1: // howto
    break;
  case 2: // game
    game.mousePressed();
    break;
  case 3: // score
    break;
  }
}

void mouseReleased() {
  switch(tycoonState) {
  case 0: // intro
    break;
  case 1: // howto
    break;
  case 2: // game
    game.mouseReleased();
    break;
  case 3: // score
    break;
  }
}

void mouseClicked() {
  switch(tycoonState) {
  case 0: // intro
    tycoonState = 1;
    break;
  case 1: // howto
    tycoonState = 2;
    break;
  case 2: // game
    game.mouseClicked();
    break;
  case 3: // score
    break;
  }
}

void keyPressed() {
  switch(tycoonState) {
  case 0: // intro
    tycoonState = 1;
    break;
  case 1: // howto
    tycoonState = 2;
    break;
  case 2: // game
    break;
  case 3: // score
    break;
  }
}

