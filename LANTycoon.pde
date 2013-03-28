import java.util.List;

boolean testRad = false; // TEST
List<Cube> cubes;
Cube tempCube;
Thingy[][] board;

void setup() {
  board = new Thingy[5][5];
  size(500, 500);
  background(0);
  grid();
  noStroke();

  cubes = new ArrayList<Cube>();
  for (int x = 0; x < 5; x++){
    for (int y = 0; y < 5; y++){
      board[x][y] = new Thingy((x*10)+200,(y*10)+200);
      board[x][y].type = 'e';
    }
  }
  board[1][4].type = 'c';
}

void draw() {
  background(0);
  for(int x = 0; x < 5; x++){
    for (int y = 0; y < 5; y++){
      board[x][y].drawThing();
    }
  }
  grid();
  menu();

  for (Cube c : cubes) {
    c.draw();
  }

  if (tempCube != null) {
    tempCube.update();
    tempCube.draw();
  }
  //if (testRad) { // rad 1x4 seter
  // fill(134, 120, 39);
  //rect((mouseX/10)*10, (mouseY/10)*10, 40, 10);
  // }
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

void mouseDragged() {
}

// Dette blir en stor menu handler, boer nok lages en egen klasse for denne en gang :\
void mousePressed() {
  if (mouseX > 440 || mouseX < 400 || mouseY < 100 || mouseY > 110)
    return;
  else if (tempCube == null) {
    tempCube = new Cube(mouseX, mouseY, 'B');
  }
}

void mouseReleased() {
  // TODO Add map constraints
  if (tempCube != null) {
    if (mouseX > 200 && mouseY > 200 && mouseX < 300 && mouseY < 250) { // This can be small map
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

void mouseClicked() {
}

