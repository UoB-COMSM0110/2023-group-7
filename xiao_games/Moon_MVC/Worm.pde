/**
* @author imyuanxiao
* Class for worm. Worm moves slowly, when it touches player, low damage caused.
*/
public class Worm extends Enemy{
   
  public Worm(){
     this.setType(Type.ENEMY_WORM);
     this.setSpeedX(Type.SPEED_INCREMENT);
     this.setFall(true);
     this.setWidth((int)(Type.BOARD_GRIDSIZE_SUB5));
     this.setHeight((int)(Type.BOARD_GRIDSIZE_SUB5));
     this.setHp(20);
     this.setDp(10);
  }
  
  
  
}
