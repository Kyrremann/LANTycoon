class Cube {

  int x, y, r, g, b;
  char type;
  int w, h;

  public Cube(int x, int y, char type) {
    this.x = x;
    this.y = y;
    this.type = type;

    switch (type) {
    case 'T':
      //TABLE
      w = 40;
      h = 10;
      r = 134;
      g = 120;
      b = 39;
      break;
    case 'E':
      //EXIT/ENTRANCE
      w = 20;
      h = 10;
      r = 0;
      g = 250;
      b = 0;
      break;
    case 'U':
      w = 80;
      h = 30;
      r = 255;
      g = 255;
      b = 255;
    }
  }

  void draw() {
    fill(r, g, b);
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

