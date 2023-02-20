public class Ghost extends Enemy{
   
  public Ghost(int sizeX, int sizeY){
     this.setX(width/2);
     this.setY(height/2);
     this.setSizeX(sizeX);
     this.setSizeY(sizeY);
  }
  
   
   public void move(float px, float py){
       this.setX(px + 30);
       this.setY(py + 30);
   }
   
}
