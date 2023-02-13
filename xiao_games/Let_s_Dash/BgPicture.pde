class BgPicture {
  PImage img;
  float r, g, b;
  float start_x;
  BgPicture(String img_path){
    this.img = loadImage(img_path);
    this.img.resize(width, height);
    this.start_x = 0;
    this.r = 40;
    this.g = 47;
    this.b = 212;
  };
  
  void drawBpPicture(){
    tint(r, g, b);
    image(this.img, start_x, 0);
    image(this.img, start_x + width, 0);
    noTint();
    this.start_x += - height/700;
    if(-start_x >= width) start_x = 0;
    //wave();
  }
  
  //void wave(){
  //  stroke(random(255),random(255),random(255));
  //  stroke(255);
  //  strokeWeight(2);
  //  for(int i = 0; i < player.bufferSize() - 1; i++)
  //  {
  //    float x1 = map( i, 0, player.bufferSize(), 0, width );
  //    float x2 = map( i+1, 0, player.bufferSize(), 0, width );
  //    line( x1, height/5 + player.left.get(i)*50, x2, height/5 + player.left.get(i+1)*50 );
  //    line( x1, height*2/5 + player.right.get(i)*50, x2,height*2/5 + player.right.get(i+1)*50 );
  //  }
  //  noStroke();
  //}
  
}
