class Player{
  float x, y, size;
  PImage img;
  int[] roomNum;
  int jumpHeight;
  boolean jump;
  Player(){
    this.x = width/2;
    this.y =  height/2;
    this.size = height/20;
    this.img = loadImage("imgs/player.png");
    this.img.resize(height/20,  height*2/20); 
  };
  
  void display(){
      drawPlayer();
  }
  
  void drawPlayer(){
     image(this.img, x,y);
  }

}
