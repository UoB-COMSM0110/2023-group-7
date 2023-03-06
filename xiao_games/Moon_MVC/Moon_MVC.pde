//need install: tools > manage tools> libraries > GifAnimation
import gifAnimation.*;

Controller controller;
View view;

IntList pkeys = new IntList(); 

/**
* Avoid using magic number
*/
static abstract class Type {
  
  static final int BOARD_MAX_HEIGHT = 20;
  static final int BOARD_MAX_WIDTH = 29;
  static final int BOARD_GRIDSIZE = 30;

  //KEY_LEFT = A
  static final int KEY_LEFT = 97;
  //KEY_RIGHT = D
  static final int KEY_RIGHT = 100;
  //KEY_UP = W
  static final int KEY_UP = 119;
  //KEY_DOWN = S
  static final int KEY_DOWN = 115;
  static final int KEY_E = 101;
  static final int KEY_SPACE = 32;
  
  static final int KEY_RELEASED_AD = 1000;
  static final int KEY_RELEASED_WS = 1001;

  //temporarily for activate FlyMode
  static final int KEY_F = 102;

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
  static final int ENEMY_JUMPER = 3;
  
  static final int PLAYER = 4;

  static final int BLOCK_EMPTY = 0;
  static final int BLOCK_WALL = 1;
  static final int BLOCK_GOLD = 2;
  static final int BLOCK_BOUNCE = 3;
  static final int BLOCK_PORTAL = 4;
  static final int BLOCK_BORDER = 5;
  static final int BLOCK_CRATE = 6;
  static final int BLOCK_SPIKE = 7;
  

  static final float SPEED_INCREMENT = 0.5;
  static final float SPEED_BULLET = 7;
  static final int BULLET_CD = 10;

  
  static final float PLAYER_SPEED_X = 5;
  
  static final float PLAYER_SPEED_Y = 10;


}

/**
* Initialize all project, run once
*/
void setup(){
    size(870,600);
    Model model = new Model();
    model.setGifs(loadGifs());
    model.addPlayer(new Player(width/3, height/2, Type.BOARD_GRIDSIZE - 5, Type.BOARD_GRIDSIZE * 2 - 10));
    controller = new Controller(model);
    view = new View(model);
}

/**
* Code inside will run by order in each frame
*/
void draw(){
    
    mouseListener();
    keyListener();
    
    /* change data in each frame */
    controller.display();
    
    /* draw everything in each frame */
    view.paint();
  
}

/**
* Load all gifs
*/
public ArrayList<Gif> loadGifs(){

     ArrayList<Gif> gifs = new ArrayList();
     Gif ghost = new Gif(this, "imgs/enemy/ghost.gif");
     ghost.loop();
     gifs.add(ghost);
     
     Gif wormLeft = new Gif(this, "imgs/enemy/slime_left.gif");
     wormLeft.loop();
     gifs.add(wormLeft);
     Gif wormRight = new Gif(this, "imgs/enemy/slime_right.gif");
     wormRight.loop();
     gifs.add(wormRight);
     
     Gif gunnerLeft = new Gif(this, "imgs/enemy/gunner_left.gif");
     gunnerLeft.loop();
     gifs.add(gunnerLeft);
     Gif gunnerRight = new Gif(this, "imgs/enemy/gunner_right.gif");
     gunnerRight.loop();
     gifs.add(gunnerRight);
     
     Gif jumperLeft = new Gif(this, "imgs/enemy/jumper_left.gif");
     jumperLeft.loop();
     gifs.add(jumperLeft);
     Gif jumperRight = new Gif(this, "imgs/enemy/jumper_right.gif");
     jumperRight.loop();
     gifs.add(jumperRight);
     
     Gif playerLeft = new Gif(this, "imgs/player/player_left.gif");
     playerLeft.loop();
     gifs.add(playerLeft);
     Gif playerRight = new Gif(this, "imgs/player/player_right.gif");
     playerRight.loop();
     gifs.add(playerRight);
     
     return gifs;
}

/**
* Processing can not record two keys at one time,
* so we have to use a list to record keys
*/
public void keyListener(){
    if(pkeys.size()== 0) return;
    for(int i=pkeys.size()-1; i>=0; i--){
      if(validKey(pkeys.get(i))){
        controller.controlPlayer(pkeys.get(i));
      }
    }
}

public boolean validKey(int value){
  if(value == Type.KEY_RIGHT 
  || value == Type.KEY_LEFT 
  || value == Type.KEY_SPACE
  || value == Type.KEY_UP
  || value == Type.KEY_DOWN
  ){
  return true;
  }
  return false;
}


public void keyPressed(){

    //use WASD to move
    if(!pkeys.hasValue(int(key))) {
      pkeys.append(int(key));
    }
    println(int(key));
    
}

public void keyReleased(){

    //use WASD to move
    for(int i=pkeys.size()-1; i>=0; i--){
      if(pkeys.get(i) == int(key)){
          pkeys.remove(i); 
      }
    }
    
    if(key == 'a' || key == 'd'){
      controller.controlPlayer(Type.KEY_RELEASED_AD);
    }
    
    if(key == 'w' || key == 's'){
      controller.controlPlayer(Type.KEY_RELEASED_WS);
    }
    
    if(key == 'f'){
      controller.controlPlayer(Type.KEY_F);
    }
    
    if(key == 'e'){
      controller.controlPlayer(Type.KEY_E);
    }
}

public void mouseListener(){
    if(mousePressed == true && mouseButton == LEFT){
       controller.shotBullet();
    }
}

public void mouseReleased(){
  
}

public void mousePressed(){
  
}
