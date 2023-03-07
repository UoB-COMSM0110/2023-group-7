/**
* @author participants, imyuanxiao
* Class for Gunner, who can shot toward player
* When bullets touch player, player hp decrease, this can be realized by adding a new ArrayList in Room.class and another collision detection in Controller.class
*/
public class Gunner extends Enemy{

    public Gunner(int w, int h){
      this.setType(Type.ENEMY_GUNNER);
      this.setSpeedX(2);
      this.setFall(true);
      this.setWidth(w);
      this.setHeight(h);
    }
    
}
