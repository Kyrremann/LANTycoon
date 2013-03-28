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
    pushMatrix();
    fill(200, 200, 200);
    translate(500, 0);
    textSize(12);
    //TEXT
    fill(0);
    rect(0, -1, 300, 500);
    fill(200);
    stroke(255);
    text("BORD", 15, 20);
    text("800,-", 5, 40);
    text("300,-", 5, 60);
    text("100,-", 5, 80);

    text("UiO", 20, 130);
    text("2 000,-", 5, 150);

    text("KOMPLETT.NO", 20, 200);
    text("50 000,-", 5, 220);

    text("RND STAND", 20, 315);
    text("1 500,-", 5, 335);

    //RECTS TABLE
    fill(134, 120, 39);
    rect(60, 30, 40, 10);
    rect(60, 50, 20, 10);
    rect(60, 70, 10, 10);
    
    //RECT UiO
    fill(255, 0, 0);
    rect(60, 140, 100, 30);

    //RECT KOMPLETT
    fill(0, 128, 255);
    rect(60, 210, 100, 80);

    //RECT RNDSTAND
    fill(100, 100, 100);
    rect(60, 325, 60, 20);

    popMatrix();
  }

  void grid() { 
    switch(lanHall) {
    case 0: // for small map
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
      break;
    case 1: // for medium map
      break;
    case 2: // for big map
      break;
    case 3: // for vikingskipet map
      break;
    }
  }

  // Dette blir en stor menu handler, boer nok lages en egen klasse for denne en gang :\
  void mousePressed() {
    switch (gameState) {
    case 0: // velg hall
      break;
    case 1: // build it
      if (mouseX >500) { // clicked inside menu/panel area
 // the following if's are for the different cubes
        if (mouseY >324){
          tempCube = new Cube(mouseX, mouseY, 'R');
          println("RRRRRRRRRRRRR");
        }
        else if (mouseY >209) {
          tempCube = new Cube(mouseX, mouseY, 'K');
          println("KKKKKKKKKKKK");
        }
        else if (mouseY >120) {
          tempCube = new Cube(mouseX, mouseY, 'U');
          println("UUUUUUUUUUU");
        }
        else if (mouseY >69) tempCube = new Cube(mouseX, mouseY, 'B');
        else if (mouseY >49) tempCube = new Cube(mouseX, mouseY, 't');
        else if (mouseY >29) tempCube = new Cube(mouseX, mouseY, 'T');
      }
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

  void mouseClicked() {
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
      else {
        return;
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

