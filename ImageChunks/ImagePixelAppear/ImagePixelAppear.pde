/**
 * Load and Display 
 * 
 * Images can be loaded and displayed to the screen at their actual size
 * or any other size. 
 */

PImage img;  // Declare variable "a" of type PImage
int chunkSize = 10; // number of pixels per square chunk
int numChunkRows;
int numChunkColumns;
int numChunks;
ArrayList<Integer> chunks = new ArrayList<Integer>();

void setup() {
  size(640, 360);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  img = loadImage("moonwalk.jpg");  // Load the image into the program  
  // Before we deal with pixels

  //loadPixels();  
  //// Loop through every pixel
  //for (int i = 0; i < pixels.length; i++) {
  //  // Pick a random number, 0 to 255
  //  float rand = random(255);
  //  // Create a grayscale color based on random number
  //  color c = color(rand);
  //  // Set pixel at that location to random color
  //  pixels[i] = c;
  //}
  //// When we are finished dealing with pixels
  //updatePixels(); 

  // each square of pixels is 10x10 pixels 
  numChunkRows = height/chunkSize;
  numChunkColumns = width/chunkSize;
  numChunks = numChunkRows * numChunkColumns;
  for (int i = 0; i < numChunks; i++) {
    chunks.add(i);
  }
}

void draw() {
  // Displays the image at its actual size at point (0,0)
  //image(img, 0, 0);
  // Displays the image at point (0, height/2) at half of its size
  //image(img, 0, height/2, img.width/2, img.height/2);

  //image(img, dx, dy, dw, dh, sx, sy, sw, sh); 
  //image(img, 10, 5, dw, dh, sx, sy, sw, sh);
  
  int randomChunk = floor(random(chunks.size()));
  int chunkToDisplay = chunks.get(randomChunk);
  chunks.remove(chunkToDisplay);

  int chunkCol = numChunkColumns % chunkToDisplay;
  int chunkRow = floor(numChunkColumns/chunkToDisplay);
  
  int chunkLoc = chunkCol + chunkRow*chunkSize;
  loadPixels(); 
  // Since we are going to access the image's pixels too  
  img.loadPixels(); 
  
  updatePixels();
}
