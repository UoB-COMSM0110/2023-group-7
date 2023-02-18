public class Worm extends Enemy{
   
  public Worm(int sizeX, int sizeY){
     this.setSizeX(sizeX);
     this.setSizeY(sizeY);
  }
  
   public void move(int px, int py){
       this.setX(px + 30);
       this.setY(py - 30);
   } 
  
}
