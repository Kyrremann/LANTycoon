class Cube {

  int x, y;
  char type;
  int w, h;

  public Cube(int x, int y, char type) {
    this.x = x;
    this.y = y;
    this.type = type;

    switch (type) {
    case 'B':
      // TODO sett farge
      w = 40;
      h = 10;
      break;
    }
  }

  void draw() {
    fill(134, 120, 39);
    rect(x, y, w, h);
    // rect((mouseX/10)*10, (mouseY/10)*10, 40, 10);
  }

  void update() {
    x = (mouseX/10)*10;
    y = (mouseY/10)*10;
  }

  // Return true if avaiable
  boolean available(Cube c) {
    System.out.println(c.x + " - " + x);
    if (c.x >= (x+w)) return true;
    if (c.y >= (y+h)) return true;
    if ((c.x+c.w) <= x) return true;
    if ((c.y+c.h) <= y) return true;
    return false;
  }
}

