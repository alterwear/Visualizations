/**
 * Milliseconds. 
 * 
 * A millisecond is 1/1000 of a second. 
 * Processing keeps track of the number of milliseconds a program has run.
 * By modifying this number with the modulo(%) operator, 
 * different patterns in time are created.  
 */
 
float bandSize;

void setup() {
  size(640, 360);
  noStroke();
  bandSize = width/20;
}

void draw() { 
  for (int i = 0; i < bandSize; i++) {
    colorMode(RGB, (i+1) * bandSize * 10);
    fill(millis()%((i+1) * bandSize * 10));
    rect(i*bandSize, 0, bandSize, height);
  }
}
