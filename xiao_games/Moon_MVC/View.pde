public class View{
  private Model model;
  
  public View(Model mod){
     this.model = mod;    
  }
  
  public void paint(){
     background(200);
     drawRoom();
     drawEnemy();
     drawPlayer();
     showDectRange();
  }
  
  public void drawEnemy(){
      drawGhost();
      //drawEnemyInRoom();
  }
  
  public void drawGhost(){
        Player p = model.getPlayer();
       ArrayList<Enemy> enemies = model.getEnemies();
       for(int i = 0; i < enemies.size(); i++){
           Enemy e = enemies.get(i);
           e.move();
           //e.move(p.getX(), p.getY());
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
          float sx = b.getSizeX();
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
  
  //public void drawBlock(float x, float y, int type){
  //      if(type != 0){
  //         PImage img = model.getBlockImg(type);
  //         image(img,x,y);
  //      }
  //}
  
  public void drawPlayer(){
      Player p = model.getPlayer();
      image(p.getImg(), p.getX(), p.getY());
  }


    public void showDectRange(){
        Room r = model.getCurrentRoom();
        Player p = model.getPlayer();
        float x = p.getX();
        float y = p.getY();
        float sx = p.getSizeX();
        float sy = p.getSizeY();
        
        int left_l = (int)(x/sx) - 1, left_r = (int)(x/sx);
        int right_l = (int)((x + sx)/sx), right_r = (int)((x + sx)/sx) + 1;
        int up_l = (int)(y/sx) - 1, up_r = (int)(y/sx);
        int down_l = (int)((y + sy)/sx), down_r = (int)((y + sy)/sx) + 1;
        
         //only check blocks which player towards
        if(up_l >= 0 && down_r <= 19){
             if(keyCode == UP){
                  for(int i = up_l; i <= up_r; i++){
                    //avoid 'index out of bound' exception
                    int left_line = left_r < 0 ? right_l : left_r;
                    int right_line = right_l > 29 ? left_r : right_l; 
                    for(int j = left_line; j <= right_line; j++){
                           drawDectRect(i, j);
                    }
                  }
             }
              if(keyCode == DOWN){
                   for(int i = down_l; i <= down_r; i++){
                    int left_line = left_r < 0 ? right_l : left_r;
                    int right_line = right_l > 29 ? left_r : right_l; 
                    for(int j = left_line; j <= right_line; j++){
                           drawDectRect(i, j);
                    }
                   }
              }
           }
           if(left_l >= 0 && right_r <= 29){
              if(keyCode == LEFT){
                  for(int i = up_r; i <= down_l; i++){
                    for(int j = left_l; j <= left_r; j++){
                           drawDectRect(i, j);
                    } 
                  }
              }
              if(keyCode == RIGHT){
                  for(int i = up_r; i <= down_l; i++){
                    for(int j = right_l; j <= right_r; j++){
                         drawDectRect(i, j);
                    } 
                  }
              }
       }
    }
    
    void drawDectRect(int i , int j){
       noFill();
       stroke(255);
       strokeWeight(1);
       rect(j * model.getGridSize(),i * model.getGridSize(), model.getGridSize(), model.getGridSize());
    }

}
