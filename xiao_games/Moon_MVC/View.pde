public class View{
  private Model model;
  
  public View(Model mod){
     this.model = mod;    
  }
  
  public void paint(){
     drawRoom();
     drawEnemy();
     drawPlayer();     
     showAround(model.getPlayer());
  }
  
  public void drawEnemy(){
      drawGhost();
  }
  
  public void drawGhost(){
       ArrayList<Enemy> enemies = model.getEnemies();
       for(int i = 0; i < enemies.size(); i++){
           Enemy e = enemies.get(i);
           e.move(model.getPlayer().getX(), model.getPlayer().getY());
           image(e.getImg(), e.getX(), e.getY());
       }
  }
  
  
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
          showAround(e);
          image(e.getImg(), e.getX(), e.getY());
      }
      
  }
  
  public void drawPlayer(){
      Player p = model.getPlayer();
      image(p.getImg(), p.getX(), p.getY());
  }
  
  public void drawRect(float i, float j, float s){
     noFill();
     strokeWeight(1);
     rect(j * s, i * s, s, s);
  }

  public void showAround(BasicProp o){
       showLeft(o);
       showRight(o);
       showUp(o);
       showDown(o); 
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
    
    void drawDectRect(int i , int j){
       noFill();
       stroke(255);
       strokeWeight(1);
       rect(j * Type.BOARD_GRIDSIZE,i * Type.BOARD_GRIDSIZE, Type.BOARD_GRIDSIZE, Type.BOARD_GRIDSIZE);
    }

}
