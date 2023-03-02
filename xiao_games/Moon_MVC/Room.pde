public class Room extends HandleEnemies{
    private int type;
    private int index;
    // 0-up, 1-down, 2-left, 3-right
    private int[] adjacent;
    private int[][] blockType;
    private ArrayList<Block> blocks;
    private String[] sections;
    private ArrayList<Bullet> bullets;

    public Room(){
        this.blockType = new int[20][29];
        this.adjacent = new int[4];
        this.setEnemies();
        this.bullets = new ArrayList();
        this.blocks = new ArrayList();
        for(int i = 0; i < 4; i++){
            this.adjacent[i] = Type.NO_ROOM;
        }
        sections = new String[14];
        sections[0]="levels/section1.csv";
        sections[1]="levels/section2.csv";
        sections[2]="levels/section3.csv";
        sections[3]="levels/section4.csv";
        sections[4]="levels/section5.csv";
        sections[5]="levels/section6.csv";  
        sections[6]="levels/section7.csv";
        sections[7]="levels/section8.csv";
        sections[8]="levels/section9.csv";
        sections[9]="levels/section10.csv";
        sections[10]="levels/section11.csv";
        sections[11]="levels/section12.csv";
        sections[12]="levels/section13.csv";
        sections[13]="levels/section14.csv";
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
    
    public String getSection(int i){
      return sections[i];
    }
    
    public void setAdjacent(int[] newIndex){
       for(int i = 0; i < 4; i++){
           if(newIndex[i] != Type.NO_ROOM){
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
    
    public int getBlockType(int i, int j){
       return blockType[i][j];
    }
    
    public Block getBlockByPos(int i, int j){
       for(int k = 0; k < blocks.size(); k++){
         int[] pos = blocks.get(k).getPos();
         if( pos[0] == i && pos[1] == j){
            return blocks.get(k);
         }
       }
       return null;
    }
    
    public ArrayList<Bullet> getBullets(){
       return bullets;
    }
    
    public void addBullet(Bullet b){
       this.bullets.add(b);
    }
    
}
