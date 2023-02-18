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
    
    // 0 |
    private Room roomType0(){
        //TO DELETE
        println("RoomType: 0 |");
        
        //TODO
        //new Room's block on edge should be consistent with current Room
        //1. get current Room
        //2. check edge blocks of current Room
        //3. make sure blocks on adjacent sides of two rooms are consistent
        
        Room r = new Room();
        r.setType(0);
        for(int j = 0; j < 10; j++){
          for(int i = 0; i < 20; i++){
              r.blockType[i][j] = Type.ITEM_WALL;//all blocks
          }
        }
        for(int j = 20; j < 30; j++){
          for(int i = 0; i < 20; i++){
              r.blockType[i][j] = Type.ITEM_WALL;//all blocks
          }
        }
        
        r.addEnemy(enemyFactory.newEnemy(Type.ENEMY_WORM));
        
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
              r.blockType[i][j] = Type.ITEM_WALL;//all blocks
          }
        }
        for(int i = 0; i < 4; i++){
          for(int j = 20; j < 30; j++){
              r.blockType[i][j] = Type.ITEM_WALL;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 0; j < 30; j++){
              r.blockType[i][j] = Type.ITEM_WALL;//all blocks
          }
        }
        
                r.addEnemy(enemyFactory.newEnemy(Type.ENEMY_WORM));

        return r;
    }
   
    // 2 一
    private Room roomType2(){
        //TO DELETE
        println("RoomType: 2 一");
        Room r = new Room();
        r.setType(2);
        
         for(int i = 0; i < 4; i++){
          for(int j = 0; j < 30; j++){
              r.blockType[i][j] = Type.ITEM_WALL;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 0; j < 30; j++){
              r.blockType[i][j] = Type.ITEM_WALL;//all blocks
          }
        }
        
        r.addEnemy(enemyFactory.newEnemy(Type.ENEMY_WORM));

        return r;
    }

    // 3 丅
    private Room roomType3(){
        //TO DELETE
        println("RoomType: 3 丅");
        Room r = new Room();
        r.setType(3);

         for(int i = 0; i < 4; i++){
          for(int j = 0; j < 30; j++){
              r.blockType[i][j] = Type.ITEM_WALL;//all blocks
          }
        }
        
       for(int i = 16; i < 20; i++){
          for(int j = 0; j < 10; j++){
              r.blockType[i][j] = Type.ITEM_WALL;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 20; j < 30; j++){
              r.blockType[i][j] = Type.ITEM_WALL;//all blocks
          }
        }
        
                r.addEnemy(enemyFactory.newEnemy(Type.ENEMY_WORM));

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
              r.blockType[i][j] = Type.ITEM_WALL;//all blocks
          }
        }
        for(int i = 0; i < 4; i++){
          for(int j = 20; j < 30; j++){
              r.blockType[i][j] = Type.ITEM_WALL;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 0; j < 10; j++){
              r.blockType[i][j] = Type.ITEM_WALL;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 20; j < 30; j++){
              r.blockType[i][j] = Type.ITEM_WALL;//all blocks
          }
        }
        
                r.addEnemy(enemyFactory.newEnemy(Type.ENEMY_WORM));

        return r;
    }
    
    // 5
    private Room roomType5(){
        //TO DELETE
        println("RoomType: 5 ?");
        Room r = new Room();
        r.setType(5);
        return r;
    }

}
