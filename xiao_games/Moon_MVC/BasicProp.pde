/**
* Basic properties and methods for subclasses
*/
class BasicProp{
  //type = block type, value = score
  private int id, type, value;
  //weight, height
  private int  w, h;
  private int fallDistance;
  private float x, y, speedX, speedY;
  private PImage img;
  // transported = have used portal, left = direction is left, onPortal = player is on Portal block
  private boolean fall, jump, transported, highJump, left, onPortal;
  
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
  
  public void setSpeedY(float speed){
      this.speedY = speed;
  }
  
  public float getSpeedY(){
      return this.speedY;
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
  
  /**
  * In each frame, player's position depends on x + speedX and y + speedY
  */
  public void move(){
     this.x += this.speedX;
     if(this.jump){
          this.y += this.speedY;
          if(speedY < Type.PLAYER_SPEED_Y) this.speedY += Type.SPEED_INCREMENT;
     }
     if(this.speedY == 0){
       this.fallDistance = 0;
     }
     this.fallDistance += speedY;
     if(this.fallDistance > 250){
       println("Too high, damage caused");
       this.fallDistance = 0;
     }
  }
  
  public void move(float px, float py){
     this.x = px;
     this.y = py;
  };
  
  public void jump(){};
  
}
