void setup() {
  size(500, 500);
  background(0);
  grid();
  noStroke();
}

void draw() {
  background(0);
  grid();
  noStroke();
}

void grid() {
  stroke(64);
  for (int x = 200; x < 250; x += 10) {
    line(x, 200, x, 250);
    for (int y = 200; y < 250; y += 10) {
      line(200, y, 250, y);
    }
  }
}

void mouseDragged() {
  System.out.println("dragged");
  if (mouseButton == LEFT)
    fill(255);
  else
    fill(0);
  rect((mouseX/10) * 10, (mouseY/10) * 10, 10, 10);
}

void mousePressed() {
  System.out.println("pressed");
}

void mouseReleased() {
  System.out.println("released");
}

void mouseClicked() {
  System.out.println("clicked");
  if (mouseButton == LEFT)
    fill(255);
  else
    fill(0);
  rect((mouseX/10) * 10, (mouseY/10) * 10, 10, 10);
}

