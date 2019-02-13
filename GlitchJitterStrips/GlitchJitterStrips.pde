PImage img;

int x1;
int y1;
int x2;
int y2;
int sx=10;
int sy=100;
int iter=100;

void setup(){
  size(640,360);

  img=loadImage("moonwalk.jpg");
  image(img,0,0);
  frameRate(5);
}

void draw() {
  sx=int(random(5,30));
    sy=int(random(50,130));
  
    loadPixels();
    x1=int(random(0,width-sx-1));
    y1=int(random(0,height-sy-1));
    x2=int(random(0,width-sx-1));
    y2=int(random(0,height-sy-1));
    
    for (int i=0; i<sx ;i++)
    {
      for (int j=0; j<sy;j++)
    {
      color temp=pixels[(x1+i) + (y1+j)*width];
      pixels[(x2+i) + (y2+j)*width]=pixels[(x1+int(random(0,i)))+(y1+int(random(0,j)))*width];
      pixels[(x1+i) + (y1+j)*width]=temp;
    }}
    updatePixels();
}
