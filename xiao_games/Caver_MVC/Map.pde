class Map{
    private Room[][] rooms;
    private int[] roomNum;
    
    public Map(){
        this.rooms = new Room[4][4];
        for(int i = 0; i < 4; i++){
            for(int j = 0; j < 4; j++){
                this.rooms[i][j] = new Room();
            }
        }
        this.generateMap();
    }
    
    public void setRoomNum(int i, int j){
        roomNum[0] += i;
        roomNum[1] += j;
    }
    
    public int[] getRoomNum(){
        return roomNum;
    }
    
    public Room getCurrentRoom(){
        return rooms[roomNum[0]][roomNum[1]];
    }
    
    //TO BE DELETE
    public Room[][] getRooms(){
       return rooms;
    }

    void generateMap(){
        // first room
        int x = 0;
        int y = (int)random(4);// 0 1 2 3
        roomNum = new int[]{x, y};
        this.genRoom(rooms[x][y], 1); // start room = 1
        int nextType = 1;
        int mov = (int)random(2) == 0 ? -1 : 1;
        //while left or right is end, choose down
        while (true){
            int nextX, nextY;
            int dir = (int)random(4);
            if(dir == 3){
                nextX = x + 1;
                nextY = y;
            }else{
                nextX = x;
                nextY = y + mov;
            }
            if(nextX >= 4){
                this.genRoom(rooms[x][y], 4);
                this.exitRoom(rooms[x][y]);
                break;
            }
            if(nextY == -1 || nextY == 4 || nextX == x + 1){
                //go down, change direction
                //if cur room is type 1 一, rebuild it to type 2 丅
                 //if cur room is type 3 丄, rebuild it to type 4 十
                if(rooms[x][y].roomType == 1){
                    this.genRoom(rooms[x][y], 2);
                }
                if(rooms[x][y].roomType == 3){
                    this.genRoom(rooms[x][y], 4);
                }
                nextX = ++x;
                nextY = y;
                if(x == 4){
                    this.genRoom(rooms[x-1][y], 4);
                    break;
                }
                //new room, type 3 丄 or type 4 十
                nextType = (int)random(2) + 3;
                this.genRoom(rooms[nextX][nextY], nextType);
                mov = -mov;
            }else {
                this.genRoom(rooms[nextX][nextY], 1);
                x = nextX;
                y = nextY;
            }
        }
        // other room, built randomly
        for(int i = 0; i < 4; i++){
            for(int j = 0; j < 4; j++){
                if(this.rooms[i][j].roomType == 0){
                    this.genRoom(rooms[i][j], 0);
                }
            }
        }
    }
    
    public void genRoom(Room room, int type){
        switch (type) {
            case 1:
                this.roomType1(room);
                break;
            case 2:
                this.roomType2(room);
                break;
            case 3:
                this.roomType3(room);
                break;
            case 4:
                this.roomType4(room);
                break;
            default:
                this.roomType0(room);
                break;
        }
    }

    // 0 口
    public void roomType0(Room r){
        r.desc = "口";
        r.roomType = 0;
        for(int i = 0; i < 20; i++){
          for(int j = 0; j < 30; j++){
              r.itemType[i][j] = 0;//all blocks
          }
        }
    }

    // 1 一
    public void roomType1(Room r){
        r.desc = "一";
        r.roomType = 1;
        for(int i = 0; i < 4; i++){
          for(int j = 0; j < 30; j++){
              r.itemType[i][j] = 1;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 0; j < 30; j++){
              r.itemType[i][j] = 1;//all blocks
          }
        }
    }

    // 2 丅
    public void roomType2(Room r){
        r.itemType = new int[20][30];
        r.desc = "丅";
        r.roomType = 2;
        for(int i = 0; i < 4; i++){
          for(int j = 0; j < 30; j++){
              r.itemType[i][j] = 1;//all blocks
          }
        }
        
       for(int i = 16; i < 20; i++){
          for(int j = 0; j < 10; j++){
              r.itemType[i][j] = 1;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 20; j < 30; j++){
              r.itemType[i][j] = 1;//all blocks
          }
        }
    }

    // 3 丄
    public void roomType3(Room r){
        r.desc = "丄";
        r.roomType = 3;
        for(int i = 0; i < 4; i++){
          for(int j = 0; j < 10; j++){
              r.itemType[i][j] = 1;//all blocks
          }
        }
        for(int i = 0; i < 4; i++){
          for(int j = 20; j < 30; j++){
              r.itemType[i][j] = 1;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 0; j < 30; j++){
              r.itemType[i][j] = 1;//all blocks
          }
        }
    }

    // 4 十
    public void roomType4(Room r){
        r.itemType = new int[20][30];
        r.desc = "十";
        r.roomType = 4;
        for(int i = 0; i < 4; i++){
          for(int j = 0; j < 10; j++){
              r.itemType[i][j] = 1;//all blocks
          }
        }
        for(int i = 0; i < 4; i++){
          for(int j = 20; j < 30; j++){
              r.itemType[i][j] = 1;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 0; j < 10; j++){
              r.itemType[i][j] = 1;//all blocks
          }
        }
        for(int i = 16; i < 20; i++){
          for(int j = 20; j < 30; j++){
              r.itemType[i][j] = 1;//all blocks
          }
        }
    }
    
    public void exitRoom(Room r){
        //r.desc += "出";
    }
    
}
