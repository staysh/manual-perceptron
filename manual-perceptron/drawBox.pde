class drawBox {
  int x, y, w, h, hilight, cellSize;
  int[] data = new int[GRID_SIZE];
  boolean edit, select;
  
  
  drawBox(int x, int y, int[] data){
    this.x = x;
    this.y = y;
    w = RESOLUTION * CELLSIZE;
    h = RESOLUTION * CELLSIZE;
    cellSize = CELLSIZE;
    hilight = 0;
    edit = false;
    select = true;
    arrayCopy(data, this.data);
  }
  
  void update(int[] data){
    arrayCopy(data, this.data);
  }
  
  void display () {
     for(int i = 0; i < GRID_SIZE; i++){
      int x_disp = this.x + (i % RESOLUTION) * cellSize;
      int y_disp = this.y + (int)(i / RESOLUTION) * cellSize;
      if(this.select == true && i == hilight)
        stroke(255, 0, 0);
      else
        stroke(255);
      fill(this.data[i]);
      rect(x_disp, y_disp, cellSize, cellSize);
    }
  }
  
  void paint(int x, int y, color c){
    int xloc = (x - this.x) / CELLSIZE;
    int yloc = (y - this.y) / CELLSIZE;
    data[xloc+yloc*RESOLUTION] = c;
    //hilight = xloc+yloc*RESOLUTION;
  }
  void hilight(int x, int y){
    int xloc = (x - this.x) / CELLSIZE;
    int yloc = (y - this.y) / CELLSIZE;
    hilight = xloc+yloc*RESOLUTION;
  }

}
