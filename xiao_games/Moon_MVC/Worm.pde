/**
* @author imyuanxiao
* Class for worm. Worm moves slowly, when it touches player, low damage caused.
*/
public class Worm extends Enemy{
   
  public Worm(int w, int h){
     this.setType(Type.ENEMY_WORM);
      this.setSpeedX(Type.SPEED_INCREMENT);
      this.setFall(true);
     this.setWidth(w);
     this.setHeight(h);
  }
  
}
