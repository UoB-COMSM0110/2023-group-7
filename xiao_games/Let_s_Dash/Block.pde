class Block{
  float x, y, w, h;//x, y, width, height
  boolean alive, used, collided;
  int g_t;//generation time
  Block(float x, float y, float w, float h, int g_t){
     this.x = x;
     this.y = y;
     this.w = w;
     this.h = h;
     this.g_t = g_t;
     this.alive = false;
     this.used = false;
     this.collided = false;
  }
  
  void drawBlock(){
    fill(255);
    rect(this.x, this.y + offset_y, this.w, this.h);
    this.x -= p.speed;
    if(this.x + this.w < 0) this.alive = false;
  }
  
  boolean checkCollision(){
     float closestX, closestY;
     if(p.x < this.x) closestX = this.x;
     else if (p.x > this.x + this.w) closestX = this.x + this.w;
     else closestX = p.x;
     
     if(p.y < this.y) closestY = this.y;
     else if (p.x > this.y + this.h) closestY = this.y + this.h;
     else closestY = p.y;
     return dist(p.x, p.y, closestX, closestY) > p.size/2;
  }
  
  void crash(){
     // true = no collided
     if(this.checkCollision()){
          p.on_block = false;
          return;
     }else{
         if(p.y + p.size/2 <= this.y + 5){
             p.jump_one = false;
             p.y = this.y - p.size/2;
             p.on_block = true;
             p.on_ground = false;
             p.block_y = this.y;
         }else if(p.x < this.x){
             p.alive = false;
         }
     }
  }

}
