PImage img;

void setup() {
  img = loadImage("moonwalk.jpg");

  // use only numbers (not variables) for the size() command, Processing 3
  size(1, 1);

  // allow resize and update surface to image dimensions
  surface.setResizable(true);
  surface.setSize(img.width, img.height);

  // load image onto surface
  image(img, 0, 0, img.width, img.height);
}


void draw() {
  if (!glitchComplete)
  {
    // load the image's pixels into .pixel array 
    img.loadPixels();

    boolean previousPixelGlitched = false;

    // random color 
    // 0-255, red, green, blue, alpha
    color randomColor = color(random(255), random(255), random(255), 255);

    // for each column of pixels
    for (int x = 0; x < img.width; x++) {

      // for each row of pixels
      for (int y = 0; y < img.height; y++) {

        // 25% chance to glitch this pixels, a second 80% chance if the previous pixel was glitched
        if (random(100) < 25 || (previousPixelGlitched == true && random(100) < 80))
        {
          previousPixelGlitched = true;

          // get the color for the pixel at coordinates x/y
          color pixelColor = img.pixels[y + x * img.height];

          // percentage to mix
          float mixPercentage = .5 + random(50)/100;

          // mix colors by random percentage of new random color
          img.pixels[y + x * img.height] =  lerpColor(pixelColor, randomColor, mixPercentage);
        } else
        {
          // didn't glitch this pixel
          previousPixelGlitched = false;

          // choose a new random mix color
          // 0-255, red, green, blue, alpha
          randomColor = color(random(255), random(255), random(255), 255);
        }
      }
    }

    img.updatePixels();

    // load updated image onto surface
    image(img, 0, 0, img.width, img.height);

    // apply some filters
    // https://processing.org/reference/filter_.html
    
    // posterize filter
    // filter(POSTERIZE, 4);
    
    // dilate filter
    // filter(DILATE);
  }
}
