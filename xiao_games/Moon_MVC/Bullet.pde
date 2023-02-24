public class Bullet extends BasicProp{
   
    //private float  w, h;
    //private float x, y, speedX;
    
    Bullet(float x, float y, float speed){
       this.setX(x);
       this.setY(y);
       this.setSpeedX(speed);
       this.setWidth(2);
       this.setHeight(2);
    }
    
    //public void setSpeedX(float speed){
    //  this.speedX = speed;
    //}
    
    //public float getSpeedX(){
    //    return this.speedX;
    //}
    
    // public void setX(float x){
    //  this.x = x;
    //  }
      
    //  public float getX(){
    //      return this.x;
    //  }
      
    //  public void setY(float y){
    //      this.y = y;
    //  }
      
    //  public float getY(){
    //      return this.y;
    //  }
      
    //  public void setWidth(int size){
    //      this.w = size;
    //  }
      
    //  public float getWidth(){
    //      return this.w;
    //  }
      
    //  public void setHeight(int size){
    //      this.h = size;
    //  }
      
    //  public float getHeight(){
    //      return this.h;
    //  }
      
      public void move(){
          this.setX(this.getX() + this.getSpeedX());
      }

}
