public class Room{
    private boolean left, right, up, down, init;
    private int roomType;
    private int[][] itemType; // 0 == empty, 1 == block, 2 == enemy, 3 == chest
    private String desc;
    public Room(){
        this.roomType = 0;
        this.desc = "";
        this.itemType = new int[20][30];
    }
    
    //TO BE DELETE
    public String getDesc(){
       return desc;
    }
    
    //TO BE DELETE
    public void setDesc(String d){
       this.desc = d;
    }    
    
}
