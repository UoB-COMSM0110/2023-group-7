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
       //this.init(); //<>// //<>// //<>// //<>// //<>//
    }
    
    //private void init(){
    //   this.addImg(loadImage("imgs/enemy/ghost.png")); //<>// //<>// //<>// //<>// //<>//
    //   this.addImg(loadImage("imgs/enemy/worm.png"));
    //   this.addImg(loadImage("imgs/enemy/gunner.png"));
    //}
    
    //scan a room, add enemy spawn or enemies to this room
    //enemy can'be generated on blocks without two blocks next to it
    public void addEnemiesToRoom(Room r){
       for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
         for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
            //legalPosition() need w and h of this type of enemy
            Enemy tmp = newEnemy(Type.ENEMY_GUNNER);
            boolean flag = legalPosition(r, tmp, new int[]{i,j});
            println(flag + ", " + i +"," + j);
            if(flag){
              int rd = (int)random(20);
              if(rd > 15){
                Enemy e = tmp;
                e.setX(Type.BOARD_GRIDSIZE * j);
                e.setY(Type.BOARD_GRIDSIZE * i);
                r.addEnemy(e);
              }
            }
         }
       }
    }
    
    //check position according target position and enemy's size
    //pos[0] = i, pos[1] = j
    public boolean legalPosition(Room r, BasicProp o, int[] pos){
      if(pos[0] <=3 || pos[0] >= Type.BOARD_MAX_HEIGHT - 3 || pos[1] <=3 || pos[1] >= Type.BOARD_MAX_WIDTH - 3){
        return false;
      }
      float s = Type.BOARD_GRIDSIZE;
      float x = pos[1] * s, y = pos[0] * s;
      float h = o.getHeight(), w = o.getWidth();
      
      //left/right empty
      int left = (int)(x/s) - 1;
      int right = (int)((x + w)/s) + 1;
      int U = (int)(y/s) ;
      int D = (int)((y+h)/s);
      for(int i = U; i <= D; i++){
          if(blockEnemyCannotThrough(r.getBlockType(i,left))|| blockEnemyCannotThrough(r.getBlockType(i,right))){
             return false;
          }
      }
      //up empty, down not empty
      int upper = (int)(y/s) - 1;
      int below = (int)((y + h)/s) + 1;
      int L = (int)(x/s) ;
      int R = (int)((x+w)/s);
      //all blocks above are !blockCannotThrough(), o can through
      for(int i = L; i <= R && upper >= 0; i++){
         if(blockEnemyCannotThrough(r.getBlockType(upper,i))){
            return false;
         }
      }
      for(int i = L; i <= R && below < Type.BOARD_MAX_HEIGHT; i++){
         if(!blockEnemyCannotThrough(r.getBlockType(below,i))){
            return false;
         }
      }
      return true;
    }
    
    public boolean blockEnemyCannotThrough(int type){
     if(type == Type.BLOCK_EMPTY || type == Type.BLOCK_CRATE || type == Type.BLOCK_SPIKE){
       return false;
     }
     return true;
   }
    
    
    public Enemy newEnemy(int type){
       Enemy e; 
       if(type == Type.ENEMY_GHOST){
           e = new Ghost(); //<>// //<>// //<>//
       }else if(type == Type.ENEMY_WORM){
           e = new Worm();

       }else if(type == Type.ENEMY_GUNNER){
           e = new Gunner();
       }else{
           e = new Enemy();
       } //<>// //<>// //<>//
       e.setFall(true);
       e.setId(this.getId());
       //e.setImg(this.getImgs().get(type));
       //e.getImg().resize(e.getWidth(), e.getHeight());
       this.increaseId();
       return e;
    }
    
    
    
    
}
