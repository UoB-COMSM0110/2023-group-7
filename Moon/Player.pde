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
  private Item[] weapons;
  private int currentItemIndex;
  private int currentWeaponIndex = 0;
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
    this.weapons = new Item[2];
    this.currentWeaponIndex = 0;
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
        weapons[0] = t;
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
  
  public void switchToMinergun(){
     ItemFactory minergun = new ItemFactory();
     Item m = minergun.newMinergun();
     weapons[1] = m;
     if(currentWeaponIndex == 0){
        this.weapon = weapons[1];
        currentWeaponIndex = 1;
        println("switch to minergun");
     }else{
        this.weapon = weapons[0];
        currentWeaponIndex = 0;
     }
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
  
  public void playGifsImgs(){
      
     // left = odd, right = even
      
     int i;
     int offset = this.getLeft() ? 0 : 1;
     //if(p.getRun()){
     i = Type.GIF_RUN_L + offset;
     PImage[] imgs = this.getGifsImgs().get(i);
     image(imgs[(int)this.getGifsImgsCount()[i]], this.getX(), this.getY());
     this.getGifsImgsCount()[i] = (this.getGifsImgsCount()[i]+Type.GIF_PLAY_SPEED) % (float)imgs.length;
     //}
     //if(p.getKnockBack()){
     //i = Type.GIF_KONCKBACK_L;
     //PImage[] imgs = this.getGifsImgs().get(i);
     //image(imgs[(int)this.getGifsImgsCount()[i]], this.getX(), this.getY());
     //this.getGifsImgsCount()[i] = (this.getGifsImgsCount()[i]+Type.GIF_PLAY_SPEED) % (float)imgs.length;
     //}
     
     //draw weapon
     Item w = this.getWeapon();
     int wOffset = offset == 1 ? 0 : 1;
     image(w.getImgs()[offset],  this.getX() - w.getWidth() * wOffset + this.getWidth()/2, this.getY() + this.getHeight()/3);
    

  }
  
}
