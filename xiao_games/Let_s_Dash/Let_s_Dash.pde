import ddf.minim.*;
Player p;
Ground g;
BgPicture bp;

float gx_CORNER, gy_CORNER;//player_x, player_y, ground_x,  ground_y
float offset_y;
boolean home_page, map_select, score_panel;
DrawBlocks dbs;
Map map;
Minim minim;
AudioPlayer audio_player;

public static final int NO_CRASH = 0;
public static final int CRASH_SPINE = 1;
public static final int CRASH_BLOCK_UP = 2;
public static final int CRASH_BLOCK_LEFT = 3;
  
void setup() {
  p = new Player(width*3/8, height*0.7, height/12, width/120,  "player/player1.png");
  gx_CORNER = 0;//global ground x, 
  gy_CORNER = p.born_y + p.size/2;//global ground y, reference line to all blocks
  offset_y = 0;
  fullScreen();
  //size(800,400);
  //Player(float x, float y, float size,float speed, String img_path)
  map = new Map();
  dbs = new DrawBlocks(); //<>//
  dbs.loadMapData(1);
  bp = new BgPicture("img/bg_picture1.png");
  g = new Ground("img/ground.png");
  minim = new Minim(this);
  audio_player = minim.loadFile("music/Stereo_Madness.mp3");
  audio_player.play();
}

void showTime(){
  fill(255);
  textSize(50);
  text(dbs.start_time,50,50);
  noFill();
}

void draw() {
  frameRate(60);
  if(p.alive){
    player();
  }else{
    gameOver();
  }
  showTime(); //<>//
}

void gameOver(){
    textSize(128);
    text("Game over!", 40, 120); 
}
void selectMap(){
   
}

void homePage(){
   
}

void player(){
      bp.drawBpPicture();
      g.drawGround();
      dbs.start_time++;
      dbs.run();
      p.display();
}
