/**
* @author imyuanxiao
* Get and change data from model. Most of functions related to real-time processing are here.
* Collision detections and player controls are here.
*/
public class Controller{
   Model model;
   private int bulletTimer;
   
   public Controller(Model mod){
      this.model = mod;
      this.bulletTimer = Type.BULLET_CD_SHORT;
   };
   
   /**
   * Includes all methods to run in each frame
   */
   public void display(){
      
      //only work when game starts
      if(model.getGameStart()){
          changeRoomAndPlayerPos();
          checkAllAround();
          model.getPlayer().move();
          //enemies move here
          model.enemiesMove();
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
         
         model.addEnemiesToRoom(newRoom);
          model.addItemsToRoom(newRoom);

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
         
         model.addEnemiesToRoom(newRoom);
                  model.addItemsToRoom(newRoom);

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
         
         model.addEnemiesToRoom(newRoom);
         model.addItemsToRoom(newRoom);
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
         
         model.addEnemiesToRoom(newRoom);
         model.addItemsToRoom(newRoom);

      }
   }
     
   /**
   * Collision detection between two BasicProp obj
   * Only useful when two objects are rect
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
   * Collision detection between BasicProp obj and line
   * Mainly used for objects and special bullet such as laser
   * a = enemy, b = bullet
   */
   public boolean collisionDetectionLine(BasicProp a, BasicProp b){
       //1. get intersection of rectangle diagonal and line
       float ax1 = a.getX(), ax2 = a.getX() + a.getWidth();
       float ay1 = a.getY(), ay2 = a.getY() + a.getHeight();
       //y = k(x-x0) + y0 
       //1.1 line1:/ 
       float ak1 = (ay1 - ay2) / (ax2 - ax1);
       float ab1 = ay2 - ax1 * ak1;
       
       //1.2 line2: \
       float ak2 = (ay2 - ay1) / (ax2 - ax1);
       float ab2 = ay1 - ax1 * ak2;
       
       //1.2 bullet line:
       float bx1 = b.getX(), bx2 = b.getX() + b.getSpeedX();
       float by1 = b.getY(), by2 = b.getY() + b.getSpeedY();
       float bk = (by1 - by2) / (bx2 - bx1);
       float bb = by2 - bx1 * bk;
       
        //2. Determine whether these points is inside rectangle
        
        //2.1 intersection between line1 and bullet line
       if(ak1 != bk){
          
          //2.1.1 Whether this points is inside rectangle
          //if( ){
          //   return true;   
          //}
       }
       
        //2.2 intersection between line1 and bullet line
       if(ak2 != bk){
          
          //2.2.1 Whether this points is inside rectangle
          //if( ){
          //   return true;   
          //}
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
   //if return false, player can through these type of blocks
   //when player, throughDown = p.getThroughDown(), others, checkDown = false && throughDown = true
   public boolean blockCannotThrough(int type, boolean checkDown, BasicProp o){
     if(type == Type.BLOCK_EMPTY || type == Type.BLOCK_CRATE || type == Type.BLOCK_SPIKE){
       return false;
     }
     
     
     if(type == Type.BLOCK_PLATFORM){
        // o == null - o is bullet or o is fly, can through
        if(o == null || o.getFlyMode()){
           return false;
        }
        if(checkDown && !o.getThroughDown()){
           return true;
        }else{
           return false;
        }
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
            p.attacked(e.getDp());
            //println("Damage caused by enemy: " + e.getDp());
         }
         for(int j = 0; j < bullets.size(); j++){
             Bullet b = bullets.get(j);
             //if b out of board, remove
             if(b.getY() > height || b.getY() < 0 || b.getX() > width || b.getX() < 0){
                bullets.remove(j--);
             }
             
             //check bullets and enemies
             else if(collisionDetectionTwoObj(b,e)){
                e.attacked(b.getDp());
                if(e.getHp() <= 0){
                   enemies.remove(i--);
                }
                bullets.remove(j--);
                break;
             }
         }
      }
      
      //collision detection between bullets and blocks
       //if b crash blocks, remove
         for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
            for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
                if(blockCannotThrough(r.getBlockType(i,j), false, null)){
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
      
      int L = (int)(x/s) ;
      int R = (int)((x+w)/s);
      //all blocks above are !blockCannotThrough(), o can through
      boolean canThrough = true;
      for(int i = L; i <= R && upper >= 0; i++){
         if(blockCannotThrough(r.getBlockType(upper,i),false,o) && (y + o.getFullSpeedY() <= upper * s + s)){
            canThrough = false;
         }
      }
      if(!canThrough){
          o.setSpeedY(0);
          o.setSpeedYInc(0);
          o.setFall(false);
          o.setY(upper * s + s + 1);
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
      
      int L = (int)(x/s) ;
      int R = (int)((x+w)/s);
      boolean canFall = true, canHighJump = false, canUsePortal = false;
      int portalPos = 0;
      //all blocks below are !blockCannotThrough(), o can through
      for(int i = L; i <= R && below < Type.BOARD_MAX_HEIGHT; i++){
         int bType = r.getBlockType(below,i);
         
         //for all obj
         if(blockCannotThrough(bType,true,o)){
             canFall = false;
         }
         
         //for player
         if(o.getType() == Type.PLAYER){
             //portal
             if(bType == Type.BLOCK_PORTAL){
                 canUsePortal = true;
                 portalPos = i;
             }
             
             //bounce
             o.setHighJump(false);
             if(bType == Type.BLOCK_BOUNCE){
                 canHighJump = true;
             }
             
             //spike - basic implemenation for now as we don't yet have a death mechanic
             if(o.getFall() && (bType == Type.BLOCK_SPIKE)){
               //o.attacked(5);
               System.out.println("Damage caused by spikes");
             }
         }
         
      }
      
       //if enemies, change direction
       if(o.getType() != Type.PLAYER){
           //make enemy move to right
           if(L >= 0 && o.getLeft() && !blockCannotThrough(r.getBlockType(below,L), false, null)){
              o.setLeft(false);
              o.setSpeedX(abs(o.getSpeedX()));
              o.setX(L * s + s + 1);
           }
           //make enemy move to left
           if(R < 29 && !o.getLeft() && !blockCannotThrough(r.getBlockType(below,R), false, null)){
               o.setLeft(true);
               o.setSpeedX(-abs(o.getSpeedX()));
               o.setX(R * s - w - 1);
           }
       }
      
      
      if(!canFall && (y + h + o.getFullSpeedY()>= below * s)){
            o.setFall(false);
            o.setJump(false);
            o.setSpeedY(0);
            o.setSpeedYInc(0);
            o.setY(below * s - h - 1);
       }else{
             o.setFall(true);
             o.setJump(true);
       }
       
       if(canHighJump){
           o.setHighJump(true);
           //System.out.println("High jump");
       }
       
       if(canUsePortal){
           o.setOnPortal(true);
           if(!o.getTransported()){
               Block b = r.getBlockByPos(below , portalPos);
               usePortal(b);
               o.setTransported(true);
               return;
           }
       }else{
             o.setOnPortal(false);
       }
         
   }
     
    public void checkLeft(BasicProp o){
      Room r = model.getCurrentRoom();
      float x = o.getX(), y = o.getY();
      float h = o.getHeight();
      float s = Type.BOARD_GRIDSIZE;
      int left = (int)(x/s) - 1;
      int U = (int)(y/s) ;
      int D = (int)((y+h)/s);
      
      boolean canMoveForward = true;
      for(int i = U; i <= D && left >= 0; i++){
            if(i < 0 || i >= Type.BOARD_MAX_HEIGHT){
               canMoveForward = false;
               break;
            }
            int bType = r.getBlockType(i,left);
            if(o.getType() != Type.PLAYER){
              if(blockCannotThrough(bType,false,null) && (x + o.getFullSpeedX() * 10 <= left * s + s)){
                 canMoveForward = false;
              }
            }else{
                if(blockCannotThrough(bType,false,null) && (x + o.getFullSpeedX() <= left * s + s)){
                   canMoveForward = false;
                }
            }
      }
      
     if(!canMoveForward){
        if(o.getType() != Type.PLAYER){
           o.setLeft(false);
           o.setSpeedX(-o.getSpeedX());
           o.setSpeedXInc(-o.getSpeedXInc());
        }else{
           o.setSpeedX(0);
           o.setSpeedXInc(0);
        }
        o.setX(left * s + s + 1);
      }
   }
   
   public void checkRight(BasicProp o){
      Room r = model.getCurrentRoom();
      float x = o.getX(), y = o.getY();
      float w = o.getWidth(), h = o.getHeight();
      float s = Type.BOARD_GRIDSIZE;
      int right = (int)((x + w)/s) + 1;
      int U = (int)(y/s) ;
      int D = (int)((y+h)/s);
      boolean canMoveForward = true;
      for(int i = U; i <= D && right < Type.BOARD_MAX_WIDTH; i++){
            if(i < 0 || i >= Type.BOARD_MAX_HEIGHT){
               canMoveForward = false;
               break;
            }
            int bType = r.getBlockType(i,right);
            if(o.getType() != Type.PLAYER){
              if(blockCannotThrough(bType,false,null) && (x + w + o.getFullSpeedX()*10 >= right * s)){
                  canMoveForward = false;
              }
            }else{
              if(blockCannotThrough(bType,false,null) && (x + w + o.getFullSpeedX() >= right * s)){
                  canMoveForward = false;
              }
            }
      }
      
      if(!canMoveForward){
          if(o.getType() != Type.PLAYER){
             o.setLeft(true);
             o.setSpeedX(-o.getSpeedX());
             o.setSpeedXInc(-o.getSpeedXInc());
          }else{
             o.setSpeedX(0);
             o.setSpeedXInc(0);
          }
          o.setX(right * s - w - 1);
      }
      
   }

   //if still collision, player collides with corner of block, need to reset position
   public void checkMore(BasicProp o){
        Room r = model.getCurrentRoom();
        for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
            for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
                if(blockCannotThrough(r.getBlockType(i,j) , false, model.getPlayer()) && collisionDetectionWithBlock(o, i, j)){
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
   public void interact(BasicProp o){
      Room r = model.getCurrentRoom();
      
       //pick up items
      ArrayList<Item> items = r.getItems();
      for(int i = 0; i < items.size(); i++){
        Item t = items.get(i);
        if(collisionDetectionTwoObj(o, t)){
            Player p = model.getPlayer();
            println("pick up item");
            items.remove(i);
            //change weapon
            if(t.getCategory() == Type.ITEM_WEAPON){
               Item tmp = p.getWeapon();
               tmp.setPos(t.getPos());
               items.add(tmp);
            }
            p.addItem(t);
            this.bulletTimer = p.getWeapon().getBulletCd();
            break;
         }
     }
      
      //open crate
      for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
          for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
              if(r.getBlockType(i,j) == Type.BLOCK_CRATE && collisionDetectionWithBlock(o, i, j)){
                  println("open crate");
                  //should add something to player, like props or weapons, or golds(scores);
                  r.addItem(model.newItem(new int[]{i, j}));
                  r.setBlockType(i,j, Type.BLOCK_EMPTY);
              }
          }
       }
   }
  
   
   public void useItemByPlayer(){
     model.useItemByPlayer();
   }
   
   //public b interactiveThings(BasicProp o){
   //  //
     
   //}
   
   
   /**
   * set properties of player according to different key passed in
   */
   public void controlPlayer(int keyType){
     Player p = model.getPlayer();
     
     //move left by set speedX
     if(keyType == Type.KEY_A){
        if(mousePressed == false) p.setLeft(true);
        p.setSpeedX(-Type.PLAYER_SPEED_X);
     }
    
     //move right by set speedX
     if(keyType == Type.KEY_D){
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
     
     if(keyType == Type.KEY_S_SPACE){
        p.setThroughDown(true);
        return;
     }else{
        p.setThroughDown(false);
     }
     //not in fly mode
     if(keyType == Type.KEY_SPACE && !p.getFlyMode()){
        if(p.getJump()){
          return;
        };
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
     if(keyType == Type.KEY_W){
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
      if(keyType == Type.KEY_S){
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
       interact(p);
       
     }
     
     if(keyType == Type.KEY_Q){
        p.changeItem();
     }
     
     if(keyType == Type.MOUSE_RIGHT){
        useItemByPlayer();
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
      
      //bulletTimer - CD of shot
      if(bulletTimer < p.getWeapon().getBulletCd() - p.getBulletCd()){
         bulletTimer++;
         return;
      }else{
         bulletTimer = 0;
      }
      
      Room r = model.getCurrentRoom();
      float bx = p.getX() + p.getWidth()/2;
      float by = p.getY()+ p.getHeight()/2;
      p.getWeapon().shot(r, bx, by);

   }
   
   
   public void resetBulletCd(){
      Player p = model.getPlayer();
      this.bulletTimer = p.getWeapon().getBulletCd() - p.getBulletCd();
   }
   
   /**
   *
   */
   public void setMenuHomePage(boolean flag){
       model.setMenuHomePage(flag);
   }
   
   public boolean getMenuHomePage(){
       return model.getMenuHomePage();
   }
   
   public void setMenuControl(boolean flag){
       model.setMenuControl(flag);
   }
   
   public boolean getMenuControl(){
       return model.getMenuControl();
   }
   
   public void setGameStart(boolean flag){
       model.setGameStart(flag);
   }
   
   public boolean getGameStart(){
       return model.getGameStart();
   }
   
   public void setGamePause(boolean flag){
       model.setGamePause(flag);
   }
   
   public boolean getGamePause(){
       return model.getGamePause();
   }
   
   public void setGameOver(boolean flag){
       model.setGameOver(flag);
   }
   
   public boolean getGameOver(){
       return model.getGameOver();
   }
   
   public void setGlobalList(boolean flag){
       model.setGlobalList(flag);
   }
   
   public boolean getGlobalList(){
       return model.getGlobalList();
   }
   

}
