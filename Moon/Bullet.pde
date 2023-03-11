/**
* @author imyuanxiao
* Class for bullets. Each weapon should overload shot() method when generationg new bullet object
* Next stage: add damage here. Damage should be set when weapon is generated. Damage to enemies should be added with potion effects probably?
*/
public class Bullet extends BasicProp{
   
    Bullet(float x, float y, float speed, int direction){
       this.setX(x);
       this.setY(y);
       //this.setSpeedX(speedX);
       //this.setSpeedY(speedY);
       this.direction(direction);
       this.setWidth(5);
       this.setHeight(5);
       this.setType(Type.BULLET_TYPE_CIRCLE);
       this.countSpeed(speed, direction);
    }
    
    Bullet(BasicProp e, BasicProp p, float speed){
       this.setX(e.getX() + e.getWidth()/2);
       this.setY(e.getY() + e.getHeight()/2);
       this.setWidth(5);
       this.setHeight(5);
       this.setType(Type.BULLET_TYPE_CIRCLE);
       this.countSpeed(speed, p);
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
      
      public void countSpeed(float speed, int direction){
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
            if(direction == 0){  //set bullet directions
              this.setSpeedY(bSpeedY);
            }else if(direction == 1){
              this.setSpeedY(bSpeedY + 2);
            } else{
              this.setSpeedY(bSpeedY - 2); 
            }
      }
      
      public void countSpeed(float speed, BasicProp p){
            float bSpeedX, bSpeedY;
            float pX = p.getX(), py = p.getY();
            if(pX == this.getX()){
                 bSpeedX = 0;
                 bSpeedY = speed;
            }else{
                 float k = (py - this.getY()) / (pX - this.getX());
                 bSpeedX = sqrt(speed * speed/(1+k*k));
                 bSpeedY = k*sqrt(speed * speed/(1+k*k));
            }
            if(pX < this.getX()){
              bSpeedX = - bSpeedX;
              bSpeedY = - bSpeedY;
            }
            this.setSpeedX(bSpeedX);
            this.setSpeedY(bSpeedY);
      }

}
