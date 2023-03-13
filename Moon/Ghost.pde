/**
* @author imyuanxiao
* Class for Ghost, who is always chasing player, 
* When ghost touches player, player hp decrease, this can be realized in Controller.class
*/
public class Ghost extends Enemy{
   
  public Ghost(){
     this.setSpeedX(1);
     this.setSpeedY(1);
     this.setX(random(width));
     this.setY(random(height));
     this.setWidth((int)(Type.BOARD_GRIDSIZE * 1.5));
     this.setHeight((int)(Type.BOARD_GRIDSIZE * 1.5));
     this.setHp(Integer.MAX_VALUE);
  }
  
   /**
   * Override move(float, float) in super,
   * ghost can always move toward player's position
   */
   public void move(float px, float py){
       if(px > this.getX()){
          if(this.getSpeedX() < 0) this.setSpeedX(-this.getSpeedX());
       }else{
          if(this.getSpeedX() > 0) this.setSpeedX(-this.getSpeedX());
       }
       if(py > this.getY()){
          if(this.getSpeedY() < 0) this.setSpeedY(-this.getSpeedY());
       }else{
          if(this.getSpeedY() > 0) this.setSpeedY(-this.getSpeedY());
       }
       this.setX(this.getX() + this.getSpeedX());
       this.setY(this.getY() + this.getSpeedY());
   }
   
    // public void loadImages(){
    
    // PImage[] ghost = Gif.getPImages(this, "imgs/enemy/ghost.gif");
    // //Any effect?? 
    // this.addGifsImgs(ghost);
    
    //}
}
