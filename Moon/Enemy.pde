/**
* @author participants, imyuanxiao
* Class for enemies. This class includes some basic properties that all enemies have.
*/
class Enemy extends BasicProp{
  private int[] spawn;

  Enemy(){};
   
  public void setSpawn(int[] spawn){
     this.spawn[0] = spawn[0];
     this.spawn[1] = spawn[1];
  }
  
  public void move(){
     
     super.move();
     
      if(this.getSpeedX() > 0){
        this.setLeft(false);
      }
      if(this.getSpeedX() < 0){
        this.setLeft(true);
      }
     
     public void loadImags(){}
    
     if(this.getX() + this.getWidth() > width){
         this.setLeft(true);
         this.setSpeedX(-abs(this.getSpeedX()));
     }
     
     if(this.getX() < 0){
         this.setLeft(false);
         this.setSpeedX(abs(this.getSpeedX()));
     }
  }
  
}
