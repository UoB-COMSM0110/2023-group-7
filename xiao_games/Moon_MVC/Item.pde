/**
* all items that can be generated in game
* e.g. weapon 
*/
public class Item extends BasicProp{
   
    private int[] pos;
  
    // Primary category = category
    private int category;
    // Secondary category = type in basicProp
    
    //left and right
    private PImage[] imgs;
   
    
    public Item(){
       this.pos = new int[2];
       this.imgs = new PImage[2];
    }
    
    public void setImgs(PImage[] imgs){
      this.imgs[0] = imgs[0];
      this.imgs[1] = imgs[1];
    }
    
    public PImage[] getImgs(){
      return this.imgs;
    } 
    
    public void setCategory(int c){
       this.category = c;
    }
  
    public int getCategory(){
       return this.category;
    }
    
    public void setPos(int[] pos){
       this.pos[0] = pos[0];
       this.pos[1] = pos[1];
    }
    
   public int[] getPos(){
       return this.pos;
    }
    
   public float getY(){
      return this.pos[0] * Type.BOARD_GRIDSIZE;
    }
    
   public float getX(){
      return this.pos[1] * Type.BOARD_GRIDSIZE;

  }
    
    //if item is weapon
    public void shot(Room r, float x, float y){
       
    }

}
