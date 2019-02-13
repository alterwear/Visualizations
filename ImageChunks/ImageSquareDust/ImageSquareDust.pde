PImage img;
int selectedX;
int selectedY;
boolean displayed[];


void setup() {
  size(640, 360);
  img = loadImage("moonwalk.jpg");
  displayed = new boolean[230400];
  for(int i = 0 ; i < displayed.length; i++){
    displayed[i] = false;
  }
  frameRate(5);

}

void draw() {
  selectedX = int(random(0,width));
  selectedY = int(random(0,height));
  int selectedLoc = selectedX + selectedY*width;
  int squareSize = int(random(5, 30));
  if(displayed[selectedLoc] == false){
    for (int y = selectedY-squareSize; y < selectedY+squareSize; y+=1) {
      for (int x = selectedX-squareSize; x < selectedX+squareSize; x+=1) {
        if (y >= 0 && y < height && x >= 0 && x < width) {
          int loc = x + y*width;
          displayed[loc] = true;
        }
      }
    }
    
    displayed[selectedLoc] = true;
  }
  
  println(selectedX,selectedY);
  loadPixels(); 
  // Since we are going to access the image's pixels too  
  img.loadPixels(); 
  
  float r = 0;
  float g = 0;
  float b = 0;
  
  for (int y = 0; y < height; y+=1) {
    for (int x = 0; x < width; x+=1) {
      
      int loc = x + y*width;
      
      if(displayed[loc] == true){
          r = red(img.pixels[loc]);
          g = green(img.pixels[loc]);
          b = blue(img.pixels[loc]);
             
          // Set the display pixel to the image pixel
          pixels[loc] =  color(r,g,b); 
        }
      }         
    }
    updatePixels();
  }
  
