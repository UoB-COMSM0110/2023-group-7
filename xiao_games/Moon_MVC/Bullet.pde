/**
* Bullet
*/
public class Bullet extends BasicProp{
   
    Bullet(float x, float y, float speedX, float speedY){
       this.setX(x);
       this.setY(y);
       this.setSpeedX(speedX);
       this.setSpeedY(speedY);
       this.setWidth(5);
       this.setHeight(5);
    }
    
      /**
      * Currently, bullet can only move left and right
      * we can change this method to let it move in all directions
      * by changing speedY
      */
      public void move(){
          this.setX(this.getX() + this.getSpeedX());
          this.setY(this.getY() + this.getSpeedY());     
      }
      
      public void paint(){
         //default
         fill(255);
         ellipse(this.getX(), this.getY(), this.getWidth(), this.getHeight());
         noFill();
      }

}
