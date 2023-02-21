public class Gunner extends Enemy{

    public Gunner(int w, int h){
      this.setType(Type.ENEMY_GUNNER);
      this.setSpeedX(2);
      this.setFall(true);
      this.setWidth(w);
      this.setHeight(h);
    }
  
    
  
}
