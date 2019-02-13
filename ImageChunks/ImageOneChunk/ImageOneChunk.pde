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
  frameRate(2);

}

void draw() {
  selectedX = int(random(0,width));
  selectedY = int(random(0,height));
  
  int squareSize = int(random(20, 50));

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
      
      if(displayed[loc] == false){

        if(abs(x-selectedX)<squareSize && abs(y-selectedY)<squareSize){
          int index = selectedY*width+selectedX;
          // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
           r = red(img.pixels[loc]);
           g = green(img.pixels[loc]);
           b = blue(img.pixels[loc]);
           displayed[index] = true;
          }else{
            r = 255;
            g = 255;
            b = 255;
          }
      }
      
      // Set the display pixel to the image pixel
      pixels[loc] =  color(r,g,b);          
    }
  }
  updatePixels();
}
