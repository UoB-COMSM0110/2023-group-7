Controller controller;
View view;

IntList pkeys = new IntList(); 

static abstract class Type {
  
  static final int BOARD_MAX_HEIGHT = 20;
  static final int BOARD_MAX_WIDTH = 29;
  static final int BOARD_GRIDSIZE = 30;
  
  static final int KEY_LEFT = 37;
  static final int KEY_UP = 38;
  static final int KEY_RIGHT = 39;
  static final int KEY_DOWN = 40;
  static final int KEY_SPACE = 32;
  static final int KEY_RELEASED = 0;

  static final int KEY_F_SHOT = 102;

  static final int TO_LEFT = 2;
  static final int TO_UP = 0;
  static final int TO_RIGHT = 3;
  static final int TO_DOWN = 1;
  static final int NO_ROOM = -1;

  
  static final int ROOM_START = 0;
  static final int ROOM_UP = 1;
  static final int ROOM_DOWN = 2;
  static final int ROOM_LR = 3;
  
  static final int ENEMY_GHOST = 0;
  static final int ENEMY_WORM = 1;
  static final int ENEMY_GUNNER = 2;
  
  static final int BLOCK_EMPTY = 0;
  static final int BLOCK_WALL = 1;
  static final int BLOCK_GOLD = 2;
  static final int BLOCK_BOUNCE = 3;
  static final int BLOCK_PORTAL = 4;

  static final float SPEED_INCREMENT = 0.5;
  
  static final int PLAYER = 100;
  static final float PLAYER_SPEED_X = 5;
  static final float PLAYER_SPEED_Y = 10;


}


void setup(){
    size(870,600);
    Model model = new Model();
    model.addPlayer(new Player(width/3, height/2, Type.BOARD_GRIDSIZE - 5, Type.BOARD_GRIDSIZE * 2 - 10, "imgs/player.png"));
    controller = new Controller(model);
    view = new View(model);
}

void draw(){
  
    keyListener();
    /* change data in each frame */
    controller.display();
    /* draw everything in each frame */
    view.paint();
  
}

public void keyListener(){
    if(pkeys.size()== 0) return;
    for(int i=pkeys.size()-1; i>=0; i--){
      if(pkeys.get(i) == Type.KEY_RIGHT || pkeys.get(i) == Type.KEY_LEFT || pkeys.get(i) == Type.KEY_SPACE){
        controller.controlPlayer(pkeys.get(i));
      }
      if(pkeys.get(i) == Type.KEY_F_SHOT){
         controller.shotBullet();
      }
    }

}

public void keyPressed(){

    if(!pkeys.hasValue(int(key))) {
      if(keyCode == LEFT) pkeys.append(Type.KEY_LEFT);
      else if(keyCode == UP) pkeys.append(Type.KEY_UP);
      else if(keyCode == RIGHT) pkeys.append(Type.KEY_RIGHT);
      else if(keyCode == DOWN) pkeys.append(Type.KEY_DOWN);
      else pkeys.append(int(key));
    }
}

public void keyReleased(){
    
    for(int i=pkeys.size()-1; i>=0; i--){
      if((keyCode == LEFT && pkeys.get(i) == Type.KEY_LEFT )
      || (keyCode == UP && pkeys.get(i) == Type.KEY_UP)
      || (keyCode == RIGHT && pkeys.get(i) == Type.KEY_RIGHT)
      || (keyCode == DOWN && pkeys.get(i) == Type.KEY_DOWN)
      ||  pkeys.get(i) == int(key)){
          pkeys.remove(i); 
      }
    }
    
    if(keyCode == RIGHT || keyCode == LEFT){
      controller.controlPlayer(Type.KEY_RELEASED);
    }
    
    if(keyCode == UP){
      controller.controlPlayer(Type.KEY_UP);
    }
    
}
