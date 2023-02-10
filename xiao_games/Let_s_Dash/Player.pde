/**
* in run_model, player should be kept in 1/3 middle of screen
* action: jump(), fly(), shot()
* mode: fly_model, run_model, shot_model
* status: alive, shield, shot
*/
class Player {
  PImage img;// draw player
  boolean alive, on_block, on_ground;
  boolean in_air, jump_one, jump_two;
  boolean fly_model, run_model;
  float born_x, born_y, x, y, size, speed, mov_y, rot_angle, rot_angle_micro, jump_height, jh_init;
  float block_y, ground_y;
  int double_jump, shield, shot;
  int score;
  Player(float x, float y, float size,float speed, String img_path){
    this.born_x = x;
    this.born_y = y;
    this.x = born_x;
    this.y = born_y;
    this.size = size;
    this.speed = speed;
    this.img = loadImage(img_path);
    this.img.resize((int)this.size, (int)this.size);
    this.rot_angle = 0;
    this.jh_init = this.size * 2;
    this.mov_y = jh_init / 13;
    this.rot_angle_micro = 0.12;
    this.run_model = true;
    this.fly_model = false;
    this.on_block = false;
    this.on_ground = true;
    this.double_jump = 10000;
    this.alive = true;
  }
  
  void display(){
    crashGround();
    if(this.run_model){
       this.runModel();
    }else{
       this.flyModel();
    }
    
  }
  
  void drawPlayer(float x, float y){
      if(this.alive){
        imageMode(CENTER);
        image(this.img, x, y);
        imageMode(CORNER);
      }
  }
  
  void runModel(){
     this.cntOffsetY();
      if(mousePressed){
          if(!this.jump_one){
              this.jump_height = jh_init;
              this.jump_one = true;
          }
      }
      if(!this.on_block && !this.on_ground){
          this.jump_one = true;
          this.jump();
      }else{
          if(this.jump_one){
             this.jump();
          }else{
             this.drawPlayer(this.x, this.y);
          }
      } //<>//
  }
  
  void flyModel(){
      if(mousePressed){
          this.y -= this.mov_y;
      }else{
          this.y += this.mov_y;
      }
      drawPlayer(this.x, this.y);
  }
  
  void cntOffsetY(){
    if( this.y + this.size/2 < height - gy_CORNER || this.y > gy_CORNER){
         offset_y = this.y <  height - gy_CORNER ?  height - gy_CORNER - this.y - this.size/2: gy_CORNER - this.y;
     }else{
         offset_y = 0;
     }
  }
  
  void rot(){
    pushMatrix();
    translate(this.x,this.y);
    rotate(this.rot_angle);
    this.drawPlayer(0, 0);
    translate(0, 0);
    popMatrix();
  }
  
  void jump(){
     this.rot_angle += this.rot_angle_micro;
     if(this.jump_height > 0){
       this.jump_height -= this.mov_y;
       this.y -= this.mov_y;
     }else{
       this.y += this.mov_y;
     }
     if(this.on_block){
         if(this.y + this.size/2 >= this.block_y){
           this.y = this.block_y - this.size/2;
           reset_jump();
         }
     }else{
         if(this.y + this.size/2 >= g.y){
           this.y = g.y - this.size/2;
           this.on_ground = true;
           reset_jump();
         }
     }
     this.rot();
  }
  
  void reset_jump(){
     this.rot_angle = 0;
     this.jump_one = false;
     this.jump_two = false;
  }
  
  void crashGround(){
    //crash spine
    
    //else
    if(gy_CORNER == this.y + p.size/2){
      this.y = this.born_y;
      this.on_ground = true;
    }
  }
}
