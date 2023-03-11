/**
* @author imyuanxiao, participants
* Class for player
* 'useItem()' - change status of player, should be updated
*/
public class Player extends BasicProp{
  
  //player can only have one weapon at a time
  private Item weapon;
  //player can have a lot of items such as potions
  private ArrayList<Item> items;
  private int currentItemIndex;
  //if needed, we can add some permanent items that can change status forever
  //private ArrayList<Item> outfit;
  
  //since there may be more then two gifs
  //private ArrayList<Gif> gifs;

  private int bulletCd;
    
  public Player(int x, int y, int w, int h){
    this.setType(Type.PLAYER);
    this.setTransported(true);
    this.setX(x);
    this.setY(y);
    this.setWidth(w);
    this.setHeight(h);
    this.items = new ArrayList();
    //this.gifs = new ArrayList();
    
    this.setHp(100);
    this.setImg(loadImage("imgs/player/hp.png"));
    this.getImg().resize(Type.BOARD_GRIDSIZE *2/3, Type.BOARD_GRIDSIZE *2/3);
    this.setDpCd(Type.PLAYER_DPCD);
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

  public void addItem(Item t){
     if(t.getCategory() == Type.ITEM_WEAPON){
        this.weapon = t;
     /*
     }else if(t.getCategory() == Type.ITEM_CRYSTAL)(  //for crystal, not put into the store section, but add score or sth directly
        add score or crystal to player
     */
     }else{ 
        items.add(t);
     }  
  }
  
  public Item getCurrentItem(){
       if(items.size() == 0){
        return null;
       }
       return items.get(currentItemIndex);
  }
  
  public void changeItem(){
     if(items.size() == 0){
        println("no items");
        return;
     }
     this.currentItemIndex = (this.currentItemIndex + 1) % items.size();
     println("change items: " + currentItemIndex);
     println(items.size());
  }
  
  public void removeCurrentItem(){
     this.items.remove(currentItemIndex--);
     if(currentItemIndex<0) currentItemIndex = 0;
  }
  
  //public void useItem(){
  //   if(items.size() == 0){
  //      println("no items");
  //      return;
  //   }
  //   Item t = items.get(currentItemIndex);
  //   if(t.getCategory() == Type.ITEM_POTION){
  //      println("use potion, id: " + t.getId());
  //   }
  //   this.items.remove(currentItemIndex--);
  //   if(currentItemIndex<0) currentItemIndex = 0;
  //}
  
  public Item getWeapon(){
     return this.weapon;
  }
  
   private int getBulletCd(){
     return this.bulletCd;
   }
   
   private void setBulletCd(int cd){
     this.bulletCd = cd;
   }
   
     
  //public void addGif(Gif gif){
  //  this.gifs.add(gif);
  //}
  
  //public ArrayList<Gif> getGifs(){
  //  return this.gifs;
  //} 
  
  public void move(){
     this.setX(this.getX() + this.getSpeedX() + this.getSpeedXInc());
     if(this.getFlyMode()){
         this.setY(this.getY() + this.getSpeedY());
     }else{
         if(this.getJump()){
            this.setY(this.getY() + this.getSpeedY());
            if(this.getSpeedY() < Type.PLAYER_SPEED_Y) this.setSpeedY(this.getSpeedY() + Type.PLAYER_SPEED_INCREMENT);
         }
         if(this.getSpeedY() == 0){
           this.setFallDistance(0);
         }
         this.setFallDistance(this.getFallDistance() + this.getSpeedY());
         if(this.getFallDistance() > 250){
         this.setHp(this.getHp() - 20);
         println("Damage caused by falling: " + 20);
         this.setFallDistance(0);
         }
     }
  }
  
}
