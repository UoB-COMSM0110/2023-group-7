import ddf.minim.*;
Player p;
Ground g;
BgPicture bp;
float px_CENTER, py_CENTER, gx_CORNER, gy_CORNER;//player_x, player_y, ground_x,  ground_y
float px_CORNER, py_CORNER;//player_x + offset_x
float offset_px, offset_py, offset_y;//global variables
float p_speed, p_size;//player speed and size
moreFunction mf;
Minim minim;
AudioPlayer player;

private static final int NO_CRASH = 0;
private static final int CRASH_SPINE = 1;
private static final int CRASH_BLOCK_UP = 2;
private static final int CRASH_BLOCK_LEFT = 3;

void setup() {
  px_CENTER = width*3/8;//global player x(center)
  py_CENTER = height*2/3;//global player y(center)
  gx_CORNER = 0;//global ground x, 
  gy_CORNER = height*2/3 + height/22;//global ground y, reference line to all blocks
  p_size = height/11;
  p_speed = 10;
  offset_px = height/22;
  offset_py = height/22;
  offset_y = 0;
  px_CORNER = px_CENTER + offset_px;
  py_CORNER = py_CENTER + offset_py;
  fullScreen();
  //size(500,300);
  mf = new moreFunction();
  mf.init();
  p = new Player(px_CENTER, py_CENTER, "player/player1.png");
  bp = new BgPicture("img/bg_picture1.png");
  g = new Ground("img/ground.png");
  minim = new Minim(this);
  player = minim.loadFile("music/Stereo_Madness.mp3");
  player.play();
}

void showFrame(){
  fill(255);
  textSize(20);
  text(frameCount,50,50);
  noFill();
}

void draw() {
  frameRate(60);
  bp.drawBpPicture();
  g.drawGround();
  int flag = mf.run(); //<>//
  if(flag == NO_CRASH || flag == CRASH_BLOCK_UP){
    if(mousePressed && !p.once){
       p.half_jump = 200;
       p.in_air = true;
       p.once = true;
    }
    if(p.in_air){
       p.jump();
    }else{
       p.drawPlayer(px_CENTER, py_CENTER);
    }
  }else{
     mf.gameOver();
  }
  showFrame();
}
