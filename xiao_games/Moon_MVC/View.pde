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
     //draw room
     for(int i = 0; i < 20; i++){
        for(int j = 0; j < 29; j++){
          int type = r.blockType[i][j];
          Block b = model.getBlockByType(type);
          float sx = b.getWidth();
          image(b.getImg(), j * sx, i * sx);
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
            image(w.getImgs()[0],  p.getX() - w.getWidth(), p.getY() + p.getHeight()/3);
       }else{
            image(p.getGifs().get(1), p.getX(), p.getY());
            image(w.getImgs()[1],  p.getX() + p.getWidth(), p.getY() + p.getHeight()/3);
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
      int R = (int)((x + w)/s);
      int L = R - 1;
           stroke(255);

      drawRect(upper, R, s);
      drawRect(upper, L, s);

   }
 
    public void showDown(BasicProp o){
      float x = o.getX(), y = o.getY();
      float w = o.getWidth(), h = o.getHeight();
      float s = Type.BOARD_GRIDSIZE;
      int below = (int)((y + h)/s) + 1;
      int R = (int)((x + w)/s);
      int L = R - 1;
           stroke(255);

      drawRect(below, R, s);
      drawRect(below, L, s);
      
      
   }
 
    public void showLeft(BasicProp o){
      float x = o.getX(), y = o.getY();
      float s = Type.BOARD_GRIDSIZE;
      int left = (int)(x/s) - 1;
      int h1 = (int)(y/s);
      int h2 = h1 + 1;
      int h3 = h2 + 1;
           stroke(155);

      drawRect(h1, left, s);
      drawRect(h2, left, s);
      drawRect(h3, left, s);

      
   }
   
   public void showRight(BasicProp o){
      float x = o.getX(), y = o.getY();
      float w = o.getWidth();
      float s = Type.BOARD_GRIDSIZE;
      int right = (int)((x + w)/s) + 1;
      int h1 = (int)(y/s);
      int h2 = h1 + 1;
      int h3 = h2 + 1;
      stroke(155);
      drawRect(h1, right, s);
      drawRect(h2, right, s);
      drawRect(h3, right, s);

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
