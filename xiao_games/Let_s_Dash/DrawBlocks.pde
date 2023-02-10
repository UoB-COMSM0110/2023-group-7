class DrawBlocks{
  ArrayList<Spine> spines;
  ArrayList<Block> blocks;
  int start_time;
 
  void loadMapData(int num){
      this.start_time = 0;
      this.spines = new ArrayList<Spine>();
      this.blocks = new ArrayList<Block>();
      map.loadMap(num);
  }
  
  void run(){
     if(this.spines.size()>0){
          draw_spines();
     }
    if(this.blocks.size()>0){
          draw_blocks();
     }
  }
  
  void draw_spines(){
    for(int i = 0; i < this.spines.size(); i++){
        Spine s = this.spines.get(i);
        //activate
        if(s.g_t == this.start_time){
          s.alive = true;
        }
        //draw
        if(s.alive){
          s.drawSpine();
        }
        //delete
        if(s.used && !s.alive){
            this.spines.remove(i);
        }
        //crash
        //if(s.alive && s.crash() == CRASH_SPINE){
        //   return CRASH_SPINE;
        //}
    }
  }
  
  void draw_blocks(){
    for(int i = 0; i < this.blocks.size(); i++){
        Block b = this.blocks.get(i);
        //activate
        if(b.g_t == this.start_time){
          b.alive = true;
        }
        //draw
        if(b.alive){
          b.drawBlock();
        }
        //delete
        if(b.used && !b.alive){
            this.blocks.remove(i);
        }
        //if crash
        if(b.alive && p.x + p.size/2 >= b.x && p.x - p.size/2 <= b.x + b.w){
           b.crash();
        }
    }
  }
  

}
