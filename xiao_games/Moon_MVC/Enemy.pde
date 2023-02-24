class Enemy extends BasicProp{
  private int[] spawn;

  Enemy(){};
   
  public void setSpawn(int[] spawn){
     this.spawn[0] = spawn[0];
     this.spawn[1] = spawn[1];
  }
  
  public void move(){
     
     if(this.getX() + this.getWidth() > width || this.getX() < 0){
         this.setSpeedX(-this.getSpeedX());
     }
    
     this.setX(this.getX() + this.getSpeedX());
     
     //if(this.getFall()){
     //     if(this.getSpeedY() < 0) this.setSpeedY(0);
     //     this.setSpeedY(this.getSpeedY()+ 0.5);
     //     this.setY(this.getY() + this.getSpeedY());
     //}
  
  }
  
}
