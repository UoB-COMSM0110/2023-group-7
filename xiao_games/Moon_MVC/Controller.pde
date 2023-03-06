/**
* Get and change data from model
*/
public class Controller{
   Model model;
   private int bulletTimer;
   
   public Controller(Model mod){
      this.model = mod;
      this.bulletTimer = Type.BULLET_CD;
   };
   
   /**
   * Includes all methods to run in each frame
   */
   public void display(){
     
      if(model.getStartMenu()){
         
      }
      else if(model.getStartGame()){
          changeRoomAndPlayerPos();
          checkAllAround();
          model.getPlayer().move();
      }
      else if(model.getStartMenu()){
          
      }

   }
   
   /**
   * Check player's direction and use corresponding method
   */
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

   /**
   * If going left, set current room index in Model.class
   * change position of player and ghost
   */
   public void goLeft(Player p, float sx){
       this.generateLeft();
       int index =model.getIndexByDirection(Type.TO_LEFT);         
       model.setCurrentRoomIndex(index);
       p.setX(width - sx - 1);
       getGhost().setX(getGhost().getX() + width);
   }
   
   /**
   * Similar to the previous method, but the direction is to the right
   */
   public void goRight(Player p){
       this.generateRight(); 
       int index =model.getIndexByDirection(Type.TO_RIGHT);
       model.setCurrentRoomIndex(index);
       p.setX(1);
       getGhost().setX(getGhost().getX() - width);
   }
   
   /**
   * Similar to the previous method, but the direction is upward
   */
   public void goUp(Player p, float sy){
       this.generateUp(); 
       int index =model.getIndexByDirection(Type.TO_UP);
       model.setCurrentRoomIndex(index);
       p.setY(height - sy -1);
       getGhost().setY(getGhost().getY() + height);
   }
   
   /**
   * Similar to the previous method, but the direction is downward
   */
   public void goDown(Player p){
       this.generateDown(); 
       int index =model.getIndexByDirection(Type.TO_DOWN);
       model.setCurrentRoomIndex(index);
       p.setY(1);
       getGhost().setY(getGhost().getY() - height);
   }
   
   /**
   * Get current room info, if no room on the left, generate one on the left
   * if there is already on room on the left, just return index of that room
   */
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
   
   /**
   * Similar to the previous method, but the direction is to the right
   */
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
   
   /**
   * Similar to the previous method, but the direction is upward
   */
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
   
   /**
   * Similar to the previous method, but the direction is downward
   */
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
     
   /**
   * Collision detection between two BasicProp obj
   */
   public boolean collisionDetectionTwoObj(BasicProp a, BasicProp b){
       if(a.getX() + a.getWidth() > b.getX() &&
          a.getX() < b.getX() + b.getWidth() &&
          a.getY() + a.getHeight() > b.getY() &&
          a.getY() < b.getY() + b.getHeight()){
          return true;   
       }
       return false;
   }
   
   /**
   * Collision detection between one BasicProp obj and one block
   * block's position can be calculated by i and j
   */
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
   
   //added this boolean so that we can turn off collision detection for blocks other than the background
   //if return false, player can go through these type of blocks
   public boolean collisionDetect(int flag){
     if(flag == Type.BLOCK_EMPTY || flag == Type.BLOCK_CRATE || flag == Type.BLOCK_SPIKE){
       return false;
     }
     return true;
   }
   
   /**
   * Collision detection between:
   * enemies and blocks,
   * enemies and player
   * enemies and bullets
   * bullets and blocks
   * player and blocks
   */
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
                if(collisionDetect(r.getBlockType(i,j))){
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
   
   /**
   * Collision detection between player and blocks
   */
   public void checkAround(BasicProp o){
      checkLeft(o);
      checkRight(o);
      checkUp(o);
      checkDown(o);
      checkMore(o);
   }
   
   /**
   * Collision detection between player and blocks above
   */
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
         if((collisionDetect(flag1) && x < L * s + s + 1) || collisionDetect(flag2)){
            if(y + o.getSpeedY() <= upper * s + s){
                o.setSpeedY(0);
                o.setFall(false);
                o.setY(upper * s + s + 1);
             }
         }
      }
   }
 
   /**
   * Collision detection between player and blocks below
   * Changing properties of player by checking whether player is on special blocks.
   */
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
             if(((flag1 == Type.BLOCK_PORTAL && x < L * s + s + 1) || flag2 == Type.BLOCK_PORTAL)){
                 o.setOnPortal(true);
                 if(!o.getTransported()){
                     Block b = flag2 == Type.BLOCK_PORTAL ? r.getBlockByPos(below , R) : r.getBlockByPos(below , L);
                     usePortal(b);
                     o.setTransported(true);
                     return;
                 }
             }else{
               o.setOnPortal(false);
             }
             //bounce
             o.setHighJump(false);
             if((flag1 == Type.BLOCK_BOUNCE && x < L * s + s + 1) || flag2 == Type.BLOCK_BOUNCE){
                 o.setHighJump(true);
             }
             //spike - basic implemenation for now as we don't yet have a death mechanic
             if(o.getFall() && (flag2 == Type.BLOCK_SPIKE)){
               System.out.println("Death by spikes");
             }
         }
         
         //if enemies, change direction
         if(o.getType() != Type.PLAYER){
             if((!collisionDetect(flag1) && collisionDetect(flag2))
              || (!collisionDetect(flag2) && collisionDetect(flag1))
             ){
                o.setSpeedX(-o.getSpeedX());
                o.setX(o.getX() + o.getSpeedX());
             }
         }
         
         if(!collisionDetect(flag1) && !collisionDetect(flag2)){
               o.setFall(true);
               o.setJump(true);
         }
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
              if(x + o.getFullSpeedX() <= left * s + s){
                  // if enemy, should change move direction
                  if(o.getType() != Type.PLAYER){
                     o.setSpeedX(-o.getSpeedX());
                     o.setSpeedXInc(-o.getSpeedXInc());
                  }else{
                     o.setSpeedX(0);
                     o.setSpeedXInc(0);
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
             if(x + w + o.getFullSpeedX() >= right * s){
                  if(o.getType() != Type.PLAYER){
                     o.setSpeedX(-o.getSpeedX());
                     o.setSpeedXInc(-o.getSpeedXInc());
                  }else{
                     o.setSpeedX(0);
                     o.setSpeedXInc(0);
                  }
                o.setX(right * s - w - 1);
             }
         }
      }
   }

   //if still collision, player collides with corner of block, need to reset position
   public void checkMore(BasicProp o){
        Room r = model.getCurrentRoom();
        for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
            for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
                if(collisionDetect(r.getBlockType(i,j)) && collisionDetectionWithBlock(o, i, j)){
                    float s = Type.BOARD_GRIDSIZE;
                    float y = o.getY(), by = i * s;
                    float  h = o.getHeight();
                   if(y > by && y < by + s){
                        o.setSpeedY(0);
                        o.setY(by + s + 1);
                    }else if(y + h > by && y + h < by + s){
                        o.setSpeedY(0);
                        o.setY(by - h - 1);
                    }
                }
            }
         }
   }

   public Enemy getGhost(){
       return model.getGhost();
   }
   
   /**
   * If player use portal, player's position will be changed
   * according to int[] portal of that portal block
   */
   public void usePortal(Block b){
       Player o = model.getPlayer(); 
       float  s = Type.BOARD_GRIDSIZE;
       int[] portal = b.getPortal(); 
       o.setY(s * portal[0] - 2 * s - 1);
       o.setX(s * portal[1] + 1);
   }
   
   /**
   * If player use portal, player's position will be changed
   * according to int[] portal of that portal block
   */
   public void useCrate(BasicProp o){
      Room r = model.getCurrentRoom();
      for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
          for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
              if(r.getBlockType(i,j) == Type.BLOCK_CRATE && collisionDetectionWithBlock(o, i, j)){
                  println("use crate");
                  r.clearBlock(i,j);
              }
          }
       }
   }
   
   /**
   * set properties of player according to different key passed in
   */
   public void controlPlayer(int keyType){
     Player p = model.getPlayer();
     
     //move left by set speedX
     if(keyType == Type.KEY_LEFT){
        if(mousePressed == false) p.setLeft(true);
        p.setSpeedX(-Type.PLAYER_SPEED_X);
     }
    
     //move right by set speedX
     if(keyType == Type.KEY_RIGHT){
        if(mousePressed == false) p.setLeft(false);
        p.setSpeedX(Type.PLAYER_SPEED_X);
     }
     
     //stop move left/right
     if(keyType == Type.KEY_RELEASED_AD){
        p.setSpeedX(0);
        p.setSpeedXInc(0);
     }
     
     //activate or cancel fly mode
     if(keyType == Type.KEY_F){
       //cancel fly mode
       if(p.getFlyMode()){
          p.setFlyMode(false);
          p.setJump(true);
          p.setFall(true);
       }else{
          p.setFlyMode(true);
          p.setJump(false);
          p.setFall(false);
          p.setSpeedY(0);
       }
       
       if(p.getFlyMode()){
          println("fly mode activated");
       }else{
          println("fly mode cancelled");
       }
     }
     
     //stop move up/down
     if(keyType == Type.KEY_RELEASED_WS){
       if(p.getFlyMode()){
          p.setSpeedY(0);
       }else{
          p.setSpeedXInc(0);
       }
     }
     
     //not in fly mode
     if(keyType == Type.KEY_SPACE && !p.getFlyMode()){
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
     
     // W - speed up or move upward
     if(keyType == Type.KEY_UP){
       //in fly mode, move upward
       if(p.getFlyMode()){
          p.setSpeedY(-Type.PLAYER_SPEED_Y/2);
       }
       //not fly, speed up
       else{
         if(p.getLeft() && p.getSpeedX() != 0){
             p.setSpeedXInc(-Type.PLAYER_SPEED_X * 1/3);
         }else if(p.getSpeedX() != 0){
             p.setSpeedXInc(Type.PLAYER_SPEED_X * 1/3);
         }
       }
     }
     
     
      // S - slow down or move upward
      if(keyType == Type.KEY_DOWN){
        //in fly mode, move down
        if(p.getFlyMode()){
           p.setSpeedY(Type.PLAYER_SPEED_Y/2);
        }
        // not fly, slow down
       else{
         if(p.getLeft() && p.getSpeedX() != 0){
             p.setSpeedXInc(Type.PLAYER_SPEED_X * 2/3);
         }else if(p.getSpeedX() != 0){
             p.setSpeedXInc(-Type.PLAYER_SPEED_X * 2/3);
         }
       }
    }

     
     // E - use to interact with props
     if(keyType == Type.KEY_E){
       if(p.getOnPortal()){
          p.setTransported(false);
       }
       // interact with items
       println("E");
       useCrate(p);
       
     }
   }
   
   /**
   * Add a bullet to ArrayList<Bullet> in current room
   */
   public void shotBullet(){
      Player p = model.getPlayer();
      if(mouseX < p.getX() + p.getWidth()/2){
        p.setLeft(true);
      }else{
        p.setLeft(false);
      }
      if(bulletTimer < Type.BULLET_CD){
         bulletTimer++;
         return;
      }else{
         bulletTimer = 0;
      }
      Room r = model.getCurrentRoom();
      float bx = p.getX() + p.getWidth()/2;
      float by = p.getY()+ p.getHeight()/2;
      float bSpeedX = mouseX < bx ? -Type.SPEED_BULLET : Type.SPEED_BULLET;
      float bSpeedY = abs(bSpeedX) * (abs(by - mouseY) / abs(bx - mouseX));
      if(mouseY < by){
        bSpeedY = - bSpeedY;
      }
      Bullet b = new Bullet(bx, by, bSpeedX, bSpeedY);
      r.getBullets().add(b);
   }
   
   public void resetBulletTimer(){
      this.bulletTimer = Type.BULLET_CD;
   }

}
