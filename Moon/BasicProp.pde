/**
* @author imyuanxiao
* Basic properties and methods for subclasses
* Next stage: add HP, DP here.
*/
class BasicProp{
  //type = block type, value = score
  private int id, type, value;
  //weight, height
  private int w, h;
  private float fallDistance;
  //speedXIncrement - to speed up or slow down speed
  private float x, y, speedX, speedY, speedXInc,speedYInc;
  private int direction;
  private PImage img;
  // transported - have used portal, left = direction is left, onPortal = player is on Portal block
  // throughDown - When S and Space are pressed together, player can through some blocks such as bounce
  private boolean fall, jump, transported, highJump, left, onPortal, throughDown;
  private boolean flyMode;
  
  //if isAlive is false, play death gif and delete this enemy, this need a timer to play the gif and then remove enemy
  //if isAlive is false, enemy won't cause damage to player
  //if isAlive is false, enemy may drop some items?
  //if isAttacked is true, add red tint() to PImage, this need a timer to keep this status for some frame
  //if isInvincible is true, this object won't get hurt
  //more boolean attributes and methods to be added...
  private boolean isAlive,  isAttacked,  isInvincible;
  
  private ArrayList<PImage[]> gifsImgs;
  private float[] gifsImgsCount;
  
  //hp, damage
  private float hp, dp;
  
  //during dpCd, player won't get damage again.
  private int dpCd, dpTimer;
  
  BasicProp(){
    this.fall = true;
    this.jump = false;
    this.transported = false;
    this.onPortal = false;
    this.highJump = false;
  }
  
  public void setId(int id){
      this.id = id;
  }
  
  public int getId(){
      return this.id;
  }
  
   public void setValue(int value){
      this.value = value;
   }
   
   public int getValue(){
      return this.value;
   }
  
  public void setHp(float num){
      this.hp = num;
  }
  
  public float getHp(){
      return this.hp;
  }
  

   public void setDp(float num){
      this.dp = num;
  }
  
  public float getDp(){
      return this.dp;
  }
  
  public void setType(int type){
      this.type = type;
  }
  
  public int getType(){
      return this.type;
  }
  
  public void setSpeedX(float speed){
      this.speedX = speed;
  }
  
  public float getSpeedX(){
      return this.speedX;
  }
  
  public void setSpeedXInc(float speed){
      this.speedXInc = speed;
  }
  
  public float getSpeedXInc(){
      return this.speedXInc;
  }
  
    
  public void setSpeedYInc(float speed){
      this.speedYInc = speed;
  }
  
  public float getSpeedYInc(){
      return this.speedYInc;
  }
  
  public float getFullSpeedX(){
      return this.speedX + this.speedXInc;
  }
  
  public float getFullSpeedY(){
      return this.speedY + this.speedYInc;
  }
  
  public void setSpeedY(float speed){
      this.speedY = speed;
  }
  
  public float getSpeedY(){
      return this.speedY;
  }
  
  public void direction(int direction){
      this.direction = direction;
  }
  
  public int direction(){
      return this.direction;
  }
  
  public void setX(float x){
      this.x = x;
  }
  
  public float getX(){
      return this.x;
  }
  
  public void setY(float y){
      this.y = y;
  }
  
  public float getY(){
      return this.y;
  }
  
  public void setWidth(int size){
      this.w = size;
  }
  
  public int getWidth(){
      return this.w;
  }
  
  public void setHeight(int size){
      this.h = size;
  }
  
  public int getHeight(){
      return this.h;
  }
  
  public void setFallDistance(float dis){
      this.fallDistance = dis;
  }
  
  public float getFallDistance(){
      return this.fallDistance;
  }  
  public void setImg(PImage img){
      this.img = img;
  }
  
  public PImage getImg(){
      return this.img;
  }
  
  
  public void setFall(boolean flag){
      this.fall = flag;
  }
  
  public boolean getFall(){
      return this.fall;
  }
  
  public void setTransported(boolean flag){
      this.transported = flag;
  }
  
  public boolean getTransported(){
      return this.transported;
  }
  
  public void setOnPortal(boolean flag){
      this.onPortal = flag;
  }
  
  public boolean getOnPortal(){
      return this.onPortal;
  }
  
  public void setJump(boolean flag){
      this.jump = flag;
  }
  
  public boolean getJump(){
      return this.jump;
  }
 
  public void setThroughDown(boolean flag){
      this.throughDown = flag;
  }
  
  public boolean getThroughDown(){
      return this.throughDown;
  }
  
  public boolean getHighJump(){
    return this.highJump;
  }
  
  public void setHighJump(boolean flag){
    this.highJump = flag;
  }
  
    public void setLeft(boolean flag){
     this.left = flag;
  }
  
  public boolean getLeft(){
     return left;
  }
  
     
   public void setDpCd(int cd){
     this.dpCd = cd;
   }
   
   //private int getDpCd(){
   //  return this.dpCd;
   //}
  
   //private void setDpTimer(int cd){
   //  this.dpTimer = cd;
   //}
   
   //private int getDpTimer(){
   //  return this.dpTimer;
   //}
  
  public void attacked(float dp){
    if(this.type == Type.PLAYER){
      if(this.dpTimer == 0){
        if(this.hp > 0){
            this.hp -= dp;
        }
        playerHurt.play(2);
        println("Damage caused by enemy:" + dp);
        dpTimer++;
      } else{
        this.dpTimer ++;
        dpTimer %= this.dpCd;
      }
    }else{
        if(this.hp > 0){
            this.hp -= dp;
        }
        enemyHurt.play(2);
        println("Damage caused by player:" + dp);
    }
  }
  
  /**
  * In each frame, player's position depends on x + speedX and y + speedY
  */
  public void move(){
     this.x += this.speedX + this.speedXInc;
     if(this.flyMode){
         this.y += this.speedY;
     }else{
         if(this.jump){
            this.y += this.speedY;
            if(speedY < Type.PLAYER_SPEED_Y) this.speedY += Type.PLAYER_SPEED_INCREMENT;
         }
         if(this.speedY == 0){
           this.fallDistance = 0;
         }
         //this.fallDistance += speedY;
         //if(this.fallDistance > 250){
         //  println("Enemy falling, no damage");
         //  this.fallDistance = 0;
         //}
     }
  }
  
  public void move(float px, float py){
     this.x = px;
     this.y = py;
  };
  
  public void jump(){};
  
  public boolean getFlyMode(){
      return this.flyMode;
  }
  
  public void setFlyMode(boolean flag){
      this.flyMode = flag;
  }

  public void addGifsImgs(PImage[]... gifs){
    if(this.gifsImgs == null) this.gifsImgs = new ArrayList();
    int cnt = 0;
    for(PImage[] gif : gifs){
       cnt++;
      for(int i = 0; i < gif.length; i++){
          gif[i].resize(this.w, this.h);
       }
       this.gifsImgs.add(gif);
    }
    this.gifsImgsCount = new float[cnt];
  }
  
  public ArrayList<PImage[]> getGifsImgs(){
    return this.gifsImgs;
  }
  
  //public void setGifsImgsCount(int i){
  //  this.gifsImgsCount = new float[i];
  //}
  
  public float[] getGifsImgsCount(){
    return this.gifsImgsCount;
  }
  
  public void display(int i){
     //PImage[] imgs = gifsImgs.get(i);
     //image(imgs[(int)gifsImgsCount[i]], this.x, this.y);
     //this.gifsImgsCount[i] = (this.gifsImgsCount[i]+Type.GIF_PLAY_SPEED) % (float)imgs.length;
  }
  
}
