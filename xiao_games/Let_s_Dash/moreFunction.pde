class moreFunction{
  ArrayList<Spine> spines;
  ArrayList<Block> blocks;
  int start_time;
  moreFunction(){
      this.start_time = 0; 
  };
  
  void init(){
      this.initSpines();
      this.initBlocks();
  }
  
  
  void initSpines(){
    this.spines = new ArrayList<Spine>();
    spines.add(new Spine(width, height*2/3 + height/22, 40));
    //spines.add(new Spine(width, height*2/3 + height/22, 100));
    //spines.add(new Spine(width + height/11, height*2/3 + height/22, 100));
    //spines.add(new Spine(width, height*2/3 + height/22, 500));
    //spines.add(new Spine(width + height/11, height*2/3 + height/22, 5000));
  }

  void initBlocks(){ //<>//
      this.blocks = new ArrayList<Block>();
      blocks.add(new Block(width, gy_CORNER - p_size, width, p_size, 80));
  }
  
  int run(){
     int flag = draw_spines();
     if(flag == CRASH_SPINE) return flag;
     flag = draw_blocks(); //<>//
     if(flag != NO_CRASH){
       return flag == CRASH_BLOCK_LEFT ? CRASH_BLOCK_LEFT : CRASH_BLOCK_UP;
     }
     return NO_CRASH;
  }
  
  int draw_spines(){
    for(int i = 0; i < spines.size(); i++){
        Spine s = spines.get(i);
        //activate
        if(s.g_t == frameCount){
          s.alive = true;
        }
        //draw
        if(s.alive){
          s.drawSpine();
        }
        //delete
        if(s.used && !s.alive){
            spines.remove(i);
        }
        //crash
        if(s.alive && s.crash() == CRASH_SPINE){
           return CRASH_SPINE;
        }
    }
    return NO_CRASH;
  }
  
  int draw_blocks(){
    for(int i = 0; i < blocks.size(); i++){
        Block b = blocks.get(i);
        //activate
        if(b.g_t == frameCount){
          b.alive = true;
        }
        //draw
        if(b.alive){
          b.drawBlock();
        }
        //delete
        if(b.used && !b.alive){
            blocks.remove(i);
        }
        //if crash
        if(b.alive){
           int flag = b.crash();
           if(flag != NO_CRASH){
               return flag == CRASH_BLOCK_LEFT ? CRASH_BLOCK_LEFT : CRASH_BLOCK_UP;
           }
        }
    }
    return NO_CRASH;
  }
  
  void gameOver(){
      textSize(128);
      text("Game over!", 40, 120); 
  }
  
  
}
