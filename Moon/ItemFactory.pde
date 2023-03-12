/**
* @author YWang0727, imyuanxiao
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
       weaponImgs.add(loadImage("imgs/items/weapon/3_1.png")); 
       weaponImgs.add(loadImage("imgs/items/weapon/3_2.png")); 
       
       // imgs of consumables
       potionImgs.add(loadImage("imgs/items/potion/0.png"));
       potionImgs.add(loadImage("imgs/items/potion/1.png"));
       

    }
    
    
    //all effects of items can be written here
    public void useItemByPlayer(Player p){
        Item t = p.getCurrentItem();
         if(t == null){
            println("no items");
            return;
         }
         
         if(t.getCategory() == Type.ITEM_POTION){
            if(t.getType() == Type.POTION_HP){
                p.setHp(p.getHp() + 10);
                println("use potion, id: " + t.getId() + ", playerHp: " + p.getHp());
            }else{
                //speed increment to be added...
                println("use potion, id: " + t.getId());
            }
         }
         p.removeCurrentItem();
    }
    
    //scan a room, add chest to this room: The probability can be adjusted at any time
    public void addItemsToRoom(Room r){
       for(int i = 3; i < Type.BOARD_MAX_HEIGHT - 4; i++){
          for(int j = 3; j < Type.BOARD_MAX_WIDTH - 3; j++){
              if(r.blockType[i + 1][j] == 1 && r.blockType[i - 1][j] == 0){
                  int n = (int)random(0, 60);
                  if(n < 5){
                    r.blockType[i][j] = 6;
                  }
              }
          }
       }
    }
    
    public Item newItem(int[] pos){
       int r = (int)random(10);
       Item t = null; 
       if(r >= 0 && r <= 3){   
           t = newWeapon();
       }else if(r > 3 && r <= 6){  
            //randomly generate a new potion
           t = newPotion();
       }else{
           t = newCrystal();
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
            Bullet b = new Bullet(x, y, Type.BULLET_SPEED_SLOW, 0);
            //dp of bullet must be set
            b.setDp(5);

            r.getBullets().add(b);
          }
       };
       
       //Cd must be set
       t.setBulletCd(Type.BULLET_CD_NORMAL);
       //Type must be set
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
       
       //these two lines are here because this methoed is called when game started,
       //and they are not needed in other weapon*() methods;
       t.setId(this.getId());
       this.increaseId();
       
       return t;
    }
    
    public Item weaponShotgun(){
       //overload shot method
       Item t = new Item(){
            public void shot(Room r, float x, float y){
            
            Bullet b1 = new Bullet(x, y, Type.BULLET_SPEED_NORMAL, 1);
            Bullet b2 = new Bullet(x, y, Type.BULLET_SPEED_NORMAL, 0);
            Bullet b3 = new Bullet(x, y, Type.BULLET_SPEED_NORMAL, -1);
            
            b1.setDp(5);
            b2.setDp(5);
            b3.setDp(5);
            
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
            Bullet b = new Bullet(x, y, Type.BULLET_SPEED_FAST,0){
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
            b.setDp(10);
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
    
    public Item newMinergun(){
       Item t = weaponMinergun();
       t.setCategory(Type.ITEM_WEAPON);
       return t;
    }
    
    public Item weaponMinergun(){  //Player comes with own miner gun initially
       Item t = new Item(){
            public void shot(Room r, float x, float y){
            Bullet b = new Bullet(x, y, Type.BULLET_SPEED_FAST,0){
                //overload paint();
                public void paint(){
                   //default
                   stroke(100);
                   strokeWeight(5);
                   line(this.getX(), this.getY(), this.getX() + this.getSpeedX() * 3, this.getY() + this.getSpeedY() * 3);
                   noStroke();
                }
            };
            b.setType(Type.BULLET_TYPE_MINER);
            b.setDp(0);  //Minergun cannot do damage to enemies ?

            r.getBullets().add(b);
          }
       };
       
       //Cd must be set
       t.setBulletCd(Type.BULLET_CD_NORMAL);
       //Type must be set
       t.setType(Type.WEAPON_MINER);
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
       int r = (int)random(10);
       Item t = null;
       if(r >=0 && r <= 5){
          t =  potionHp();
       }else{
          t =  potionSp();
       } 
       
       //set category
       t.setCategory(Type.ITEM_POTION);
       return t; 
    }
    
    public Item potionHp(){
        Item t = new Item();
        t.setType(Type.POTION_HP);
        //process size and PImage
        t.setCategory(Type.ITEM_POTION);
        PImage img = potionImgs.get(t.getType());
        t.setImgs(new PImage[]{img, null});
        t.getImgs()[0].resize(Type.BOARD_GRIDSIZE * 2/3, Type.BOARD_GRIDSIZE);
        t.setWidth(Type.BOARD_GRIDSIZE * 2/3);
        t.setHeight(Type.BOARD_GRIDSIZE);
        return t;
    }
    
    public Item potionSp(){
        Item t = new Item();
        t.setType(Type.POTION_SP);
        //process size and PImage
        t.setCategory(Type.ITEM_POTION);
        PImage img = potionImgs.get(t.getType());
        t.setImgs(new PImage[]{img, null});
        t.getImgs()[0].resize(Type.BOARD_GRIDSIZE * 2/3, Type.BOARD_GRIDSIZE);
        t.setWidth(Type.BOARD_GRIDSIZE * 2/3);
        t.setHeight(Type.BOARD_GRIDSIZE);
        return t;
    }
    
    //randomly generate a new crystal
    public Item newCrystal( ){
        Item t = new Item();
        t.setType(Type.CRYSTAL);
        //process size and PImage
        t.setCategory(Type.ITEM_CRYSTAL);
        PImage img = loadImage("imgs/items/crystal.png");
        t.setImgs(new PImage[]{img, null});
        t.getImgs()[0].resize(Type.BOARD_GRIDSIZE, Type.BOARD_GRIDSIZE);
        t.setWidth(Type.BOARD_GRIDSIZE);
        t.setHeight(Type.BOARD_GRIDSIZE);
        return t;
    }
    
    
}
