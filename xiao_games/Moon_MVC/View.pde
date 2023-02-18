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
           e.move(p.getX(), p.getY());
           println("Ghost.X: "+ e.getX() + ", Ghost.Y: "+ e.getY());
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


}
