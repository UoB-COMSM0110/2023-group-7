class Player {
  boolean alive, in_air, once;
  boolean fly_model, run_model;
  float born_x, born_y, x, y, mov_y, rot_angle;
  PImage img;
  int half_jump;
  Player(float p_x, float p_y, String img_path){
    this.born_x = p_x;
    this.born_y = p_y;
    this.x = born_x;
    this.y = born_y;
    this.img = loadImage(img_path);
    this.img.resize((int)p_size, (int)p_size);
    this.rot_angle = 0;
    this.in_air = false;
    this.mov_y = height/70;
    this.run_model = true;
    this.fly_model = false;
  }
  
  void drawPlayer(float x, float y){
      if(!in_air) drawTail();
      imageMode(CENTER);
      image(img, x, y);
      imageMode(CORNER);
  }
  
  void drawTail(){
    noStroke();
     fill(255, 190);
     int step = height/45;
     for(int i = 4 * height/13; i >= height/15; i -= step){
         rect(x - i + random(height/30), y + height/(i+7) + random(step), height/(i+2), height/(i+2));
         rect(x - i + random(height/30), y +  height/(i+5) + random(step),  height/(i+2), height/(i+2));
     }
     noFill();
  }
  
  //rotate
  void rot(){
    this.rot_angle += 0.08;
    pushMatrix();
    translate(x,y);
    rotate(rot_angle);
    drawPlayer(0, 0);
    translate(0, 0);
    popMatrix();
  }
  
  void jump(){
     if(half_jump > 0){
       half_jump -= 10;
       this.y -= mov_y;
     }else{
       this.y += mov_y;
     }
     if(y == born_y){
         in_air = false;
         once = false;
     };
     p.rot();
  }
  
  void fly(){
    
  }
  
}
