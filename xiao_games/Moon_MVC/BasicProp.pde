class BasicProp{
  private int id, type, value;
  private int  w, h;
  private float x, y, speedX, speedY;
  private PImage img;
  private boolean fall, jump, transported;
  
  BasicProp(){
    this.fall = true;
    this.jump = false;
    this.transported = false;
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
  
  public void setJump(boolean flag){
      this.jump = flag;
  }
  
  public boolean getJump(){
      return this.jump;
  }
  
  public void move(){
     this.x += this.speedX;
     if(this.jump){
          this.y += this.speedY;
          if(speedY < 10) this.speedY += 0.5;
     }
     if(this.fall && !this.jump){
          if(speedY < 0) speedY = 0;
          if(speedY < 10) this.speedY += 0.5;
          this.y += this.speedY;
     }
  }
  
  public void move(float px, float py){
     this.x = px;
     this.y = py;
  };
  
  public void jump(){};
  
  
  
}
