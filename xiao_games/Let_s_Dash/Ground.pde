class Ground {
  PImage img;
  float r, g, b;
  float x, y;
  Ground(String img_path){
      this.img = loadImage(img_path);
      this.img.resize(width, height/3);
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
    this.x += -10;
    if(-this.x >= width) this.x = 0;
  }
 
}
