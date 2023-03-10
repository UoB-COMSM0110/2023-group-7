/**
* @author participants, imyuanxiao
* Factory for enemy generation.
* If gifs are needed, you need to build another function similar to addplayerGifs() in Moon_MVC.pde
* If no gifs, only PImage, you can add imgs in this class, just like ItemFactory.class
*/
public class EnemyFactory extends Factory{    
    
    public EnemyFactory(){
       this.setImgs(new ArrayList());
       this.setId(0);
       //this.init(); //<>// //<>// //<>//
    }
    
    //private void init(){
    //   this.addImg(loadImage("imgs/enemy/ghost.png")); //<>// //<>// //<>//
    //   this.addImg(loadImage("imgs/enemy/worm.png"));
    //   this.addImg(loadImage("imgs/enemy/gunner.png"));
    //}
    
    //scan a room, add enemy spawn or enemies to this room
    //enemy can'be generated on blocks without two blocks next to it
    public void addEnemiesToRoom(Room r){
       for(int i = 3; i < 17; i++){
         for(int j = 3; j < 27; j++){
            if(r.getBlockType(i , j) == Type.BLOCK_EMPTY
            && r.getBlockType(i , j-1) == Type.BLOCK_EMPTY
            && r.getBlockType(i , j+1) == Type.BLOCK_EMPTY
            && r.getBlockType(i+1,j-1) != Type.BLOCK_EMPTY
            && r.getBlockType(i+1,j) != Type.BLOCK_EMPTY
            && r.getBlockType(i+1,j+1) != Type.BLOCK_EMPTY
            ){
              int rd = (int)random(20);
              rd = 1;
              if(rd == 1){
                Enemy e = newEnemy(Type.ENEMY_WORM);
                e.setX(Type.BOARD_GRIDSIZE * j);
                e.setY(Type.BOARD_GRIDSIZE * i);
                r.addEnemy(e);
              }
            }
         }
       }
    
    }
    
    
    public Enemy newEnemy(int type){
       Enemy e; 
       if(type == Type.ENEMY_GHOST){
           e = new Ghost((int)(Type.BOARD_GRIDSIZE * 1.5), (int)(Type.BOARD_GRIDSIZE * 1.5)); //<>// //<>// //<>//
       }else if(type == Type.ENEMY_WORM){
           e = new Worm((int)(Type.BOARD_GRIDSIZE_SUB5), (int)(Type.BOARD_GRIDSIZE_SUB5));
           e.setHp(20);
           e.setDp(10);
       }else if(type == Type.ENEMY_GUNNER){
           e = new Gunner((int)(Type.BOARD_GRIDSIZE_SUB5), (int)(Type.BOARD_GRIDSIZE_SUB5 * 2));
           e.setHp(20);
           e.setDp(10);
       }else{
           e = new Enemy();
       }  //<>// //<>// //<>//
       e.setFall(true);
       e.setId(this.getId());
       //e.setImg(this.getImgs().get(type));
       //e.getImg().resize(e.getWidth(), e.getHeight());
       this.increaseId();
       return e;
    }
    
    
    
    
}
