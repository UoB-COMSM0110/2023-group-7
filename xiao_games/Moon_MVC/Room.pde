public class Room{
    //private boolean left, right, up, down, init;
    private int type;
    private int index;
    private int[] adjacent;// 0-up, 1-down, 2-left, 3-right
    private int[][] itemType; // 0 == empty, 1 == block, 2 == enemy, 3 == chest
    
    public Room(){
        this.itemType = new int[20][30];
        this.adjacent = new int[4];
        for(int i = 0; i < 4; i++){
            this.adjacent[i] = -1;
        }
    }
    
    public void setAdjacent(int[] newIndex){
       for(int i = 0; i < 4; i++){
           if(newIndex[i] != -1){
              this.adjacent[i] = newIndex[i];
           }
       }
    }
    
    public int[] getAdjacent(){
       return this.adjacent;
    }
    
    public int getIndex(){
        return index;
    }
    
    public void setIndex(int i){
       this.index = i;
    }
    
    public void setType(int type){
        this.type = type;
    }
    
    public int getType(){
        return type;
    }
    
}
