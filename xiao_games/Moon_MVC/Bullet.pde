public class Bullet extends BasicProp{
   
    //private float  w, h;
    //private float x, y, speedX;
    
    Bullet(float x, float y, float speed){
       this.setX(x);
       this.setY(y);
       this.setSpeedX(speed);
       this.setWidth(5);
       this.setHeight(5);
    }
    
      public void move(){
          this.setX(this.getX() + this.getSpeedX());
      }

}
