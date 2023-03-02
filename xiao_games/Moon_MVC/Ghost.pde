public class Ghost extends Enemy{
   
  public Ghost(int w, int h){
     this.setSpeedX(1);
     this.setSpeedY(1);
     this.setX(random(width));
     this.setY(random(height));
     this.setWidth(w);
     this.setHeight(h);
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
}
