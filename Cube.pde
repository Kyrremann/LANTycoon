import java.util.List;

class Cube {

  int x, y, r, g, b, value, price, maxSeats, seats, tempSeats;
  char type;

  public Cube(int x, int y, char type) {
    this.x = x;
    this.y = y;
    this.type = type;

    switch (type) {
    case 'T': //L TABLE
      w = 40;
      h = 10;
      r = 134;
      g = 120;
      b = 39;
      price = 800;
      seats = 8;
      break;
    case 't': //M TABLE
      w = 20;
      h = 10;
      r = 134;
      g = 120;
      b = 39;
      price = 300;
      seats = 4;
      break;
    case 'B': //S TABLE
      w = 10;
      h = 10;
      r = 134;
      g = 120;
      b = 39;
      price = 100;
      seats = 2;
      break;
    case 'U': //UiO
      w = 80;
      h = 30;
      r = 255;
      g = 0;
      b = 0;
      price = 2000;
      break;
    case 'K': //KOMPLETT.NO
      w = 100;
      h = 80;
      r = 0;
      g = 128;
      b = 255;
      price = 50000;
      break;
    case 'R': //RNDSTAND
      w = 60;
      h = 20;
      r = 100;
      g = 100;
      b = 100;
      price = 1500;
      break;
    case 'E': //ENTRANCE
      w = 20;
      h = 10;
      r = 0;
      g = 250;
      b = 0;
      break;
    }
  }

  void draw() {
    fill(r, g, b);
    rect(x, y, w, h);
    if (seats > 0) {
      fill(255);
      textAlign(CENTER);
      textSize(10);
      text(seats - tempSeats, x + (w / 2), y + h - 1);
    }
  }

  void update() {
    x = (mouseX/10)*10;
    y = (mouseY/10)*10;
  }

  // Return true if avaiable
  boolean available(Cube c) {
    if (c.x >= (x+w)) return true;
    if (c.y >= (y+h)) return true;
    if ((c.x+c.w) <= x) return true;
    if ((c.y+c.h) <= y) return true;
    return false;
  }

  boolean checked;

  void clearSeats(List<Cube> cubes) {
    tempSeats = 0;
    for (Cube c : cubes) {
      c.tempSeats = 0;
      for (int j = 0; j < w/10; j++) {
        for (int i = 0; i < c.w / 10; i++) {
          if (y == c.y + h || y + h == c.y) {
            if ((x + (j * 10)) == (c.x + (i * 10))) {
              tempSeats++;
              c.tempSeats++;
            }
          }
        }
      }
    }
    
    for (int j = 0; j < w/10; j++) {
      if (y + h == LANTycoon.this.game.hmaxh || y == LANTycoon.this.game.hminh) {
        tempSeats++;
      }
    }
  }

  void saveClearSeats(List<Cube> cubes) {
    tempSeats = 0;
    for (Cube c : cubes) {
      c.tempSeats = 0;
      for (int j = 0; j < w/10; j++) {
        for (int i = 0; i < c.w / 10; i++) {
          if (y == c.y + h || y + h == c.y) {
            if ((x + (j * 10)) == (c.x + (i * 10))) {
              seats--;
              c.seats--;
            }
          }
        }
      }
    }

    for (int j = 0; j < w/10; j++) {
      if (y + h == LANTycoon.this.game.hmaxh || y == LANTycoon.this.game.hminh) {
        seats--;
      }
    }
  }
}

