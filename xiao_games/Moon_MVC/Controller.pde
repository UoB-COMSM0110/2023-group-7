public class Controller{
   Model model;
   public Controller(Model mod){
      this.model = mod;
   };
      
   public void display(){
      changeRoomAndPlayerPos();
      checkAllAround();
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
       int index =model.getIndexByDirection(Type.TO_LEFT);         
       model.setCurrentRoomIndex(index);
       p.setX(width - sx - 1);
       getGhost().setX(getGhost().getX() + width);
   }
   
   public void goRight(Player p){
       this.generateRight(); 
       int index =model.getIndexByDirection(Type.TO_RIGHT);
       model.setCurrentRoomIndex(index);
       p.setX(1);
       getGhost().setX(getGhost().getX() - width);
   }
   
   public void goUp(Player p, float sy){
       this.generateUp(); 
       int index =model.getIndexByDirection(Type.TO_UP);
       model.setCurrentRoomIndex(index);
       p.setY(height - sy -1);
       getGhost().setY(getGhost().getY() + height);
   }
   
   public void goDown(Player p){
       this.generateDown(); 
       int index =model.getIndexByDirection(Type.TO_DOWN);
       model.setCurrentRoomIndex(index);
       p.setY(1);
       getGhost().setY(getGhost().getY() - height);
   }
   
   public void generateLeft(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.getAdjacent();
      if(adjacent[Type.TO_LEFT] == Type.NO_ROOM){
         model.addRoom(Type.ROOM_LR);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{Type.NO_ROOM,Type.NO_ROOM,Type.NO_ROOM, curRoom.getIndex()});
         curRoom.setAdjacent(new int[]{Type.NO_ROOM,Type.NO_ROOM,newRoom.getIndex(),Type.NO_ROOM});
      }
   }
   
   public void generateRight(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.getAdjacent();
      if(adjacent[Type.TO_RIGHT] == Type.NO_ROOM){
         model.addRoom(Type.ROOM_LR);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{Type.NO_ROOM,Type.NO_ROOM,curRoom.getIndex(),Type.NO_ROOM});
         curRoom.setAdjacent(new int[]{Type.NO_ROOM,Type.NO_ROOM,Type.NO_ROOM, newRoom.getIndex()});
      }
   }
   
   public void generateUp(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.getAdjacent();
      if(adjacent[Type.TO_UP] == Type.NO_ROOM){
         model.addRoom(Type.ROOM_UP);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{Type.NO_ROOM,curRoom.getIndex(),Type.NO_ROOM,Type.NO_ROOM});
         curRoom.setAdjacent(new int[]{newRoom.getIndex(),Type.NO_ROOM,Type.NO_ROOM,Type.NO_ROOM});
      }
   }
   
   public void generateDown(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.getAdjacent();
      if(adjacent[Type.TO_DOWN] == Type.NO_ROOM){
         model.addRoom(Type.ROOM_DOWN);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{curRoom.getIndex(),Type.NO_ROOM,Type.NO_ROOM,Type.NO_ROOM});
         curRoom.setAdjacent(new int[]{Type.NO_ROOM,newRoom.getIndex(),Type.NO_ROOM,Type.NO_ROOM});
      }
   }
   
   public boolean collisionDetectionTwoObj(BasicProp a, BasicProp b){
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
   
   public void checkAllAround(){
      //collision detection between enemies and blocks, enemies and player,enemies and bullets
      Room r = model.getCurrentRoom();
      Player p = model.getPlayer();
      ArrayList<Enemy> enemies = r.getEnemies();
      ArrayList<Bullet> bullets = r.getBullets();
      for(int i = 0; i < enemies.size(); i++){
         Enemy e = enemies.get(i);
         checkAround(e);
         if(collisionDetectionTwoObj(p,e)){
            //TO DO
            //delete 1HP of player
         }
         for(int j = 0; j < bullets.size(); j++){
             Bullet b = bullets.get(j);
             //if b out of board, remove
             if(b.getY() > height || b.getY() < 0 || b.getX() > width || b.getX() < 0){
                bullets.remove(j--);
             }
             //check bullets and enemies
             else if(collisionDetectionTwoObj(b,e)){
                enemies.remove(i--);
                bullets.remove(j--);
                break;
             }
         }
      }
      
      //collision detection between bullets and blocks
       //if b crash blocks, remove
         for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
            for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
                if(r.getBlockType(i,j) != Type.BLOCK_EMPTY){
                        for(int k = 0; k < bullets.size(); k++){
                             Bullet b = bullets.get(k);
                            if(collisionDetectionWithBlock(b, i, j)){
                                 bullets.remove(k--);
                             }
                       }
                }
            }
         }
      //collision detection between player and blocks
      checkAround(p);
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
         //println(flag1 + "," + flag2);
         if((collisionDetect(flag1) && x <= L * s + s + 1) || collisionDetect(flag2)){
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
         int flag1 = L >= 0 ? r.getBlockType(below,L) : r.getBlockType(below, 0);
         int flag2 = R < Type.BOARD_MAX_WIDTH ? r.getBlockType(below, R) : r.getBlockType(below, Type.BOARD_MAX_WIDTH - 1);
         
         if(o.getType() == Type.PLAYER){
              //portal
             if(!o.getTransported() && ((flag1 == Type.BLOCK_PORTAL && x < L * s + s + 1) || flag2 == Type.BLOCK_PORTAL)){
                 Block b = flag2 == Type.BLOCK_PORTAL ? r.getBlockByPos(below , R) : r.getBlockByPos(below , L);
                 usePortal(b);
                 o.setTransported(true);
                 return;
             }
             //bounce
             o.setHighJump(false);
             if((flag1 == Type.BLOCK_BOUNCE && x < L * s + s + 1) || flag2 == Type.BLOCK_BOUNCE){
                 o.setHighJump(true);
             }
         }
         
         //if enemies, change direction
         if(o.getType() != Type.PLAYER){
             //if((flag1 ==  Type.BLOCK_EMPTY && flag2 !=  Type.BLOCK_EMPTY)
              //|| (flag2 ==  Type.BLOCK_EMPTY && flag1 !=  Type.BLOCK_EMPTY)
             if((!collisionDetect(flag1) && collisionDetect(flag2))
              || (!collisionDetect(flag2) && collisionDetect(flag1))
             ){
                o.setSpeedX(-o.getSpeedX());
                o.setX(o.getX() + o.getSpeedX());
             }
         }
         
         //if(flag1 == Type.BLOCK_EMPTY && flag2 == Type.BLOCK_EMPTY){
         if(!collisionDetect(flag1) && !collisionDetect(flag2)){
               o.setFall(true);
               o.setJump(true);
         }
         //if((flag1 != Type.BLOCK_EMPTY && x < L * s + s + 1) || flag2 != Type.BLOCK_EMPTY){
         if(((collisionDetect(flag1) && x < L * s + s + 1) || collisionDetect(flag2)) && (y + h + o.getSpeedY()>= below * s)){
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
         if(collisionDetect(flag1) || collisionDetect(flag2) || (collisionDetect(flag3) && y + h > h3 * s)){
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
         if(collisionDetect(flag1) || collisionDetect(flag2) || (collisionDetect(flag3) && y + h > h3 * s)){
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
   
   //added this boolean so that we can turn off collision detection for blocks other than the background
   public boolean collisionDetect(int flag){
     if(flag == Type.BLOCK_EMPTY || flag == Type.BLOCK_CRATE){
       return false;
     }
     return true;
   }
   
   
   public Enemy getGhost(){
       return model.getGhost();
   }
   
   public void controlPlayer(int dir){
     Player p = model.getPlayer();
     if(dir == Type.KEY_LEFT){
        p.setLeft(true);
        //println(p.getLeft());
        p.setSpeedX(-Type.PLAYER_SPEED_X);
     }
     if(dir == Type.KEY_RIGHT){
        p.setLeft(false);
        p.setSpeedX(Type.PLAYER_SPEED_X);
     }
     if(dir == Type.KEY_RELEASED){
        p.setSpeedX(0);
     }
     if(dir == Type.KEY_SPACE){
        if(p.getJump())return;
        if(p.getHighJump()){
          p.setSpeedY(-15);
        }
        else{
        p.setJump(true);
        p.setFall(true);
        p.setSpeedY(-Type.PLAYER_SPEED_Y);
        }
     }
     if(dir == Type.KEY_UP){
       p.setTransported(false);
     }
   }
   
   public void shotBullet(){
      Room r = model.getCurrentRoom();
      Player p = model.getPlayer();
      //println("bullet");
      r.getBullets().add(new Bullet(p.getX() + p.getWidth()/2, p.getY()+ p.getHeight()/2, p.getLeft() ? -Type.SPEED_BULLET : Type.SPEED_BULLET));
   }
   
}
