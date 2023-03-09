/**
* @author imyuanxiao
* All items that can be generated in game, e.g. weapon
* 'category' - means primary category, e.g. weapon, potion, coin, outfit...
* 'type' - secondary category, e.g. weapon_gun, weapon_laser 
* 'imgs[]' - for weapons, at least two PImage needed (left/right), for others, one PIame may be enough.
*/
public class Item extends BasicProp{
   
    private int[] pos;
  
    // Primary category = category
    private int category;
    // Secondary category = type in basicProp
    
    //left and right
    private PImage[] imgs;
    
    private int bulletCd;
    
    
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
  
   private int getBulletCd(){
     return this.bulletCd;
   }
   
   private void setBulletCd(int cd){
     this.bulletCd = cd;
   }
   

    
    //if item is weapon
    public void shot(Room r, float x, float y){
       
    }

}
