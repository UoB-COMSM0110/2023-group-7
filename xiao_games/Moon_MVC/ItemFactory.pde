/**
* @author participants, imyuanxiao
* Factory for item generation (randomly)
* For weapons, method 'shot()' (and other functions if needed) in this class should be overrided by creating an anonymous inner class in construcotr.
* How bullet moves should be reconsidered. Currently, bullets will move faster if shot upward.
* 
* For consumables such as potions, method 'useItem()' in Player.class should be refactored to change status of player temporarily
* For outfit, whick can permanently change status of player, method 'useItem()' or new method in Player.class should be set
* For coins, which should directly add score instead of being added to any class
*/
public class ItemFactory extends Factory{
    
    private ArrayList<PImage> weaponImgs;
    private ArrayList<PImage> potionImgs;
    //private ArrayList<PImage> coinImgs;
    //private ArrayList<PImage> outfitImgs;

    public ItemFactory(){
       this.setId(0);
       this.weaponImgs = new ArrayList();
       this.potionImgs = new ArrayList();
       //this.coinImgs = new ArrayList();
       this.init(); 
    }
    
    /**
    * add all imgs of items
    */
    private void init(){
       // imgs of weapons
       weaponImgs.add(loadImage("imgs/items/weapon/0_1.png")); 
       weaponImgs.add(loadImage("imgs/items/weapon/0_2.png")); 
       weaponImgs.add(loadImage("imgs/items/weapon/1_1.png")); 
       weaponImgs.add(loadImage("imgs/items/weapon/1_2.png")); 
       weaponImgs.add(loadImage("imgs/items/weapon/2_1.png")); 
       weaponImgs.add(loadImage("imgs/items/weapon/2_2.png")); 
       
       // imgs of consumables
       potionImgs.add(loadImage("imgs/items/potion/0.png"));

    }
    
    //all effects of items can be written here
    public void useItemByPlayer(Player p){
        Item t = p.getCurrentItem();
         if(t == null){
            println("no items");
            return;
         }
         
         if(t.getCategory() == Type.ITEM_POTION){
            println("use potion, id: " + t.getId());
         }
         
         p.removeCurrentItem();
    }
    
    //scan a room, add chest to this room
    public void addItemsToRoom(Room r){
    
    
    }
    
    public Item newItem(int[] pos){
       int r = (int)random(10);
       Item t = null; 
       //r = 5;
       if(r >= 0 && r <= 4){
           t = newWeapon();
       }else{
            //randomly generate a new potion
           t = newPotion();
       }
       //
       //else if(category == Type.ITEM_PERMANENT){
       //    item = newOutfit();
       //}
       
       if(t != null){
         t.setPos(pos);
         t.setId(this.getId());
         this.increaseId();
       }
       return t;
    }
    
    //randomly generate a new weapon
    public Item newWeapon( ){
       //randomly generate a weapon
       int r = (int)random(10);
       
       
       Item t = null;
       if(r >=0 && r <= 5){
          t =  weaponShotgun();
       }else{
          t =  weaponLaser();
       } 
       //each wapon may have different size, so this part of code can be moved to their generation function
       
       //set category
       t.setCategory(Type.ITEM_WEAPON);
       return t;
    }
    
    //new-hand weapon
    public Item weaponPistol(){
       //overload shot method
       Item t = new Item(){
            public void shot(Room r, float x, float y){
            Bullet b = new Bullet(x, y, Type.BULLET_SPEED_SLOW);
            r.getBullets().add(b);
          }
       };
       t.setBulletCd(Type.BULLET_CD_NORMAL);
       t.setType(Type.WEAPON_PISTOL);
       //get PImage and resize them
       t.setImgs(new PImage[]{
          weaponImgs.get(t.getType() * 2),
          weaponImgs.get(t.getType() * 2 + 1)
       });
       t.getImgs()[0].resize(Type.BOARD_GRIDSIZE/2, Type.BOARD_GRIDSIZE/2);
       t.getImgs()[1].resize(Type.BOARD_GRIDSIZE/2, Type.BOARD_GRIDSIZE/2);
       //remember to set width and height
       t.setWidth(Type.BOARD_GRIDSIZE/2);
       t.setHeight(Type.BOARD_GRIDSIZE/2);
       
       t.setId(this.getId());
       this.increaseId();
       return t;
    }
    
    public Item weaponShotgun(){
       //overload shot method
       Item t = new Item(){
            public void shot(Room r, float x, float y){
            
            //b1, b3 need PVector
            Bullet b1 = new Bullet(x, y + 20, Type.BULLET_SPEED_NORMAL);
            Bullet b2 = new Bullet(x, y, Type.BULLET_SPEED_NORMAL);
            Bullet b3 = new Bullet(x, y + 20, Type.BULLET_SPEED_NORMAL);
            
            r.getBullets().add(b1);
            r.getBullets().add(b2);
            r.getBullets().add(b3);

          }
       };
       
       t.setBulletCd(Type.BULLET_CD_LONG);
       t.setType(Type.WEAPON_SHOTGUN);
       
       //get PImage and resize them
       t.setImgs(new PImage[]{
          weaponImgs.get(t.getType() * 2),
          weaponImgs.get(t.getType() * 2 + 1)
       });
       t.getImgs()[0].resize(Type.BOARD_GRIDSIZE * 3/2, Type.BOARD_GRIDSIZE/2);
       t.getImgs()[1].resize(Type.BOARD_GRIDSIZE * 3/2, Type.BOARD_GRIDSIZE/2);
       t.setWidth(Type.BOARD_GRIDSIZE * 3/2);
       t.setHeight(Type.BOARD_GRIDSIZE/2);
       return t;
    }
    
    public Item weaponLaser(){
       //overload shot method
       Item t = new Item(){
            public void shot(Room r, float x, float y){
            Bullet b = new Bullet(x, y, Type.BULLET_SPEED_FAST){
                //overload paint();
                public void paint(){
                   //default
                   stroke(255);
                   strokeWeight(3);
                   line(this.getX(), this.getY(), this.getX() + this.getSpeedX() * 3, this.getY() + this.getSpeedY() * 3);
                   noStroke();
                }
            };
            b.setType(Type.BULLET_TYPE_LINE);
            r.getBullets().add(b);

          }
       };
       
       t.setBulletCd(Type.BULLET_CD_SHORT);
       t.setType(Type.WEAPON_LASER);

       //get PImage and resize them
       t.setImgs(new PImage[]{
          weaponImgs.get(t.getType() * 2),
          weaponImgs.get(t.getType() * 2 + 1)
       });
       t.getImgs()[0].resize(Type.BOARD_GRIDSIZE * 3/2, Type.BOARD_GRIDSIZE/2);
       t.getImgs()[1].resize(Type.BOARD_GRIDSIZE * 3/2, Type.BOARD_GRIDSIZE/2);
       t.setWidth(Type.BOARD_GRIDSIZE * 3/2);
       t.setHeight(Type.BOARD_GRIDSIZE/2);
       return t;
    }
    
    public Item newPotion(){
        //randomly generate a potion
        Item t = potionHp();
        
        //process size and PImage
        t.setCategory(Type.ITEM_POTION);
        PImage img = potionImgs.get(t.getType());
        img.resize(Type.BOARD_GRIDSIZE * 2/3, Type.BOARD_GRIDSIZE);
        t.setWidth(Type.BOARD_GRIDSIZE * 2/3);
        t.setHeight(Type.BOARD_GRIDSIZE);
        t.setImgs(new PImage[]{img, null});
        return t;
    }
    
    public Item potionHp(){
        Item t = new Item();
        t.setType(Type.POTION_HP);
        return t;
    }
    
    
}
