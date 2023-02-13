class Room{
    boolean left, right, up, down, init;
    int roomType;
    int[][] itemType; // 0 == empty, 1 == block, 2 == enemy, 3 == chest
    
    String desc;
    boolean visible;
    Room(){
        this.roomType = 0;
        this.desc = "";
        this.itemType = new int[20][30];
    };
}
