public class Ghost extends Enemy{
   
  public Ghost(int sizeX, int sizeY){
     this.setX(0);
     this.setY(0);
     this.setSizeX(sizeX);
     this.setSizeY(sizeY);
  }
  
   
   public void move(float px, float py){
       this.setX(px + 30);
       this.setY(py + 30);
   }
   
}
