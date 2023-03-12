//need install: tools > manage tools> libraries > GifAnimation
import gifAnimation.*;

import ddf.minim.*;

Controller controller;
View view;

// Menu
Minim minim;
AudioPlayer bgMusic;
// SoundFile bgMusic;
PImage bgImg;
PImage optionImg;
PImage gameoverImg;

/*
boolean isMusicPlaying = false;
boolean menuHomePage = true;
boolean menuControl = false;
boolean gameStart = false;
boolean gamePause = false;
boolean gameOver = false;
boolean globalList = false;
*/

IntList pkeys = new IntList(); 

/**
* Avoid using magic number
*/
static abstract class Type {
  
  //board - baisc attributes
  static final int BOARD_MAX_HEIGHT = 20;
  static final int BOARD_MAX_WIDTH = 29;
  static final int BOARD_GRIDSIZE = 40;
  static final int BOARD_GRIDSIZE_ADD5 = BOARD_GRIDSIZE + 5;
  static final int BOARD_GRIDSIZE_SUB5 = BOARD_GRIDSIZE - 5;

  static final float GIF_PLAY_SPEED = 0.1;

  //player - baisc attributes
  static final int PLAYER = -1;
  
  static final int PLAYER_DPCD = 50;
  
  static final int PLAYER_JUMP_SPEEDY = BOARD_GRIDSIZE * 2/7;
  static final int PLAYER_HIGH_JUMP_SPEEDY = BOARD_GRIDSIZE * 3/7;
  
  static final float PLAYER_SPEED_INCREMENT = (float)BOARD_GRIDSIZE / 100;
  static final float PLAYER_SPEED_X = BOARD_GRIDSIZE / 8;
  static final float PLAYER_SPEED_Y = BOARD_GRIDSIZE / 4;
  
  //enemy - baisc attributes
  static final float ENEMY_SPEED_X_SLOW = (float)BOARD_GRIDSIZE / 100;
  static final float ENEMY_SPEED_X_NORMAL = (float)BOARD_GRIDSIZE / 80;
  
  //bullet - baisc attributes
  static final int BULLET_SPEED_SLOW = 3;
  static final int BULLET_SPEED_NORMAL = 5;
  static final int BULLET_SPEED_FAST = 10;
  
  static final int BULLET_CD_LONG = 30;
  static final int BULLET_CD_NORMAL = 20;
  static final int BULLET_CD_SHORT = 10;
  
  static final int BULLET_TYPE_CIRCLE = 0;
  static final int BULLET_TYPE_LINE = 1;
  static final int BULLET_TYPE_MINER = 2;


  // gif - animation type
  static final int GIF_RUN_L = 0;
  static final int GIF_RUN_R = 1;
  static final int GIF_KONCKBACK_L = 2;
  static final int GIF_KONCKBACK_R = 3;

  
  
  //mouse
  static final int MOUSE_RIGHT = 10;
  
  //keys - integer of keys
  static final int KEY_A = 97;
  static final int KEY_D = 100;
  static final int KEY_W = 119;
  static final int KEY_S = 115;
  static final int KEY_E = 101;
  static final int KEY_SPACE = 32;
  static final int KEY_RELEASED_AD = 1000;
  static final int KEY_RELEASED_WS = 1001;
  static final int KEY_Q = 113;
  static final int KEY_R = 114;
  //press S and SPACE together, can throught blocks
  static final int KEY_S_SPACE = 200;

  //temporarily for activate FlyMode
  static final int KEY_F = 102;

  //room - indices for room generation
  static final int TO_LEFT = 2;
  static final int TO_UP = 0;
  static final int TO_RIGHT = 3;
  static final int TO_DOWN = 1;
  static final int NO_ROOM = -1;
  static final int ROOM_START = 0;
  static final int ROOM_UP = 1;
  static final int ROOM_DOWN = 2;
  static final int ROOM_LR = 3;
  
  //gifs - get gifs of enemies or player from model by order
  static final int ENEMY_GHOST = 0;
  static final int ENEMY_WORM = 1;
  static final int ENEMY_GUNNER = 2;
  static final int ENEMY_JUMPER = 3;

  //block type
  static final int BLOCK_EMPTY = 0;
  static final int BLOCK_WALL = 1;
  static final int BLOCK_CRYSTAL = 2;
  static final int BLOCK_BOUNCE = 3;
  static final int BLOCK_PORTAL = 4;
  static final int BLOCK_BORDER = 5;
  static final int BLOCK_CRATE = 6;
  static final int BLOCK_SPIKE = 7;
  static final int BLOCK_PLATFORM = 8;
  
  // item type
  // Primary category
  static final int ITEM_WEAPON = 0;
  static final int ITEM_POTION = 1;
  static final int ITEM_CRYSTAL = 2;
  //static final int ITEM_OUTFIT = 3;
  // Secondary category
  // crystal
  static final int CRYSTAL = 0;
  // weapons
  static final int WEAPON_PISTOL= 0;
  static final int WEAPON_SHOTGUN = 1;
  static final int WEAPON_LASER = 2;
  static final int WEAPON_MINER = 3;
  // potions
  static final int POTION_HP = 0;
  static final int POTION_SP = 1;
  
  
}

/**
* Initialize all project, run once
*/
void setup(){
    size(1160,800);
    Model model = new Model();
    model.setGifs(loadGifs());
    ItemFactory t = new ItemFactory();
    Player p = new Player(width/3, height/2, Type.BOARD_GRIDSIZE_SUB5, Type.BOARD_GRIDSIZE_SUB5);
    p.addItem(t.weaponPistol());
    addplayerGifs(p);
    model.addPlayer(p);
    model.setItemFactory(t);
    
    // Menu
    bgImg = loadImage("Data/imgs/background.png");
    optionImg = loadImage("Data/imgs/option.png");
    gameoverImg = loadImage("Data/imgs/gameover.png");
    minim = new Minim(this);
    bgMusic = minim.loadFile("Data/music/bgmusic.mp3");
    
    if (model.getIsMusicPlaying()){
      bgMusic.play();
    }
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

public void addplayerGifs(Player p){
     //Gif playerLeft = new Gif(this, "imgs/player/player_left.gif");
     //playerLeft.loop();
     //Gif playerRight = new Gif(this, "imgs/player/player_right.gif");
     //playerRight.loop();
     
     //p.addGif(playerLeft);
     //p.addGif(playerRight);
     
     PImage[] pRunL = Gif.getPImages(this, "imgs/player/player_left.gif");
     PImage[] pRunR = Gif.getPImages(this, "imgs/player/player_right.gif");

     p.addGifsImgs(pRunL, pRunR);
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
     
     return gifs;
}

/**
* Processing can not record two keys at one time,
* so we have to use a list to record keys
*/
public void keyListener(){
    //only work when game starts
    if(!controller.getGameStart()){
        return;
    }
    if(pkeys.size()== 0) return;
       
    for(int i=pkeys.size()-1; i>=0; i--){
      if(validKey(pkeys.get(i))){
        if(pkeys.hasValue(Type.KEY_S) && pkeys.hasValue(Type.KEY_SPACE)){
          controller.controlPlayer(Type.KEY_S_SPACE);
        }else{
          controller.controlPlayer(pkeys.get(i));
        }
        
      }      
    }
    
}

public boolean validKey(int value){
  if(value == Type.KEY_D 
  || value == Type.KEY_A 
  || value == Type.KEY_SPACE
  || value == Type.KEY_W
  || value == Type.KEY_S
  ){
  return true;
  }
  return false;
}


public void keyPressed(){
  
    //only work when game starts
    if(!controller.getGameStart()){
        return;
    }
    
    //use WASD to move
    if(!pkeys.hasValue(int(key))) {
      pkeys.append(int(key));
    }
    //println(int(key));
    
}

public void keyReleased(){
    //only work when game starts
    if(!controller.getGameStart()){
        return;
    }
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
    
    if(key == 'q'){
      controller.controlPlayer(Type.KEY_Q);
    }
    
    if(key == 'r'){  //change weapon to miner gun
      controller.controlPlayer(Type.KEY_R);
    }
    
}

public void mouseListener(){
  
   //only work when game starts
   if(controller.getGameStart()){
        
        if(mousePressed == true && mouseButton == LEFT){
           controller.shotBullet();
        }
    }

}

public void mouseReleased(){
  
  if(controller.getMenuHomePage()){
    //check mouse position, if in position and released, change booleans in model
    // Clicked on Start
    if (mouseX > 201 && mouseX < 433 && mouseY > 156 && mouseY < 253) {
      controller.setMenuHomePage(false);
      controller.setGameStart(true);
    }
    // Click Option
    if (mouseX > 201 && mouseX < 433 && mouseY > 281 && mouseY < 378) {
      controller.setMenuHomePage(false);
      controller.setMenuControl(true);
    }
    
    // Click history ranking
    
    
    // Click Quit
    if (mouseX > 201 && mouseX < 433 && mouseY > 531 && mouseY < 628) {
      exit();
    }
    
  } else if(controller.getMenuControl()){
     //there should be a return button in this menu
         
    // Switch Music ON/OFF
    if (mouseX > 485 && mouseX < 676 && mouseY > 306 && mouseY < 386) {
      if (controller.getIsMusicPlaying()) {
        bgMusic.pause();
        controller.setIsMusicPlaying(false);
      } else {
        bgMusic.play();
        controller.setIsMusicPlaying(true);
      }
      // isOptionMenuOpen = false;
    }
    
    // Return button
    if (mouseX > 485 && mouseX < 676 && mouseY > 414 && mouseY < 494) {
      controller.setMenuControl(false);
      controller.setMenuHomePage(true);
    }
    
  }
  else if(controller.getGlobalList()){
     //there should be a return button in this menu
  }
  else if(controller.getGamePause()){
      //there should be a restart button in this menu

  }
  else if(controller.getGameOver()){
      //there should be a restart button in this menu
      
      // Restart
      if (mouseX > width/2 - 100 && mouseX < width/2 + 100 + 90 && mouseY > height*3/4-30 && mouseY < height*3/4+30) {
        controller.setGameStart(false);
        controller.setGameOver(true);
      }
  }
  //only work when game starts
  else{
    if(mouseButton == RIGHT){
        controller.resetBulletCd();
    }
    if(mouseButton == RIGHT){
        controller.controlPlayer(Type.MOUSE_RIGHT);
    }
  }

}

public void mousePressed(){
  
}

void stop(){
  bgMusic.close();
  minim.stop();
  
  super.stop();
}
