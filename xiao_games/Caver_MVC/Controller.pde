public class Controller{
   Model model;
   
   public Controller(Model mod){
      this.model = mod;
   };
   
   public void display(){
      changeRoomNum();
      crashWall();
   }
   
   public void changeRoomNum(){
      Player p = model.getPlayer();
      int[] roomNum = model.getRoomNum();
      float x = p.getX();
      float y = p.getY();
      float s = p.getSize();
      println("p.x: "+ x + "p.y: " + y);
      if(x <= 0 && roomNum[1] > 0){
         model.setRoomNum(0, -1);
         p.setX(width - s - 1);
      }else if(x + s > width && roomNum[1] < 3){
         model.setRoomNum(0, 1);
         p.setX(1);
      }else if(y < 0 && roomNum[0] > 0){
         model.setRoomNum(-1, 0);
         p.setY(height - s * 2 -1);
      }else if(y + s * 2 > height && roomNum[0] < 3){
         model.setRoomNum(1, 0);
         p.setY(1);
      }else{
         return;
      }
   }
   
   public void crashWall(){
        
        Room r = model.getCurrentRoom();
        Player p = model.getPlayer();
        float x = p.getX();
        float y = p.getY();
        float s = p.getSize();
        int bSize = model.getBlockSize();
        
        int left_l = (int)(x/s) - 1, left_r = (int)(x/s);
        int right_l = (int)((x + s)/s), right_r = (int)((x + s)/s) + 1;
        int up_l = (int)(y/s) - 1, up_r = (int)(y/s);
        int down_l = (int)((y + 2 * s)/s), down_r = (int)((y + 2 * s)/s) + 1;        
        println("left_l:" + left_l + ", right_l:"  + right_l + ", up_l:" + up_l + ", down_l:"  + down_l);
        if(up_l >= 0 && down_r <= 19){
             if(keyCode == UP){
                  for(int i = up_l; i <= up_r; i++){
                    int left_line = left_r < 0 ? right_l : left_r;
                    int right_line = right_l > 29 ? left_r : right_l; 
                    for(int j = left_line; j <= right_line; j++){
                      int k = r.itemType[i][j];
                      if(k == 1){
                          float by = i * bSize;
                          if(y <= by + bSize) p.setY(by + s + 1);
                      }
                    }
                  }
             }
              if(keyCode == DOWN){
                   for(int i = down_l; i <= down_r; i++){
                    int left_line = left_r < 0 ? right_l : left_r;
                    int right_line = right_l > 29 ? left_r : right_l; 
                    println("left: " + left_line + ", right:" + right_line);
                    for(int j = left_line; j <= right_line; j++){
                      int k = r.itemType[i][j];
                      if(k == 1){
                          float by = i * bSize;
                          if(y + 2 * s >= by) p.setY(by - 2 * s - 5);
                      }
                    }
                   }
              }
           }
           if(left_l >= 0 && right_r <= 29 &&
           up_r >= 0 && down_l <= 19){
              if(keyCode == LEFT){
                  for(int i = up_r; i <= down_l; i++){
                    for(int j = left_l; j <= left_r; j++){
                      int k = r.itemType[i][j];
                      if(k == 1){
                          float bx = j * bSize;
                          if(x <= bx + bSize) p.setX(bx + bSize + 1);              
                      }
                    } 
                  }
              }
              if(keyCode == RIGHT){
                  for(int i = up_r; i <= down_l; i++){
                    for(int j = right_l; j <= right_r; j++){
                      int k = r.itemType[i][j];
                      if(k == 1){
                          float bx = j * bSize;
                          if(x + s >= bx) p.setX(bx - s - 1);          
                      }
                    } 
                  }
              }
       }
    }
   
   public void changePlayerPos(int type){
     Player p = model.getPlayer();
     if(type == 1){
        p.setX(p.getX() - 15);
     }else if(type == 2){
        p.setX(p.getX() + 15);
     }else if(type == 3){
        p.setY(p.getY() - 15);
     }else if(type == 4){
        p.setY(p.getY() + 15);
     }
   }
   

}
