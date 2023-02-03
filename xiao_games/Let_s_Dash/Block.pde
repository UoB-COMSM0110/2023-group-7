class Block{
  float x, y, w, h;//x, y, width, height
  boolean alive, used;
  int g_t;//generation time
  Block(float x, float y, float w, float h, int g_t){
     this.x = x;
     this.y = y;
     this.w = w;
     this.h = h;
     this.g_t = g_t;
     this.alive = false;
     this.used =false;
  }
  
  void drawBlock(){
    fill(255);
    rect(this.x, this.y + offset_y, this.w, this.h);
    this.x -= p_speed;
  }
  
  int crash(){
    if(px_CORNER >= this.x && px_CORNER <= this.x + this.w && py_CORNER >= this.y - this.h && py_CORNER <= this.y){
       if(px_CORNER == this.x && py_CORNER > this.y - this.h) return CRASH_BLOCK_LEFT;
       if(py_CORNER == this.y - this.h && px_CORNER >= this.x){
         offset_y = this.h;
         return CRASH_BLOCK_UP;
       }
    }
    return NO_CRASH;
  }

}
