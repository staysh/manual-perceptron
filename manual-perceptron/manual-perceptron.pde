int CELLSIZE = 20;
int RESOLUTION = 20;
int GRID_SIZE = RESOLUTION*RESOLUTION;
int BankImgSz = 50;

drawBox input;
drawBox weight;
Bank nums;
PImage colorBar = createImage(50, 400, RGB);
PImage zoom;

int[] img1 = new int[GRID_SIZE];
int[] weight1 = new int[GRID_SIZE];
double sum = 0;
int bias = 0;

double activation = 0;
boolean painting = true;
color paintColor = color(255);
boolean isZoomed = false;

void setup () {
  size(1200, 700);
  strokeWeight(0.5);
  zoom = loadImage("zoomOut.png");
  for(int i = 0; i < GRID_SIZE; i++){
    img1[i] = 0;
    weight1[i] = (int)(random(128)+64);
    
  }
  input = new drawBox(150, 50, img1);
  weight = new drawBox(600, 50, weight1);
  nums = new Bank(50, 0);
  
  colorBar.loadPixels();
  for(int i = 0; i < colorBar.height; i++){
    for(int j = 0; j < colorBar.width; j++){
      colorBar.pixels[j+i*colorBar.width] = color((i/400.0) * 255);
    }
    //println((int)((i/400.0) * 255));
  }
  colorBar.updatePixels();
  
}

void draw () {
  if(isZoomed){
    background(255);
    image(zoom, 10, 10);
    stroke(255, 0, 0);
    noFill();
    ellipse(950, 70, 100, 100);
  } else {
    background(0);
    input.display();
    weight.display();
    nums.display();
    image(colorBar, 1100, 50);
    stroke(255);
    line(350, 550, 850, 550);
    fill(input.data[input.hilight]);
    rect(300, 500, 100, 100);
    reimann(img1, weight.data);
    activation = sigmoid(sum);
    fill((float)activation*255);
    ellipse(800, 550, 100, 100);
    fill(255);
    textSize(16);
    text("-1.0 -[", 1040, 50);
    text("+1.0 -[", 1040, 450);
    text("Input:      Weight: ", 425, 500);
    String in = nf(colorNorm(input.data[input.hilight]), 0, 2);
    String wt = nfp(color2weight(weight.data[weight.hilight]), 0, 3);
    String tot = nf(colorNorm(input.data[input.hilight])*color2weight(weight.data[weight.hilight]), 0, 3);
    text( in + "   x    " + wt + "   =   " + tot + "   +  ...", 425, 525);
    text("Activation :", 880, 525);
    text((float)activation, 880, 550);
    text("Sum :", 880, 575);
    text((float)sum, 880, 600);
    
    nums.getImage(img1);
    input.update(img1);
    //println(img1[50]);
    if(painting && isInDraw(mouseX, mouseY)){
     fill(paintColor);
     rect(mouseX, mouseY, CELLSIZE, CELLSIZE);
    }
  }
  
}

float color2weight(int c){
  return (brightness(c)/128.0 - 1.0);
}

float colorNorm(int c){
  return (brightness(c)/255);
}

void reimann(int[] c, int[] f){
  sum = 0;
  for(int i = 0; i < GRID_SIZE; i++){
    sum += (double)(brightness(c[i])/255 * color2weight(f[i]));
  }
  sum += bias;
}

double sigmoid(double x) {
    return (1/( 1 + Math.pow(Math.E,(-1*x))));
}

boolean isInDraw(int x, int y){
  if(x > 600 && x < 1000 && y > 50 && y < 450)
    return true;
  else
    return false;
}
boolean isInInput(int x, int y){
  if(x > 50 && x < 450 && y > 50 && y < 450)
    return true;
  else
    return false;
}

boolean isInSelect(int x, int y){
  if(x > 1100 && x < 1150 && y > 50 && y < 450)
    return true;
  else
    return false;
}
boolean isInNum(int x, int y){
  if(x > 50 && x < 100 && y > 0 && y < 650)
    return true;
  else
    return false;
}

void keyPressed() {
  if(key == 'z'){
    isZoomed = !isZoomed;
  }
}

void mousePressed(){
  if(isInDraw(mouseX, mouseY))
    weight.paint(mouseX, mouseY, paintColor);
  else if(isInSelect(mouseX, mouseY))
    paintColor = get(mouseX, mouseY);
  else if(isInNum(mouseX, mouseY))
    nums.sel(mouseX, mouseY);
  else if(isInInput(mouseX, mouseY)){
    input.hilight(mouseX, mouseY);
    weight.hilight = input.hilight;
  }
}
