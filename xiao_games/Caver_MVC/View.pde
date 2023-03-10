public class View{
  private Model model;
  
  public View(Model mod){
     this.model = mod;    
  }
  
  public void paint(){
     background(200);
     drawRoom();
     drawPlayer();
     showPath();
  }
  
  public void drawRoom(){
     Room r = model.getCurrentRoom();
     int[] num = model.getRoomNum();
     println("Room: " + num[0] + ","+ num[1]);
     
     for(int i = 0; i < 20; i++){
        for(int j = 0; j < 30; j++){
          int k = r.itemType[i][j];
          float s = model.getBlockSize();
              drawBlock( j * s, i * s, k);
        }
      }
  }
  
  //TO BE DELETE
  public void showPath(){
      Room[][] rooms = model.getRooms();
      for(int i = 0; i < 4; i++){
        for(int j = 0; j < 4; j++){
           print(rooms[i][j].getDesc());
        }
        println("");
      }
  }
  
  public void drawBlock(float x, float y, int type){
        if(type != 0){
           PImage img = model.getBlockImg(type);
           image(img,x,y);
        }
  }
  
  public void drawPlayer(){
      Player p = model.getPlayer();
      image(p.getImg(), p.getX(), p.getY());
  }


}
