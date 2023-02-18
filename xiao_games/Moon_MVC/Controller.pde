public class Controller{
   Model model;
   
   public Controller(Model mod){
      this.model = mod;
   };
   
   public void display(){
      changeRoomNum();
      crashBlock();
   }
   
   public void changeRoomNum(){
      Player p = model.getPlayer();
      float x = p.getX();
      float y = p.getY();
      float sx = p.getSizeX();
      float sy = p.getSizeY();
      if(x <= 0){
         this.generateLeft();
         int index =model.getIndexByDirection(Type.KEY_LEFT);         
         model.setCurrentRoomIndex(index);
         p.setX(width - sx - 1);
      }else if(x + sx > width){
         this.generateRight(); 
         int index =model.getIndexByDirection(Type.KEY_RIGHT);
         model.setCurrentRoomIndex(index);
         p.setX(1);
      }else if(y < 0){
         this.generateUp(); 
         int index =model.getIndexByDirection(Type.KEY_UP);
         model.setCurrentRoomIndex(index);
         p.setY(height - sy -1);
      }else if(y + sy > height){
         this.generateDown(); 
         int index =model.getIndexByDirection(Type.KEY_DOWN);
         model.setCurrentRoomIndex(index);
         p.setY(1);
      }else{
         return;
      }
   }
   
   public void generateLeft(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.getAdjacent();
      if(adjacent[2] == -1){
         model.addRoom(Type.ROOM_LR);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{-1,-1,-1, curRoom.getIndex()});
         curRoom.setAdjacent(new int[]{-1,-1,newRoom.getIndex(),-1});
      }
   }
   
   public void generateRight(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.getAdjacent();
      if(adjacent[3] == -1){
         model.addRoom(Type.ROOM_LR);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{-1,-1,curRoom.getIndex(),-1});
         curRoom.setAdjacent(new int[]{-1,-1,-1, newRoom.getIndex()});
      }
   }
   
   public void generateUp(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.getAdjacent();
      if(adjacent[0] == -1){
         model.addRoom(Type.ROOM_UP);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{-1,curRoom.getIndex(),-1,-1});
         curRoom.setAdjacent(new int[]{newRoom.getIndex(),-1,-1,-1});
      }
   }
   
   public void generateDown(){
      Room curRoom = model.getCurrentRoom();
      int[] adjacent = curRoom.getAdjacent();
      if(adjacent[1] == -1){
         model.addRoom(Type.ROOM_DOWN);
         Room newRoom = model.getNewRoom();
         newRoom.setAdjacent(new int[]{curRoom.getIndex(),-1,-1,-1});
         curRoom.setAdjacent(new int[]{-1,newRoom.getIndex(),-1,-1});
      }
   }
   
   public void crashBlock(){
        Room r = model.getCurrentRoom();
        Player p = model.getPlayer();
        float x = p.getX();
        float y = p.getY();
        float sx = p.getSizeX();
        float sy = p.getSizeY();
        float bSize = model.getGridSize();
        
        int left_l = (int)(x/sx) - 1, left_r = (int)(x/sx);
        int right_l = (int)((x + sx)/sx), right_r = (int)((x + sx)/sx) + 1;
        int up_l = (int)(y/sx) - 1, up_r = (int)(y/sx);
        int down_l = (int)((y + sy)/sx), down_r = (int)((y + sy)/sx) + 1;        
        if(up_l >= 0 && down_r <= 19){
             if(keyCode == UP){
                  for(int i = up_l; i <= up_r; i++){
                    int left_line = left_r < 0 ? right_l : left_r;
                    int right_line = right_l > 29 ? left_r : right_l; 
                    for(int j = left_line; j <= right_line; j++){
                      int k = r.blockType[i][j];
                      if(k == Type.ITEM_WALL){
                          float by = i * bSize;
                          if(y <= by + bSize) p.setY(by + sx + 1);
                      }
                    }
                  }
             }
              if(keyCode == DOWN){
                   for(int i = down_l; i <= down_r; i++){
                    int left_line = left_r < 0 ? right_l : left_r;
                    int right_line = right_l > 29 ? left_r : right_l; 
                    for(int j = left_line; j <= right_line; j++){
                      int k = r.blockType[i][j];
                      if(k == Type.ITEM_WALL){
                          float by = i * bSize;
                          if(y + sy >= by) p.setY(by - sy - 5);
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
                      int k = r.blockType[i][j];
                      if(k == Type.ITEM_WALL){
                          float bx = j * bSize;
                          if(x <= bx + bSize) p.setX(bx + bSize + 1);              
                      }
                    } 
                  }
              }
              if(keyCode == RIGHT){
                  for(int i = up_r; i <= down_l; i++){
                    for(int j = right_l; j <= right_r; j++){
                      int k = r.blockType[i][j];
                      if(k == Type.ITEM_WALL){
                          float bx = j * bSize;
                          if(x + sx >= bx) p.setX(bx - sx - 1);          
                      }
                    } 
                  }
              }
       }
    }
   
   public void moveEnemy(){
     //change ghost pos
     
     //change player pos
     
     
     //change enemy pos in current room
     
   }
   
   
   public void movePlayer(int dir){
     Player p = model.getPlayer();
     if(dir == Type.KEY_LEFT){
        p.setX(p.getX() - p.getSpeed());
     }else if(dir == Type.KEY_RIGHT){
        p.setX(p.getX() + p.getSpeed());
     }else if(dir == Type.KEY_UP){
        p.setY(p.getY() - p.getSpeed());
     }else if(dir == Type.KEY_DOWN){
        p.setY(p.getY() + p.getSpeed());
     }
   }

}
