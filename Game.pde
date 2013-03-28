import java.util.List;

class Game {
  List<Cube> cubes;
  Cube tempCube;
  int gameState;
  int lanHall, hminw, hmaxw, hminh, hmaxh;
  long time, money, year;
  boolean hallDrawn;

  public Game() {
    cubes = new ArrayList<Cube>();

    gameState = 0;
    lanHall = -1;

    // temp
    time = millis();
    year = 1992;
    money = 10000;
  }

  void draw() {
    switch (gameState) {
    case 0: // velg hall
      fill(255);
      textAlign(LEFT);
      textSize(21);
      text("Choose your LAN hall:", 30, 30);
      stroke(255);
      fill(128, 128, 128);
      rect(100, 100, 50, 50);
      fill(255, 0, 0);
      rect(200, 100, 50, 50);
      fill(0, 255, 0);
      rect(100, 200, 50, 50);
      fill(0, 0, 255);
      rect(200, 200, 50, 50);
      noStroke();
      break;
    case 1: // build it
      grid();
      menu();
      stats();

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
    if (!hallDrawn) {
      switch(lanHall) {
      case 0: // for small map
        hminw = 200;
        hmaxw = 300;
        hminh = 200;
        hmaxh = 250;
        cubes.add(new Cube(hminw, hmaxh, 'E')); //Entrance
        break;
      case 1: // for medium map
        hminw = 150;
        hmaxw = 350;
        hminh = 200;
        hmaxh = 300;
        cubes.add(new Cube(hminw, hmaxh, 'E')); //Entrance
        break;
      case 2: // for big map
        hminw = 50;
        hmaxw = 450;
        hminh = 200;
        hmaxh = 400;
        cubes.add(new Cube(hminw, hmaxh, 'E')); //Entrance
        break;
      case 3: // for vikingskipet map
        hminw = 50;
        hmaxw = 450;
        hminh = 50;
        hmaxh = 450;
        cubes.add(new Cube(hminw, hmaxh, 'E')); //Entrance
        break;
      }
      hallDrawn = true;
    }

    stroke(64);
    for (int x = hminw; x < hmaxw; x += 10) {
      line(x, hminh, x, hmaxh);
      for (int y = hminh; y < hmaxh; y += 10) {
        line(hminw, y, hmaxw, y);
      }
    }
    line(hmaxw, hminh, hmaxw, hmaxh);
    line(hminw, hmaxh, hmaxw, hmaxh);
    stroke(255);
  }

  void stats() {
    // TODO add stats
    int x = 520;
    fill(255);
    line(500, 350, 800, 350);

    textAlign(LEFT);
    textSize(18);
    text("TIME: " + ((millis() - time)*-1)/1000, x, 370);
    text("MONEY: " + money, x, 400);
    text("YEAR: " + year, x, 430);
  }

  // Dette blir en stor menu handler, boer nok lages en egen klasse for denne en gang :\
  void mousePressed() {
    switch (gameState) {
    case 0: // velg hall
      break;
    case 1: // build it
      if (mouseX > 500 && mouseY < 344) { // clicked inside menu/panel area
        // the following if's are for the different cubes
        if (mouseY > 324 && mouseY < 324 + 20) tempCube = new Cube(mouseX, mouseY, 'R');
        else if (mouseY > 209 && mouseY < 209 + 80) tempCube = new Cube(mouseX, mouseY, 'K');
        else if (mouseY > 139 && mouseY < 139 + 30) tempCube = new Cube(mouseX, mouseY, 'U');
        else if (mouseY > 69 && mouseY < 69 + 10) tempCube = new Cube(mouseX, mouseY, 'B');
        else if (mouseY > 49 && mouseY < 49 + 10) tempCube = new Cube(mouseX, mouseY, 't');
        else if (mouseY > 29 && mouseY < 29 + 10) tempCube = new Cube(mouseX, mouseY, 'T');
      } 
      else if (mouseX > 500 && mouseY < 344) { // states goes here
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
          if (mouseX > hminw && mouseY > hminh && mouseX <= 10 + hmaxw-tempCube.w && mouseY <= 10 + hmaxh-tempCube.h) {
            for (Cube c : cubes) { // Look for busy area
              if (!c.available(tempCube)) {
                tempCube = null;
                return;
              }
            }
            if (money < tempCube.price) {
              // TODO inform about to expensive
              tempCube = null;
              return;
            }
            cubes.add(tempCube);
            // remove money from account
            money -= tempCube.price;
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
        lanHall = 3;
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
      LANTycoon.this.tycoonState = 0;
      break;
    }
  }
}

