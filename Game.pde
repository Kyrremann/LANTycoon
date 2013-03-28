import java.util.List;

List<Cube> cubes;
Cube tempCube;
int gameState;
int lanHall;

class Game {

  public Game() {
    grid();
    noStroke();

    cubes = new ArrayList<Cube>();
    cubes.add(new Cube(210, 250, 'E')); //Entrance

    gameState = 0;
    lanHall = -1;
  }

  void draw() {
    switch (gameState) {
    case 0: // velg hall
      fill(255);
      textAlign(LEFT);
      textSize(21);
      text("Choose your LAN hall:", 30, 30);
      fill(128, 128, 128);
      rect(100, 100, 50, 50);
      fill(255, 0, 0);
      rect(200, 100, 50, 50);
      fill(0, 255, 0);
      rect(100, 200, 50, 50);
      fill(0, 0, 255);
      rect(200, 200, 50, 50);
      break;
    case 1: // build it
      grid();
      menu();

      for (Cube c : cubes) {
        c.draw();
      }

      if (tempCube != null) {
        tempCube.update();
        tempCube.draw();
      }
      break;
    case 2: // stats
      break;
    }
  }

  void menu() {
    fill(134, 120, 39);
    rect(400, 100, 40, 10);
  }

  void grid() { // For small map
    stroke(64);
    for (int x = 200; x < 300; x += 10) {
      line(x, 200, x, 250);
      for (int y = 200; y < 250; y += 10) {
        line(200, y, 300, y);
      }
    }
    line(300, 200, 300, 250);
    line(200, 250, 300, 250);
    stroke(255);
  }

  // Dette blir en stor menu handler, boer nok lages en egen klasse for denne en gang :\
  void mousePressed() {    
    switch (gameState) {
    case 0: // velg hall
      break;
    case 1: // build it
      if (mouseX < 440 || mouseX > 400 || mouseY > 100 || mouseY < 110 && tempCube == null)
        tempCube = new Cube(mouseX, mouseY, 'T');
      break;
    case 2: // stats
      break;
    }
  }

  void mouseReleased() {
    switch (gameState) {
    case 0: // velg hall
      break;
    case 1: // build it
      if (mouseButton == RIGHT) {
        int tempValue = tempCube.w;
        tempCube.w = tempCube.h;
        tempCube.h = tempValue;
      }
      else {
        // TODO Add map constraints
        if (tempCube != null) {
          if (mouseX > 200 && mouseY > 200 && mouseX < 310-tempCube.w && mouseY < 260-tempCube.h) { // This can be small map
            for (Cube c : cubes) { // Look for busy area
              if (!c.available(tempCube)) {
                tempCube = null;
                return;
              }
            }
            cubes.add(tempCube);
            tempCube = null;
          }
          else {
            tempCube = null;
          }
        }
      }
      break;
    case 2: // stats
      break;
    }
  }

  void () {
    switch (gameState) {
    case 0: // velg hall
      if (mouseX > 100 && mouseX < 150 && mouseY > 100 && mouseY < 150) { // small hall
      lanHall = 0;
      } 
      else if (mouseX > 200 && mouseX < 250 && mouseY > 100 && mouseY < 150) { // medium
      lanHall = 1;
      } 
      else if (mouseX > 100 && mouseX < 150 && mouseY > 200 && mouseY < 250) { // large
      lanHall = 2;
      } 
      else if (mouseX > 200 && mouseX < 250 && mouseY > 200 && mouseY < 250) { // vikingskipet
      lanHall = 2;
      }
      gameState = 1;
      break;
    case 1: // build it
      break;
    case 2: // stats
      break;
    }
  }

  void keyPressed() {
    switch (gameState) {
    case 0: // velg hall
      break;
    case 1: // build it
      break;
    case 2: // stats
      gameState = 0;
      LANTycoon.this.gameState = 0;
      break;
    }
  }
}

