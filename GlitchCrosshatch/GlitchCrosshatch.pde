/*
 sorting modes
 0 = black
 1 = brightness
 2 = white
 */

int mode = 0;

// image path is relative to sketch directory
PImage img;

int loops = 1;

// threshold values to determine sorting start and end pixels
int blackValue = -16000000;
int brightnessValue = 60;
int whiteValue = -13000000;

int row = 0;
int column = 0;


void setup() {
  img = loadImage("moonwalk.jpg");
  
  // use only numbers (not variables) for the size() command, Processing 3
  size(1, 1);
  
  // allow resize and update surface to image dimensions
  surface.setResizable(true);
  surface.setSize(img.width, img.height);
  
  // load image onto surface - scale to the available width,height for display
  image(img, 0, 0, width, height);
}


void draw() {
  
  println("Sorting Column " + column);
  img.loadPixels(); 
  sortColumn();
  //img.updatePixels();
  
  println("Sorting Row " + column);
  //img.loadPixels(); 
  sortRow();
  img.updatePixels();
  
  // load updated image onto surface and scale to fit the display width,height
  image(img, 0, 0, width, height);
  
  column += int(random(0,200));
  row += int(random(0,40));
  
  if (column > img.width - 1) {
    column = 0;
  }
  if (row > img.height - 1) {
    row = 0;
  }
  
}

void sortRow() {
  // current row
  int y = row;
  
  // where to start sorting
  int x = 0;
  
  // where to stop sorting
  int xend = 0;
  
  while(xend < img.width-1) {
    switch(mode) {
      case 0:
        x = getFirstNotBlackX(x, y);
        xend = getNextBlackX(x, y);
        break;
      case 1:
        x = getFirstBrightX(x, y);
        xend = getNextDarkX(x, y);
        break;
      case 2:
        x = getFirstNotWhiteX(x, y);
        xend = getNextWhiteX(x, y);
        break;
      default:
        break;
    }
    
    if(x < 0) break;
    
    int sortLength = xend-x;
    
    color[] unsorted = new color[sortLength];
    color[] sorted = new color[sortLength];
    
    for(int i=0; i<sortLength; i++) {
      unsorted[i] = img.pixels[x + i + y * img.width];
    }
    
    sorted = sort(unsorted);
    
    for(int i=0; i<sortLength; i++) {
      img.pixels[x + i + y * img.width] = sorted[i];      
    }
    
    x = xend+1;
  }
}


void sortColumn() {
  // current column
  int x = column;
  
  // where to start sorting
  int y = 0;
  
  // where to stop sorting
  int yend = 0;
  
  while(yend < img.height-1) {
    switch(mode) {
      case 0:
        y = getFirstNotBlackY(x, y);
        yend = getNextBlackY(x, y);
        break;
      case 1:
        y = getFirstBrightY(x, y);
        yend = getNextDarkY(x, y);
        break;
      case 2:
        y = getFirstNotWhiteY(x, y);
        yend = getNextWhiteY(x, y);
        break;
      default:
        break;
    }
    
    if(y < 0) break;
    
    int sortLength = yend-y;
    
    color[] unsorted = new color[sortLength];
    color[] sorted = new color[sortLength];
    
    for(int i=0; i<sortLength; i++) {
      unsorted[i] = img.pixels[x + (y+i) * img.width];
    }
    
    sorted = sort(unsorted);
    
    for(int i=0; i<sortLength; i++) {
      img.pixels[x + (y+i) * img.width] = sorted[i];
    }
    
    y = yend+1;
  }
}


// black x
int getFirstNotBlackX(int x, int y) {
  
  while(img.pixels[x + y * img.width] < blackValue) {
    x++;
    if(x >= img.width) 
      return -1;
  }
  
  return x;
}

int getNextBlackX(int x, int y) {
  x++;
  
  while(img.pixels[x + y * img.width] > blackValue) {
    x++;
    if(x >= img.width) 
      return img.width-1;
  }
  
  return x-1;
}

// brightness x
int getFirstBrightX(int x, int y) {
  
  while(brightness(img.pixels[x + y * img.width]) < brightnessValue) {
    x++;
    if(x >= img.width)
      return -1;
  }
  
  return x;
}

int getNextDarkX(int _x, int _y) {
  int x = _x+1;
  int y = _y;
  
  while(brightness(img.pixels[x + y * img.width]) > brightnessValue) {
    x++;
    if(x >= img.width) return img.width-1;
  }
  return x-1;
}

// white x
int getFirstNotWhiteX(int x, int y) {

  while(img.pixels[x + y * img.width] > whiteValue) {
    x++;
    if(x >= img.width) 
      return -1;
  }
  return x;
}

int getNextWhiteX(int x, int y) {
  x++;

  while(img.pixels[x + y * img.width] < whiteValue) {
    x++;
    if(x >= img.width) 
      return img.width-1;
  }
  return x-1;
}


// black y
int getFirstNotBlackY(int x, int y) {

  if(y < img.height) {
    while(img.pixels[x + y * img.width] < blackValue) {
      y++;
      if(y >= img.height)
        return -1;
    }
  }
  
  return y;
}

int getNextBlackY(int x, int y) {
  y++;

  if(y < img.height) {
    while(img.pixels[x + y * img.width] > blackValue) {
      y++;
      if(y >= img.height)
        return img.height-1;
    }
  }
  
  return y-1;
}

// brightness y
int getFirstBrightY(int x, int y) {

  if(y < img.height) {
    while(brightness(img.pixels[x + y * img.width]) < brightnessValue) {
      y++;
      if(y >= img.height)
        return -1;
    }
  }
  
  return y;
}

int getNextDarkY(int x, int y) {
  y++;

  if(y < img.height) {
    while(brightness(img.pixels[x + y * img.width]) > brightnessValue) {
      y++;
      if(y >= img.height)
        return img.height-1;
    }
  }
  return y-1;
}

// white y
int getFirstNotWhiteY(int x, int y) {

  if(y < img.height) {
    while(img.pixels[x + y * img.width] > whiteValue) {
      y++;
      if(y >= img.height)
        return -1;
    }
  }
  
  return y;
}

int getNextWhiteY(int x, int y) {
  y++;
  
  if(y < img.height) {
    while(img.pixels[x + y * img.width] < whiteValue) {
      y++;
      if(y >= img.height) 
        return img.height-1;
    }
  }
  
  return y-1;
}
