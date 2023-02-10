class Ground {
  PImage img;
  float r, g, b;
  float x, y;
  Ground(String img_path){
      this.img = loadImage(img_path);
      this.img.resize(width, height/2);
      this.x = 0;
      this.y = gy_CORNER;
      this.r = 6;
      this.g = 14;
      this.b = 159;
  };
  void drawGround(){
    tint(this.r, this.g, this.b);
    image(this.img, this.x, gy_CORNER + offset_y);
    image(this.img, this.x + width, gy_CORNER + offset_y);
    noTint();
    //fill(0);
    //stroke(255);
    //strokeWeight(2);
    //rect(this.x - 5,  gy_CORNER + offset_y, width * 2, height/2);
    //noFill();
    //noStroke();
    
    this.x += -p.speed;
    if(-this.x >= width) this.x = 0;
  }
 
}
