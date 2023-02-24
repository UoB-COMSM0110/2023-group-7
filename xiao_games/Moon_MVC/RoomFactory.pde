public class RoomFactory extends Factory{    
    
    private EnemyFactory enemyFactory;
    private BlockFactory blockFactory;
   
    public RoomFactory(EnemyFactory e, BlockFactory b){
      this.enemyFactory = e;
      this.blockFactory = b;
    }
    
    public Room newRoom(int type){
        Room r;
        if(type == Type.ROOM_START){
           r =  generateStart(this.getId());
        }else if(type == Type.ROOM_UP){
           r =  generateUp(this.getId());
        }else if(type == Type.ROOM_DOWN){
           r =  generateDown(this.getId());
        }else{
           r =  generateLR(this.getId());
        }
        this.increaseId();
        return r;
    }
    
    private Room generateStart(int id){
        int i = (int)random(5);//0~4
        Room r;
        if(i == 0){
           r = roomType0();
        }else if(i == 1){
           r = roomType1();
        }else if(i == 2){
           r = roomType2();
        }else if(i == 3){
           r = roomType3();
        }else{
           r = roomType4();
        }
        r.setIndex(id);
        return r;
    }
    
    private Room generateUp(int id){
        int i = (int)random(10);//0~9
        Room r;
        if(i >= 0 && i < 3){
           r = roomType0();
        }else if(i >= 3 && i < 6){
           r = roomType3();
        }else if(i >=6 && i < 9){
           r = roomType4();
        }else{
          r = roomType5();
        }
        r.setIndex(id);
        return r;
    }
    
   private Room generateDown(int id){
        int i = (int)random(10);//0~9
        Room r;
        if(i >= 0 && i < 3){
           r =  roomType0();
        }else if(i >= 3 && i < 6){
           r = roomType1();
        }else if(i >=6 && i < 9){
           r = roomType4();
        }else{
           r = roomType5();
        }
        r.setIndex(id);
        return r;
    }
    
    private Room generateLR(int id){
        int i = (int)random(10);//0~9
        Room r;
        if(i >= 0 && i < 3){
           r = roomType2();
        }else if(i >= 3 && i < 6){
           r = roomType1();
        }else if(i >=6 && i < 9){
           r = roomType4();
        }else{
           r = roomType5();
        }
        r.setIndex(id);
        return r;
    }
    
    //TO DELETE
    void tmpBlock(Room r){
        r.blockType[3][5] = Type.BLOCK_GOLD;
        r.blockType[3][6] = Type.BLOCK_GOLD;
        
        
        //r.blockType[10][5] = Type.BLOCK_LADDER;
        //r.blockType[11][5] = Type.BLOCK_LADDER;
        //r.blockType[12][5] = Type.BLOCK_LADDER;
        //r.blockType[13][5] = Type.BLOCK_LADDER;
        
        r.blockType[13][6] = Type.BLOCK_GOLD;
        r.blockType[14][6] = Type.BLOCK_GOLD;
        r.blockType[14][7] = Type.BLOCK_GOLD;
        r.blockType[15][7] = Type.BLOCK_GOLD;
        r.blockType[15][8] = Type.BLOCK_GOLD;
        r.blockType[16][9] = Type.BLOCK_GOLD;
        r.blockType[17][8] = Type.BLOCK_GOLD;
        
        r.blockType[16][3] = Type.BLOCK_PORTAL;
        r.blockType[16][25] = Type.BLOCK_PORTAL;
        
        Block b1 = blockFactory.newBlock(Type.BLOCK_PORTAL);
        b1.setPos(16, 3);
        b1.setPortal(16, 25);
        r.addBlock(b1);
        
        Block b2 = blockFactory.newBlock(Type.BLOCK_PORTAL);
        b2.setPos(16, 25);
        b2.setPortal(16, 3);
        r.addBlock(b2);
        
        r.blockType[16][21] = Type.BLOCK_BOUNCE;
        Block b3 = blockFactory.newBlock(Type.BLOCK_BOUNCE);
        b3.setPos(16, 21);
        r.addBlock(b3);
        
        r.blockType[10][15] = Type.BLOCK_BOUNCE;
        Block b4 = blockFactory.newBlock(Type.BLOCK_BOUNCE);
        b4.setPos(10, 15);
        r.addBlock(b4);

        r.addEnemy(enemyFactory.newEnemy(Type.ENEMY_WORM));
        r.addEnemy(enemyFactory.newEnemy(Type.ENEMY_GUNNER));

    }
    
    // 0 |
    private Room roomType0(){
        //TO DELETE
        println("RoomType: 0 |");
        
        //TODO
        //new Room's block on boundary should be consistent with current Room
        //1. get current Room
        //2. check edge blocks of current Room
        //3. make sure blocks on adjacent sides of two rooms are consistent
        
        Room r = new Room();
        r.setType(0);
        
        for(int j = 0; j < 10; j++){
          for(int i = 0; i < 20; i++){
              r.blockType[i][j] = Type.BLOCK_WALL;//all blocks
          }
        }
        for(int j = 20; j < 29; j++){
          for(int i = 0; i < 20; i++){
              r.blockType[i][j] = Type.BLOCK_WALL;//all blocks
          }
        }
        
        // TO DELETE
        tmpBlock(r);
        
        return r;
    }
    
    // 1 丄
    private Room roomType1(){
        //TO DELETE
        println("RoomType: 1 丄");
        Room r = new Room();
        r.setType(1);
        
        for(int i = 0; i < 4; i++){
          for(int j = 0; j < 10; j++){
              r.blockType[i][j] = Type.BLOCK_WALL;//all blocks
          }
        }
        for(int i = 0; i < 4; i++){
          for(int j = 20; j < 29; j++){
              r.blockType[i][j] = Type.BLOCK_WALL;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 0; j < 29; j++){
              r.blockType[i][j] = Type.BLOCK_WALL;//all blocks
          }
        }
       
        // TO DELETE
        tmpBlock(r);

        return r;
    }
   
    // 2 一
    private Room roomType2(){
        //TO DELETE
        println("RoomType: 2 一");
        Room r = new Room();
        r.setType(2);
        
         for(int i = 0; i < 4; i++){
          for(int j = 0; j < 29; j++){
              r.blockType[i][j] = Type.BLOCK_WALL;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 0; j < 29; j++){
              r.blockType[i][j] = Type.BLOCK_WALL;//all blocks
          }
        }
        
        // TO DELETE
        tmpBlock(r);

        return r;
    }

    // 3 丅
    private Room roomType3(){
        //TO DELETE
        println("RoomType: 3 丅");
        Room r = new Room();
        r.setType(3);

         for(int i = 0; i < 4; i++){
          for(int j = 0; j < 29; j++){
              r.blockType[i][j] = Type.BLOCK_WALL;//all blocks
          }
        }
        
       for(int i = 16; i < 20; i++){
          for(int j = 0; j < 10; j++){
              r.blockType[i][j] = Type.BLOCK_WALL;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 20; j < 29; j++){
              r.blockType[i][j] = Type.BLOCK_WALL;//all blocks
          }
        }
        

        // TO DELETE
        tmpBlock(r);
        return r;
    }

    // 4 十
    private Room roomType4(){
         //TO DELETE
        println("RoomType: 4 十");
        Room r = new Room();
        r.setType(4);
        
        for(int i = 0; i < 4; i++){
          for(int j = 0; j < 10; j++){
              r.blockType[i][j] = Type.BLOCK_WALL;//all blocks
          }
        }
        for(int i = 0; i < 4; i++){
          for(int j = 20; j < 29; j++){
              r.blockType[i][j] = Type.BLOCK_WALL;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 0; j < 10; j++){
              r.blockType[i][j] = Type.BLOCK_WALL;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 20; j < 29; j++){
              r.blockType[i][j] = Type.BLOCK_WALL;//all blocks
          }
        }
        
        // TO DELETE
        tmpBlock(r);

        return r;
    }
    
    // 5
    private Room roomType5(){
        //TO DELETE
        println("RoomType: 5 ?");
        Room r = new Room();
        r.setType(5);
        // TO DELETE
        tmpBlock(r);
        return r;
    }

}
