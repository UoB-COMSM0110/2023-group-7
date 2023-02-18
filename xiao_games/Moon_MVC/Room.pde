public class Room extends HandleEnemies{
    private int type;
    private int index;
    private int[] adjacent;// 0-up, 1-down, 2-left, 3-right
    private int[][] blockType; // 0 == empty, 1 == block, 3 == chest...
    private ArrayList<Block> blocks;
    
    public Room(){
        this.blockType = new int[20][30];
        this.adjacent = new int[4];
        this.setEnemies();
        this.blocks = new ArrayList();
        for(int i = 0; i < 4; i++){
            this.adjacent[i] = -1;
        }
    }
    
    public void setType(int type){
        this.type = type;
    }
    
    public int getType(){
        return type;
    }
    
    public void setIndex(int i){
       this.index = i;
    }
    
    public int getIndex(){
        return index;
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
    
    public ArrayList<Block> getBlocks(){
       return this.blocks;
    }
    
    public void addBlock(Block block){
       this.blocks.add(block);
    }
    
}
