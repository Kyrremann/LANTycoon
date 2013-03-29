Game game;
int tycoonState;
String superLongHowToString = "Welcome to LANTycoon\nThis is a very simple "
+ "tycoon game made for The Gathering 2013 NGA Fast Game Development compo. The theme for this years compo was \"Time is money\".\n"
+ "The game is developet by Emil Lie Hatlelid and Kyrre Havik Eriksen from University of Oslo (visit our UIO:Campus TG stand!)\n"
+ "In the following section we will try to explain how the game is played.\n\n"
+ "- The goal is to earn as much money as possible untill the end of 2013! This is done by making succesefull LAN partys.\n"
+ "- Of course, if you run out of money you will lose, by the end of that year :(\n"
+ "- You earn money by participants visitng your party, and bonus/multipliers made from having stands. The bigger LAN, the better!\n"
+ "- The thing is, you have only a set amount of time before a LAN party starts. So you need to build quick, "
+ "or buy the long tables with more seats. Since they are quicker to build\n"
+ "- Each LAN hall also cost money to rent (except the first one). So you need to add this to your price calculation." +
"- Each table square have room for two particpants, so don't make it to close or else you miss seats." +
"- There are some exception to this last rule (It's not a bug, it's a feature!)." +
"- You can sell seats or stand by pressing 'd' while hovering over.";

void setup() {
  size(800, 500);
  background(0);
  game = new Game();
  tycoonState = 0;
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
    textAlign(LEFT);
    textSize(14);
    text(superLongHowToString, 10, 10, 790, 490);
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

void mouseDragged() {
  switch(tycoonState) {
  case 0: // intro
    break;
  case 1: // howto
    break;
  case 2: // game
    game.mouseDragged();
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

void keyReleased() {
  switch(tycoonState) {
  case 0: // intro
    break;
  case 1: // howto
    break;
  case 2: // game
  game.keyReleased();
    break;
  case 3: // score
    break;
  }
}

