Controller controller;
View view;

static abstract class Type {
  
  static final int KEY_UP = 0;
  static final int KEY_DOWN = 1;
  static final int KEY_LEFT = 2;
  static final int KEY_RIGHT = 3;
  
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
  
}


void setup(){
    size(900,600);
    int gridSize = height/20;
    Model model = new Model();
    model.setGridSize(gridSize);
    model.addPlayer(new Player(width/2, height/2, gridSize, gridSize * 2, gridSize/3, "imgs/player.png"));
    controller = new Controller(model);
    view = new View(model);
}

void draw(){
    /* change data in each frame */
    controller.display();
    /* draw everything in each frame */
    view.paint();
}

public void keyPressed(){
  if(keyCode == LEFT){
    controller.movePlayer(Type.KEY_LEFT);
  }
  if(keyCode == RIGHT){
    controller.movePlayer(Type.KEY_RIGHT);
  }
  if(keyCode == UP){
    controller.movePlayer(Type.KEY_UP);
  }
  if(keyCode == DOWN){
    controller.movePlayer(Type.KEY_DOWN);
  }
}
