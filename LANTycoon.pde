import java.util.List;

boolean testRad = false; // TEST

void setup() {
  size(500, 500);
  background(0);
  grid();
  noStroke();
}

void draw() {
  background(0);
  grid();
  menu();
  if (testRad) { // rad 1x4 seter
    fill(134, 120, 39);
    rect((mouseX/10)*10, (mouseY/10)*10, 40, 10);
  }
}

void menu() {
  fill(134, 120, 39);
  rect(400, 100, 40, 10);
}

void grid() {
  stroke(64);
  for (int x = 0; x < 500; x += 10) {
    line(x, 0, x, 500);
    for (int y = 0; y < 500; y += 10) {
      line(0, y, 500, y);
    }
  }
  //noStroke();
  stroke(255);
}

void mouseDragged() {
  //if (testRad) { // rad 1x4 seter
   // fill(134, 120, 39);
   // rect((mouseX/10)*10, (mouseY/10)*10, 40, 10);
 // }
}

void mousePressed() {
  if (mouseX > 440)
    return;
  if (mouseX < 400)
    return;
  if (mouseY < 100)
    return;
  if (mouseY > 110)
    return;
  testRad = true;
}

void mouseReleased() {
  // TODO Check if legal
  testRad = false;
}

void mouseClicked() {
}

