/**
* @author imyuanxiao
* Class for painting. This class will draw everything for each frame by getting data from Model.class.
* Next stage: finish draw*() methods behind
*/
public class View{
  private Model model;
  
  public View(Model mod){
     this.model = mod;    
  }
  
  /**
  * Includes all methods to run in each frame
  */
  public void paint(){
      
    if(model.getMenuHomePage()){
       drawMenuHomePage();
    }else if(model.getMenuControl()){
       drawMenuControl();
    }else if(model.getGlobalList()){
       drawGlobalList();
    }else if(model.getGamePause()){
       drawGamePause();
    }else if(model.getGameOver()){
      drawGameOver();
    }else{
         drawRoom();
         drawGhost();
         drawPlayer();
         // show collision detection range, can be deleted
         showAround(model.getPlayer());
         showAroundEnemy();
     }
  }
  
  public void showAroundEnemy(){
       ArrayList<Enemy> enemies = model.getCurrentRoom().getEnemies();
       for(int i = 0; i < enemies.size(); i++){
          showAround(enemies.get(i));
       }
  
  }
  
  
  public void drawGhost(){
       ArrayList<Enemy> enemies = model.getEnemies();
       for(int i = 0; i < enemies.size(); i++){
           Enemy e = enemies.get(i);
           e.move(model.getPlayer().getX(), model.getPlayer().getY());
           image(model.getGifs().get(e.getType()), e.getX(), e.getY());
       }
  }
  
  /**
  * Draw blocks, enemies, and bullets in current room
  */
  public void drawRoom(){
     Room r = model.getCurrentRoom(); 
     ArrayList<PImage> imgs = model.getBlockFactory().getImgs();
     //draw room
     for(int i = 0; i < 20; i++){
        for(int j = 0; j < 29; j++){
          int type = r.blockType[i][j];
          //Need to simplify this function
          //Block b = model.getBlockByType(type);
          //float sx = b.getWidth();
          image(imgs.get(type), j * Type.BOARD_GRIDSIZE, i * Type.BOARD_GRIDSIZE);
        }
      }
      
      //draw enemies
      ArrayList<Enemy> enemies = r.getEnemies();
      for(int i = 0; i < enemies.size(); i++){
          Enemy e = enemies.get(i);
          e.move();
           if(e.getLeft()){
                image(model.getGifs().get(e.getType() * 2 - 1), e.getX(), e.getY());
           }else{
                image(model.getGifs().get(e.getType() * 2), e.getX(), e.getY());
           }
      }
      
      //draw bullets
      ArrayList<Bullet> bullets = r.getBullets();
      for(int i = 0; i < bullets.size(); i++){
         Bullet b = bullets.get(i);
         b.move();
         b.paint();

      }
      
      //draw items
      ArrayList<Item> items = r.getItems();
      for(int i = 0; i < items.size(); i++){
         Item t = items.get(i);
         image(t.getImgs()[0], t.getPos()[1] * Type.BOARD_GRIDSIZE, t.getPos()[0] * Type.BOARD_GRIDSIZE);
      }
      
      
  }
  
  public void drawPlayer(){
      Player p = model.getPlayer();
      Item w = p.getWeapon();
      
      if(p.getLeft()){
            image(p.getGifs().get(0), p.getX(), p.getY());
            image(w.getImgs()[0],  p.getX() - w.getWidth() + p.getWidth()/2, p.getY() + p.getHeight()/3);
       }else{
            image(p.getGifs().get(1), p.getX(), p.getY());
            image(w.getImgs()[1],  p.getX() + p.getWidth()/2, p.getY() + p.getHeight()/3);
       }
       
       drawHp(p);
       
  }
  
  public void drawHp(BasicProp p){
      for(int i = 0; i <= p.getHp(); i += 10){
         image(p.getImg(), Type.BOARD_GRIDSIZE/2 + (i/10) * Type.BOARD_GRIDSIZE * 4/5, Type.BOARD_GRIDSIZE/2);
      }
  }
  
  

  /**
  * Show collision detection range, can be deleted
  */
  public void showAround(BasicProp o){
       showLeft(o);
       showRight(o);
       showUp(o);
       showDown(o); 
   }

  public void drawRect(float i, float j, float s){
     noFill();
     strokeWeight(1);
     rect(j * s, i * s, s, s);
  }

    public void showUp(BasicProp o){
      float x = o.getX(), y = o.getY();
      float w = o.getWidth();
      float s = Type.BOARD_GRIDSIZE;
      int upper = (int)(y/s) - 1;
      
      int L = (int)(x/s) ;
      int R = (int)((x+w)/s);
      stroke(255);
      for(int i = L; i <= R; i++){
            drawRect(upper, i, s);
      }
      
      //int R = (int)((x + w)/s);
      //int L = R - 1;
      //stroke(255);
      //drawRect(upper, R, s);
      //drawRect(upper, L, s);

   }
 
    public void showDown(BasicProp o){
      float x = o.getX(), y = o.getY();
      float w = o.getWidth(), h = o.getHeight();
      float s = Type.BOARD_GRIDSIZE;
      int below = (int)((y + h)/s) + 1;
      int L = (int)(x/s) ;
      int R = (int)((x+w)/s);
      stroke(255);
      for(int i = L; i <= R; i++){
            drawRect(below, i, s);
      }
      
   }
 
    public void showLeft(BasicProp o){
      float x = o.getX(), y = o.getY();
      float h = o.getHeight();
      float s = Type.BOARD_GRIDSIZE;
      int left = (int)(x/s) - 1;
      
      int U = (int)(y/s) ;
      int D = (int)((y+h)/s);
      stroke(155);
      for(int i = U; i <= D; i++){
            drawRect(i, left, s);
      }
      
      //int h1 = (int)(y/s);
      //int h2 = h1 + 1;
      //int h3 = h2 + 1;
      //     stroke(155);

      //drawRect(h1, left, s);
      //drawRect(h2, left, s);
      //drawRect(h3, left, s);

      
   }
   
   public void showRight(BasicProp o){
      float x = o.getX(), y = o.getY();
      float w = o.getWidth();
      float s = Type.BOARD_GRIDSIZE;
            float h = o.getHeight();

      int right = (int)((x + w)/s) + 1;
      
      int U = (int)(y/s) ;
      int D = (int)((y+h)/s);
      stroke(155);
      for(int i = U; i <= D; i++){
            drawRect(i, right, s);
      }
      
      //int h1 = (int)(y/s);
      //int h2 = h1 + 1;
      //int h3 = h2 + 1;
      //stroke(155);
      //drawRect(h1, right, s);
      //drawRect(h2, right, s);
      //drawRect(h3, right, s);

   }
   
   
   /**
   * Game start menu should be written here
   */
   public void drawMenuHomePage(){
   
   }
   
   public void drawMenuControl(){
   
   }
   
   public void drawGamePause(){
   
   }
   
   public void drawGameOver(){
   
   }
   
   public void drawGlobalList(){
   
   }
   
}
