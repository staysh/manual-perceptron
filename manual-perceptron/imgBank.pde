class Bank {
  PImage[] numbers;
  int[] displayed;
  PVector[][] GUI_Bank_Corners;
  int selected;
  
  Bank(int x, int y){
    int padding = 10;
    numbers = new PImage[100];
    displayed = new int[10];
    GUI_Bank_Corners = new PVector[10][2];
    selected = 0;
    
    for(int i = 0; i < 100; i++){
      numbers[i] = loadImage(i+".png");
    }
    
    for(int i = 0; i < 10; i++){
      displayed[i] = (int)random(10) + i*10;
      int yloc = (BankImgSz+padding)*i + y;
      GUI_Bank_Corners[i][0] = new PVector(x, yloc);
      GUI_Bank_Corners[i][1] = new PVector(x+BankImgSz, yloc+BankImgSz);    
    }
  }
  
  void update () {
    for(int i = 0; i < 10; i++){
      displayed[i] = (int)random(10) + i*10;
    }
  }
  
  void display () {
    for(int i = 0; i < 10; i++){
      image(numbers[displayed[i]], GUI_Bank_Corners[i][0].x, GUI_Bank_Corners[i][0].y);
    }
    stroke(255);
    noFill();
    rect( GUI_Bank_Corners[selected][0].x, GUI_Bank_Corners[selected][0].y, 50, 50);
  }
  
  void getImage(int[] disp){
    float scalar = (float)BankImgSz/RESOLUTION;
    for(int x = 0; x < RESOLUTION; x++){
      for(int y = 0; y < RESOLUTION; y++){
        disp[x+y*RESOLUTION] = (int)brightness(numbers[displayed[selected]].get((int)(x*scalar), (int)(y*scalar)));
        //println(disp[x+y*RESOLUTION]);
      }
    }
  }
  
  void sel(int x, int y){
    for(int i = 0; i < 10; i++){
      if(x > GUI_Bank_Corners[i][0].x && x < GUI_Bank_Corners[i][1].x &&
         y > GUI_Bank_Corners[i][0].y && y < GUI_Bank_Corners[i][1].y){
           if(selected == i)
             update();
           else
             selected = i;
         }
    }
  }
    
}
