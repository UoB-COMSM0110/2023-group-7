public class View{
  private Model model;
  
  public View(Model mod){
     this.model = mod;    
  }
  
  public void paint(){
     drawRoom();
     drawEnemy();
     drawPlayer();
     showDectRange();
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
        for(int j = 0; j < 30; j++){
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
          image(e.getImg(), e.getX(), e.getY());
      }
      
  }
  
  public void drawPlayer(){
      Player p = model.getPlayer();
      image(p.getImg(), p.getX(), p.getY());
  }


    public void showDectRange(){
      Player p = model.getPlayer();
      float x = p.getX();
      float y = p.getY();
      float sx = p.getWidth();
      float sy = p.getHeight();
      float bSize = model.getGridSize();      
      int left, right, upper, below, L, R, h1, h2, h3;
      //check block left
      //left = (int)((x)/bSize) - 1;
      //h1 = (int)(y/bSize);
      //h2 = h1 + 1;
      //h3 = h1 + 2;
      //drawDectRect(h1,left);
      //drawDectRect(h2, left);
      //drawDectRect(h3, left);

      //check block right
      //right = (int)((x + sx)/bSize) + 1;
      //drawDectRect(h1,right);
      //drawDectRect(h2, right);
      //drawDectRect(h3, right);

      ////check block upper
      //upper = (int)(y/bSize) - 1;
      //R = (int)((x + sx)/bSize);
      //L = R - 1;
      //drawDectRect(upper, L);
      //drawDectRect(upper, R);

      //check block below
      below = (int)((y + sy)/bSize)+1;
      R = (int)((x + sx)/bSize);
      L = R - 1;
      drawDectRect(below, L);
      drawDectRect(below, R);

    }
    
    
    void drawDectRect(int i , int j){
       noFill();
       stroke(255);
       strokeWeight(1);
       rect(j * model.getGridSize(),i * model.getGridSize(), model.getGridSize(), model.getGridSize());
    }

}
