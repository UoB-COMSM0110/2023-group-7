public class Controller{
   Model model;
   public Controller(Model mod){
      this.model = mod;
   };
      
   public void display(){
      changeRoomAndPlayerPos();
      checkEnemeyAround();
      checkAround(model.getPlayer());
      model.getPlayer().move();
   }
   
   public void changeRoomAndPlayerPos(){
      Player p = model.getPlayer();
      float x = p.getX();
      float y = p.getY();
      float sx = p.getWidth();
      float sy = p.getHeight();
      if(x <= 0){
         goLeft(p, sx);
      }else if(x + sx > width){
         goRight(p); 
      }else if(y < 0){
         goUp(p, sy);
      }else if(y + sy > height){
         goDown(p);
      }
   }
   
   public void goLeft(Player p, float sx){
       this.generateLeft();
       int index =model.getIndexByDirection(Type.KEY_LEFT);         
       model.setCurrentRoomIndex(index);
       p.setX(width - sx - 1);
       getGhost().setX(getGhost().getX() + width);
   }
   
   public void goRight(Player p){
       this.generateRight(); 
       int index =model.getIndexByDirection(Type.KEY_RIGHT);
       model.setCurrentRoomIndex(index);
       p.setX(1);
       getGhost().setX(getGhost().getX() - width);
   }
   
   public void goUp(Player p, float sy){
       this.generateUp(); 
       int index =model.getIndexByDirection(Type.KEY_UP);
       model.setCurrentRoomIndex(index);
       p.setY(height - sy -1);
       getGhost().setY(getGhost().getY() + height);
   }
   
   public void goDown(Player p){
       this.generateDown(); 
       int index =model.getIndexByDirection(Type.KEY_DOWN);
       model.setCurrentRoomIndex(index);
       p.setY(1);
       getGhost().setY(getGhost().getY() - height);
   }
   
   public void generateLeft(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.getAdjacent();
      if(adjacent[2] == -1){
         model.addRoom(Type.ROOM_LR);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{-1,-1,-1, curRoom.getIndex()});
         curRoom.setAdjacent(new int[]{-1,-1,newRoom.getIndex(),-1});
      }
   }
   
   public void generateRight(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.getAdjacent();
      if(adjacent[3] == -1){
         model.addRoom(Type.ROOM_LR);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{-1,-1,curRoom.getIndex(),-1});
         curRoom.setAdjacent(new int[]{-1,-1,-1, newRoom.getIndex()});
      }
   }
   
   public void generateUp(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.getAdjacent();
      if(adjacent[0] == -1){
         model.addRoom(Type.ROOM_UP);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{-1,curRoom.getIndex(),-1,-1});
         curRoom.setAdjacent(new int[]{newRoom.getIndex(),-1,-1,-1});
      }
   }
   
   public void generateDown(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.getAdjacent();
      if(adjacent[1] == -1){
         model.addRoom(Type.ROOM_DOWN);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{curRoom.getIndex(),-1,-1,-1});
         curRoom.setAdjacent(new int[]{-1,newRoom.getIndex(),-1,-1});
      }
   }
   
   public boolean collisionDetectionTwoObje(BasicProp a, BasicProp b){
       if(a.getX() + a.getWidth() > b.getX() &&
          a.getX() < b.getX() + b.getWidth() &&
          a.getY() + a.getHeight() > b.getY() &&
          a.getY() < b.getY() + b.getHeight()){
          return true;   
       }
       return false;
   }
   
   public boolean collisionDetectionWithBlock(BasicProp a, int i, int j){
       int s = Type.BOARD_GRIDSIZE;
       if(a.getX() + a.getWidth() > j * s &&
          a.getX() < j * s + s &&
          a.getY() + a.getHeight() > i * s &&
          a.getY() < i * s + s){
          return true;   
       }
       return false;
   }
   
   public void usePortal(Block b){
       Player o = model.getPlayer(); // o is obj = player
       float  s = Type.BOARD_GRIDSIZE;//s is block size
       int[] portal = b.getPortal(); 
       o.setY(s * portal[0] - 2 * s - 1); //set player Y
       o.setX(s * portal[1] + 1);  //set player X
   }
   
   public void checkEnemeyAround(){
      Room r = model.getCurrentRoom();
      ArrayList<Enemy> enemies = r.getEnemies();
      for(int i = 0; i < enemies.size(); i++){
         checkAround(enemies.get(i));
      }
   }
   
   
   public void checkAround(BasicProp o){
      checkLeft(o);
      checkRight(o);
      checkUp(o);
      checkDown(o);     
   }

    public void checkUp(BasicProp o){
      Room r = model.getCurrentRoom();
      float x = o.getX(), y = o.getY();
      float w = o.getWidth();
      float s = Type.BOARD_GRIDSIZE;
      int upper = (int)(y/s) - 1;
      int R = (int)((x + w)/s);
      int L = R - 1;
      if(upper >= 0){
         int flag1 = L >= 0 ? r.getBlockType(upper,L) : r.getBlockType(0, 0);
         int flag2 = R < Type.BOARD_MAX_WIDTH ? r.getBlockType(upper, R) : r.getBlockType(upper, Type.BOARD_MAX_WIDTH - 1);
         if((flag1 != Type.BLOCK_EMPTY && x != L * s + s + 1) || flag2 != Type.BLOCK_EMPTY){
            if(y + o.getSpeedY() <= upper * s + s){
                o.setSpeedY(0);
                o.setFall(false);
                o.setY(upper * s + s + 1);
             }
         }
      }
   }
 
    public void checkDown(BasicProp o){
      Room r = model.getCurrentRoom();
      float x = o.getX(), y = o.getY();
      float w = o.getWidth(), h = o.getHeight();
      float s = Type.BOARD_GRIDSIZE;
      int below = (int)((y + h)/s) + 1;
      int R = (int)((x + w)/s);
      int L = R - 1;
      if(below < 20){
         int flag1 = L >= 0 ? r.getBlockType(below,L) : r.getBlockType(0, 0);
         int flag2 = R < Type.BOARD_MAX_WIDTH ? r.getBlockType(below, R) : r.getBlockType(below, Type.BOARD_MAX_WIDTH - 1);
         
         if(o.getType() == Type.PLAYER){
              //portal
              println(o.getTransported());
             if(!o.getTransported() && ((flag1 == Type.BLOCK_PORTAL && x < L * s + s + 1) || flag2 == Type.BLOCK_PORTAL)){
                 Block b = flag2 == Type.BLOCK_PORTAL ? r.getBlockByPos(below , R) : r.getBlockByPos(below , L);
                 usePortal(b);
                 o.setTransported(true);
                 return;
             }
             //bounce
             if((flag1 == Type.BLOCK_BOUNCE && x < L * s + s + 1) || flag2 == Type.BLOCK_BOUNCE){
                 o.setSpeedY(-15);
                 o.setJump(true);
                 return;
             }
         }
         
         //if enemies, change direction
         if(o.getType() != Type.PLAYER){
             if((flag1 ==  Type.BLOCK_EMPTY && flag2 !=  Type.BLOCK_EMPTY)
              || (flag2 ==  Type.BLOCK_EMPTY && flag1 !=  Type.BLOCK_EMPTY)
             ){
                o.setSpeedX(-o.getSpeedX());
                o.setX(o.getX() + o.getSpeedX());
             }
         }
         
         
         if(flag1 == Type.BLOCK_EMPTY && flag2 == Type.BLOCK_EMPTY){
               o.setFall(true);
               o.setJump(true);
         }
         
         if((flag1 != Type.BLOCK_EMPTY && x < L * s + s + 1) || flag2 != Type.BLOCK_EMPTY){
             if(y + h + o.getSpeedY()>= below * s){
                  o.setFall(false);
                  o.setJump(false);
                  o.setSpeedY(0);
                  o.setY(below * s - h - 1);
             }else{
                  o.setFall(true);
                  o.setJump(true);
             }
         }

         
      }
   }
 
    public void checkLeft(BasicProp o){
      Room r = model.getCurrentRoom();
      float x = o.getX(), y = o.getY();
      float h = o.getHeight();
      float s = Type.BOARD_GRIDSIZE;
      int left = (int)(x/s) - 1;
      int h1 = (int)(y/s);
      int h2 = h1 + 1;
      int h3 = h2 + 1;
      if(left >= 0){
         int flag1 = h1 >= 0 ? r.getBlockType(h1,left) : r.getBlockType(0, left);
         int flag2 = h2 < Type.BOARD_MAX_HEIGHT ? r.getBlockType(h2, left) : r.getBlockType(Type.BOARD_MAX_HEIGHT - 1, left);
         int flag3 = h3 < Type.BOARD_MAX_HEIGHT ? r.getBlockType(h3, left) : r.getBlockType(Type.BOARD_MAX_HEIGHT - 1, left);
         if(flag1 != Type.BLOCK_EMPTY || flag2 != Type.BLOCK_EMPTY || (flag3 != Type.BLOCK_EMPTY && y + h > h3 * s)){
              // reach the end, shoud stop
              if(x + o.getSpeedX() <= left * s + s){
                  // if enemy, should change move direction
                  if(o.getType() != Type.PLAYER){
                     o.setSpeedX(-o.getSpeedX());
                  }else{
                     o.setSpeedX(0);
                  }
                  o.setX(left * s + s + 1);
               }
         }
      }
   }
   
   public void checkRight(BasicProp o){
      Room r = model.getCurrentRoom();
      float x = o.getX(), y = o.getY();
      float w = o.getWidth(), h = o.getHeight();
      float s = Type.BOARD_GRIDSIZE;
      int right = (int)((x + w)/s) + 1;
      int h1 = (int)(y/s);
      int h2 = h1 + 1;
      int h3 = h2 + 1;
      if(right < 29){
         int flag1 = h1 >= 0 ? r.getBlockType(h1, right) : r.getBlockType(0, right);
         int flag2 = h2 < Type.BOARD_MAX_HEIGHT ? r.getBlockType(h2, right) : r.getBlockType(Type.BOARD_MAX_HEIGHT - 1, right);
         int flag3 = h3 < Type.BOARD_MAX_HEIGHT ? r.getBlockType(h3, right) : r.getBlockType(Type.BOARD_MAX_HEIGHT - 1, right);
         if(flag1 != Type.BLOCK_EMPTY || flag2 != Type.BLOCK_EMPTY || (flag3 != Type.BLOCK_EMPTY && y + h > h3 * s)){
             if(x + w + o.getSpeedX() >= right * s){
                  if(o.getType() != Type.PLAYER){
                     o.setSpeedX(-o.getSpeedX());
                  }else{
                     o.setSpeedX(0);
                  }
                o.setX(right * s - w - 1);
             }
         }
      }
   }
   
   public Enemy getGhost(){
       return model.getGhost();
   }
   
   public void controlPlayer(int dir){
     Player p = model.getPlayer();
     if(dir == Type.KEY_LEFT){
        p.setSpeedX(-5);
     }
     else if(dir == Type.KEY_RIGHT){
        p.setSpeedX(5);
     }
     else if(dir == Type.KEY_RELEASED){
        p.setSpeedX(0);
     }
     else if(dir == Type.KEY_SPACE){
        if(p.getJump())return;
        p.setJump(true);
        p.setFall(true);
        p.setSpeedY(-10);
     }
     else if(dir == Type.KEY_UP){
       p.setTransported(false);
     }
   }
   
   
}
