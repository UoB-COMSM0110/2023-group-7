public class Player extends BasicProp{
  
  //player can only have one weapon at a time
  private Item weapon;
  //player can have a lot of items such as potions
  private ArrayList<Item> items;
  private int currentItemIndex;
  //if needed, we can add some permanent items that can change status forever
  //private ArrayList<Item> permanent;
  
  private Gif[] gifs;

  
  public Player(int x, int y, int w, int h){
    this.setType(Type.PLAYER);
    this.setTransported(true);
    this.setX(x);
    this.setY(y);
    this.setWidth(w);
    this.setHeight(h);
    this.items = new ArrayList();
    this.gifs = new Gif[2];
  };
  
  /**
  * Using img instead of gifs, then use this constructor
  */
  public Player(int x, int y, int w, int h, String imgPath){
    this.setType(Type.PLAYER);
    this.setTransported(true);
    this.setX(x);
    this.setY(y);
    this.setWidth(w);
    this.setHeight(h);
    this.setImg(loadImage(imgPath));
    this.getImg().resize(w, h); 
  };
  
  public void setGifs(Gif[] gifs){
    this.gifs[0] = gifs[0];
    this.gifs[1] = gifs[1];
  }
    
  public Gif[] getGifs(){
    return this.gifs;
  } 
  
  public void addItem(Item t){
     if(t.getCategory() == Type.ITEM_WEAPON){
        this.weapon = t;
     }else{ 
        items.add(t);
     }  
  }
  
  public void changeItem(){
     if(items.size() == 0){
        println("no items");
        return;
     }
     this.currentItemIndex = (this.currentItemIndex++) % items.size();
     println("change items: " + currentItemIndex);
  }
  
  public void useItem(){
     if(items.size() == 0){
        println("no items");
        return;
     }
     Item t = items.get(currentItemIndex);
     if(t.getCategory() == Type.ITEM_POTION){
        println("use potion, id: " + t.getId());
     }
     this.items.remove(currentItemIndex--);
     if(currentItemIndex<0) currentItemIndex = 0;
  }
  
  //public void setWeapon(Item w){
  //   this.weapon = w;
  //}
  
  public Item getWeapon(){
     return this.weapon;
  }
  
  public void move(){
     this.setX(this.getX() + this.getSpeedX() + this.getSpeedXInc());
     if(this.getFlyMode()){
         this.setY(this.getY() + this.getSpeedY());
     }else{
         if(this.getJump()){
            this.setY(this.getY() + this.getSpeedY());
            if(this.getSpeedY() < Type.PLAYER_SPEED_Y) this.setSpeedY(this.getSpeedY() + Type.SPEED_INCREMENT);
         }
         if(this.getSpeedY() == 0){
           this.setFallDistance(0);
         }
         this.setFallDistance(this.getFallDistance() + this.getSpeedY());
         if(this.getFallDistance() > 250){
         println("Too high, damage caused");
         this.setFallDistance(0);
         }
     }
  }
  
}
