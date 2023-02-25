class Enemy extends BasicProp{
  private int[] spawn;

  Enemy(){};
   
  public void setSpawn(int[] spawn){
     this.spawn[0] = spawn[0];
     this.spawn[1] = spawn[1];
  }
  
  public void move(){
     
     super.move();
     
      //if(this.getSpeedX() > 0){
      //  this.setLeft(false);
      //}
      //if(this.getSpeedX() < 0){
      //  this.setLeft(true);
      //}
     
     if(this.getY() + this.getHeight() > height || this.getY() < 0){
         this.setY(height/2);
     }
    
     if(this.getX() + this.getWidth() > width || this.getX() < 0){
         this.setSpeedX(-this.getSpeedX());
     }
  }
  
}
