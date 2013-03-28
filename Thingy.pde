public class Thingy {
  float x, y;
  char type;
  char row;
  public Thingy(int x, int y) {
    this.x = x;
    this.y = y;
  }
  void drawThing() {
    noStroke();
    color filler = color(0,0,0);
    if (this.type == 'c') {
      filler = color(250, 204, 153);
    }
    fill(filler);
    rect(x, y, 10, 10);
  }
}

