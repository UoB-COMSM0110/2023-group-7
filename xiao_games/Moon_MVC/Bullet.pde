/**
* @author imyuanxiao
* Class for bullets. Each weapon should overload shot() method when generationg new bullet object
* Next stage: add damage here. Damage should be set when weapon is generated. Damage to enemies should be added with potion effects probably?
*/
public class Bullet extends BasicProp{
   
    Bullet(float x, float y, float speed){
       this.setX(x);
       this.setY(y);
       //this.setSpeedX(speedX);
       //this.setSpeedY(speedY);
       this.setWidth(5);
       this.setHeight(5);
       this.setType(Type.BULLET_TYPE_CIRCLE);
       this.countSpeed(speed);
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
      
      public void countSpeed(float speed){
            float bSpeedX, bSpeedY;
            if(mouseX == this.getX()){
                 bSpeedX = 0;
                 bSpeedY = speed;
            }else{
                 float k = (mouseY - this.getY()) / (mouseX - this.getX());
                 bSpeedX = sqrt(speed * speed/(1+k*k));
                 bSpeedY = k*sqrt(speed * speed/(1+k*k));
            }
            if(mouseX < this.getX()){
              bSpeedX = - bSpeedX;
              bSpeedY = - bSpeedY;
            }
            this.setSpeedX(bSpeedX);
            this.setSpeedY(bSpeedY);
      }

}
