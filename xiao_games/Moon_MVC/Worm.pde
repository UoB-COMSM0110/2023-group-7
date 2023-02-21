public class Worm extends Enemy{
   
  public Worm(int w, int h){
     this.setType(Type.ENEMY_WORM);
      this.setSpeedX(0.5);
      this.setFall(true);
     this.setWidth(w);
     this.setHeight(h);
  }
  
  
}
