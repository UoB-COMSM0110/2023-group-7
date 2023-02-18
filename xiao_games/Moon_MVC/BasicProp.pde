class BasicProp{
  private int id, type, speed, value;
  private int  sizeX, sizeY;
  private float x, y;
  private PImage img;
  
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
  
  public void setSpeed(int speed){
      this.speed = speed;
  }
  
  public int getSpeed(){
      return this.speed;
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
  
  public void setSizeX(int size){
      this.sizeX = size;
  }
  
  public int getSizeX(){
      return this.sizeX;
  }
  
  public void setSizeY(int size){
      this.sizeY = size;
  }
  
  public int getSizeY(){
      return this.sizeY;
  }
  
  public void setImg(PImage img){
      this.img = img;
  }
  
  public PImage getImg(){
      return this.img;
  }
  
  //public void setPos(int[] pos){
  //   this.pos[0] = pos[0];
  //   this.pos[1] = pos[1];
  //}

  //public int[] getPos(){
  //   return this.pos;
  //}
  
  public void move(){
     
  }
  
  public void move(float px, float py){};
  
  public void jump(){};
  
  
  
}
