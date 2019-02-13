PImage img;
boolean displayed[];


void setup() {
  size(640, 360);
  img = loadImage("moonwalk.jpg");
  displayed = new boolean[230400];
  for(int i = 0 ; i < displayed.length; i++){
    displayed[i] = false;
  }
  frameRate(100);

}

void draw() {
  int selectedLoc = int(random(0,displayed.length));
  int bandSize = int(random(1, width/7));
  if(displayed[selectedLoc] == false){
    for (int i = selectedLoc-bandSize; i < selectedLoc+bandSize; i+=1) {
      if (i >= 0 && i < displayed.length) {
        displayed[i] = true;
      }
    }
  }
  
  println(selectedLoc);
  loadPixels(); 
  // Since we are going to access the image's pixels too  
  img.loadPixels(); 
  
  float r = 0;
  float g = 0;
  float b = 0;
  
  for (int pixel = 0; pixel < displayed.length; pixel+=1) {
      if(displayed[pixel] == true){
          r = red(img.pixels[pixel]);
          g = green(img.pixels[pixel]);
          b = blue(img.pixels[pixel]);
             
          // Set the display pixel to the image pixel
          pixels[pixel] =  color(r,g,b); 
      }
    }
    updatePixels();
  }
  
