//need install: tools > manage tools> libraries > GifAnimation
import gifAnimation.*;

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
  static final int ENEMY_JUMPER = 3;
  
  static final int PLAYER = 4;

  static final int BLOCK_EMPTY = 0;
  static final int BLOCK_WALL = 1;
  static final int BLOCK_GOLD = 2;
  static final int BLOCK_BOUNCE = 3;
  static final int BLOCK_PORTAL = 4;

  static final float SPEED_INCREMENT = 0.5;
  static final float SPEED_BULLET = 7;

  
  static final float PLAYER_SPEED_X = 5;
  
  static final float PLAYER_SPEED_Y = 10;


}

void setup(){
    size(870,600);
    Model model = new Model();
    model.setGifs(loadGifs());
    model.addPlayer(new Player(width/3, height/2, Type.BOARD_GRIDSIZE - 5, Type.BOARD_GRIDSIZE * 2 - 10, "imgs/player.png"));
    controller = new Controller(model);
    view = new View(model);
}

void draw(){
    //frameRate(20);
    keyListener();
    /* change data in each frame */
    controller.display();
    /* draw everything in each frame */
    view.paint();
  
}

public ArrayList<Gif> loadGifs(){
    //ghost = 0, worm 1 -> 1 2 gunner 2 -> 3 4 jumper 3 -> 5 6 player 7 8
    // left = type * 2 - 1, right = type * 2
    
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

public void keyListener(){
    if(pkeys.size()== 0) return;
    for(int i=pkeys.size()-1; i>=0; i--){
      if(pkeys.get(i) == Type.KEY_RIGHT || pkeys.get(i) == Type.KEY_LEFT || pkeys.get(i) == Type.KEY_SPACE){
        controller.controlPlayer(pkeys.get(i));
      }
      //if(pkeys.get(i) == Type.KEY_F_SHOT){
      //   controller.shotBullet();
      //}
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
    
    if(int(key) == Type.KEY_F_SHOT){
         controller.shotBullet();
    }
    
}
