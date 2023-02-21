Controller controller;
View view;

IntList pkeys = new IntList(); 

static abstract class Type {
  
  static final int KEY_UP = 0;
  static final int KEY_DOWN = 1;
  static final int KEY_LEFT = 2;
  static final int KEY_RIGHT = 3;
  static final int KEY_RELEASED = 4;
  
  
  static final int ROOM_START = 0;
  static final int ROOM_UP = 1;
  static final int ROOM_DOWN = 2;
  static final int ROOM_LR = 3;
  
  static final int ENEMY_GHOST = 0;
  static final int ENEMY_WORM = 1;
  static final int ENEMY_GUNNER = 2;
  
  static final int ITEM_EMPTY = 0;
  static final int ITEM_WALL = 1;
  static final int ITEM_GOLD = 2;
  static final int ITEM_LADDER = 3;
  
  static final int PLAYER = 100;

}


void setup(){
    size(900,600);
    int gridSize = height/20;
    Model model = new Model();
    model.setGridSize(gridSize);
    model.addPlayer(new Player(width/3, height/2, gridSize - 5, gridSize * 2 -10, "imgs/player.png"));
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
      //left = 37, up = 38, right = 39,  down = 40
      if(pkeys.get(i) == 39){
        controller.givePlayerSpeedX(Type.KEY_RIGHT);
      }
      if(pkeys.get(i) == 37){
         controller.givePlayerSpeedX(Type.KEY_LEFT);
      }
      if(pkeys.get(i) == 32){
        controller.givePlayerSpeedX(Type.KEY_UP);
      }
    }

}

public void keyPressed(){
    //left = 37, up = 38, right = 39,  down = 40
    if(!pkeys.hasValue(int(key))) {
      if(keyCode == LEFT) pkeys.append(37);
      else if(keyCode == UP) pkeys.append(38);
      else if(keyCode == RIGHT) pkeys.append(39);
      else if(keyCode == DOWN) pkeys.append(40);
      else pkeys.append(int(key));
    }
}

public void keyReleased(){
    
    for(int i=pkeys.size()-1; i>=0; i--){
      if((keyCode == LEFT && pkeys.get(i) == 37 )
      || (keyCode == UP && pkeys.get(i) == 38)
      || (keyCode == RIGHT && pkeys.get(i) == 39)
      || (keyCode == DOWN && pkeys.get(i) == 40)
      ||  pkeys.get(i) == int(key)){
          pkeys.remove(i); 
      }
    }
    
    if(keyCode == RIGHT || keyCode == LEFT){
      controller.givePlayerSpeedX(Type.KEY_RELEASED);
    }
    
}
