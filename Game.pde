import java.util.List;

class Game {
  List<Cube> cubes;
  Cube tempCube, ent;
  int gameState;
  int lanHall, hminw, hmaxw, hminh, hmaxh;
  long time, money, year;
  boolean hallDrawn, gameCompleted;
  int[] results;

  public Game() {
    gameCompleted = true;
    cubes = new ArrayList<Cube>();

    gameState = 0;
    lanHall = -1;

    // temp
    time = millis()+120000;
    year = 1992;
    money = 1000;
  }

  void draw() {
    switch (gameState) {
    case 0: // velg hall
      fill(255);
      textAlign(LEFT);
      textSize(21);
      text("Choose your LAN hall:", 30, 30);
      textSize(16);
      text("Money: " + money, 500, 60);
      stroke(255);
      fill(102, 51, 0);
      rect(100, 100, 50, 50);
      text("Menighetshus\n0,-", 160, 117);
      if (money >= 1000) fill(255, 0, 0);
      else fill(100);
      rect(320, 100, 50, 50);
      text("Gymsal\n1 000,-", 380, 117);
      if (money >= 5000) fill(0, 255, 0);
      else fill(100);
      rect(100, 300, 50, 50);
      text("Flerbrukshall\n5 000,-", 160, 317);
      if (money >= 10000) fill(0, 0, 255);
      else fill(100);
      rect(320, 300, 50, 50);
      text("Vikingskipet\n10 000,-", 380, 317);
      noStroke();
      break;
    case 1: // build it
      if (!gameCompleted) {
        time = millis();
        gameCompleted = !gameCompleted;
      }
      grid();
      menu();
      stats();
      ent.draw();

      for (Cube c : cubes) {
        c.draw();
      }

      if (tempCube != null) {
        tempCube.update();
        tempCube.draw();
      }
      break;
    case 2: // stats
      if (gameCompleted) {
        time = ((millis() - time)*-1)/1000;
        year +=1;
        results = calculateProfits();
        gameCompleted = !gameCompleted;
      }
      grid();
      for (Cube c : cubes) {
        c.draw();
      }
      textAlign(LEFT);
      fill(0, 50);
      rect(-10.0, -10.0, (float) displayWidth, (float) displayHeight);
      fill(121, 121, 121, 199);
      rect(25, 25, 750, 450);
      fill(250);
      textSize(24);
      text("SCORE", 100, 110);
      line(90, 120, 190, 120);
      pushMatrix();
      textSize(21);
      fill(random(255), random(255), random(255));
      translate(200, 200);
      rotate(radians(PI/0.30));
      text("TG-" + (year-1) + " FINISHED!", -100, -100);
      popMatrix();

      fill(150);
      textSize(18);
      text("Year:   " + (year-1) + "\nExpenses: " + results[2] + "\nTicketsales: " + results[1] + "\nStand attraction " + (results[0]) + "\n\n\n\nNet Income: " + results[4], 100, 150);
      textSize(22);
      fill(250);
      text("INCOME: " + results[3], 100, 300);

      textSize(21);
      textAlign(CENTER);
      if (year<2014 && money > 99) text("CLICK\nTO CONTINUE\n(or esc to quit)", 500, 250);
      else text("CLICK\nTO QUIT", 500, 250);
      break;
    }
  }

  void menu() {
    pushMatrix();
    textAlign(LEFT);
    fill(200, 200, 200);
    translate(500, 0);
    textSize(12);
    //TEXT
    fill(0);
    rect(0, -1, 300, 500);
    fill(200);
    stroke(255);

    text("TABLE", 15, 20);
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
        ent = new Cube(hminw, hmaxh, 'E'); //Entrance
        break;
      case 1: // for medium map
        hminw = 150;
        hmaxw = 350;
        hminh = 200;
        hmaxh = 300;
        ent = new Cube(hminw, hmaxh, 'E'); //Entrance
        break;
      case 2: // for big map
        hminw = 50;
        hmaxw = 450;
        hminh = 200;
        hmaxh = 400;
        ent = new Cube(hminw, hmaxh, 'E'); //Entrance
        break;
      case 3: // for vikingskipet map
        hminw = 50;
        hmaxw = 450;
        hminh = 50;
        hmaxh = 450;
        ent = new Cube(hminw, hmaxh, 'E'); //Entrance
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
    fill(51, 51, 51);
    rect(x+170, 470, 109, 29);
    fill(255);
    line(500, 350, 800, 350);

    textAlign(LEFT);
    textSize(18);
    text("TIME: " + ((millis() - time)*-1)/1000, x, 370);
    text("MONEY: " + money, x, 400);
    text("YEAR: " + year, x, 430);
    text("IM READY!", x+ 180, 491);
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
      else if (mouseX > 500 && mouseY > 344) { // states goes here
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
      if (mouseButton == RIGHT && tempCube != null) {
        int tempValue = tempCube.w;
        tempCube.w = tempCube.h;
        tempCube.h = tempValue;
        tempCube.vertical = !tempCube.vertical;
      }
      else if (mouseButton == LEFT) {
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
            tempCube.saveClearSeats(cubes);
            money -= tempCube.price;
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
      else if (mouseX > 320 && mouseX < 370 && mouseY > 100 && mouseY < 150 && money >= 1000) { // medium
        money -=1000;
        lanHall = 1;
      } 
      else if (mouseX > 100 && mouseX < 150 && mouseY > 300 && mouseY < 350 && money >= 5000) { // large
        money -=5000;
        lanHall = 2;
      } 
      else if (mouseX > 320 && mouseX < 370 && mouseY > 300 && mouseY < 350 && money >= 10000) { // vikingskipet
        money -=10000;
        lanHall = 3;
      }
      else {
        return;
      }
      gameState = 1;
      break;
    case 1: // build it
      if (mouseButton == RIGHT && tempCube == null) {
        if (mouseX > hminw && mouseX < hmaxw && mouseY > hminh && mouseY < hmaxh) {
          Cube tmp = null;
          for (Cube c : cubes) {
            if (mouseX > c.x && mouseX < c.x + c.w && mouseY > c.y && mouseY < c.y + c.h) {
              tmp = c;
              break;
            }
          }
          if (tmp != null) {
            cubes.remove(tmp);
            money += tmp.price / 2;
          }
        }
      }
      if (mouseX > 689 && mouseY > 469) {
        this.gameState = 2;
      }
      break;
    case 2: // stats
      time = millis()+120000;
      money += results[3];
      cubes = new ArrayList<Cube>();
      hallDrawn = false;
      if (year>2013 || money < 99) {
        gameState = 0;
        LANTycoon.this.tycoonState = 0;
      }
      else 
        gameState = 0;
      break;
    }
  }

  void mouseDragged() {
    switch (gameState) {
    case 0: // velg hall
      break;
    case 1: // build it
      if (tempCube != null) {
        tempCube.clearSeats(cubes);
      }
      break;
    case 2: // stats
      break;
    }
  }

  int[] calculateProfits() {
    int expenses = 0;
    int income = 0;
    float multiplier = 1.0;
    int ticketPrice = 100+(lanHall*100);
    for (Cube c : cubes) {
      switch (c.type) {
      case 'T': //L TABLE
        expenses += c.price;
        income += ticketPrice*c.seats;
        break;
      case 't': //M TABLE
        expenses += c.price;
        income += ticketPrice*c.seats;
        break;
      case 'B': //S TABLE
        expenses += c.price;
        income += ticketPrice*c.seats;
        break;
      case 'U': //UiO
        expenses += c.price;
        multiplier += 0.15;
        break;
      case 'K': //KOMPLETT.NO
        expenses += c.price;
        multiplier += 0.75;
        break;
      case 'R': //RNDSTAND
        expenses += c.price;
        multiplier += 0.1;
        break;
      case 'E': //ENTRANCE
        break;
      }
    }
    //Remove previous variables and use this single int array after dev is finished.
    int [] result = {
      round(multiplier*100), income, expenses, round(income*multiplier), (round(income*multiplier) - expenses)
      };
      return result;
  }

  void keyReleased() {
    switch (gameState) {
    case 0: // choose hall
      break;
    case 1: // build it
      break;
    case 2: // stats
      break;
    }
  }
}

