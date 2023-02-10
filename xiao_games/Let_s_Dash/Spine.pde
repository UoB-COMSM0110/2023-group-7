class Spine{
  float x, y;
  boolean alive, used;
  int g_t;//generation time
  Spine(float x, float y, int g_t){
     this.x = x;
     this.y = y;
     this.g_t = g_t;
     this.alive = false;
     this.used = false;
  }
  
  void drawSpine(){
    fill(255);
    stroke(0);
    strokeWeight(5);
    triangle(this.x, this.y + offset_y, this.x + p.size, this.y + offset_y, this.x + p.size/2, this.y - p.size + offset_y);
    noStroke();
    noFill();
    this.x -= p.speed;
    if(this.x < 0) this.alive = false;
  }
  
  int crash(){
    //if(px_CORNER >= this.x && px_CORNER <= this.x + p.size && py_CORNER >= this.y - p.size && py_CORNER <= this.y){
    //   return CRASH_SPINE;
    //}
    return NO_CRASH;
  }
  
}
