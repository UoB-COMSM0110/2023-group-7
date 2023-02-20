public class Model{
   private Map map;
   private Player player;
   //private int currentEnemyId;
   private int gridSize;
   private EnemyFactory enemyFactory;
   private RoomFactory roomFactory;
   private BlockFactory blockFactory;
   private ArrayList<Block> basicBlock;
   
   public Model(){
       this.enemyFactory = new EnemyFactory();
       this.blockFactory = new BlockFactory();
       this.roomFactory = new RoomFactory(enemyFactory, blockFactory);
       map = new Map();
       map.addEnemy(enemyFactory.newEnemy(Type.ENEMY_GHOST)); //<>//
       map.addRoom(roomFactory.newRoom(Type.ROOM_START));
       this.basicBlock = new ArrayList();
       this.init();
   }
   
   //add all types of blocks to model, so View.class can get PImage of them more conveniently
   public void init(){
      basicBlock.add(blockFactory.newBlock(Type.ITEM_EMPTY));
      basicBlock.add(blockFactory.newBlock(Type.ITEM_WALL));
      basicBlock.add(blockFactory.newBlock(Type.ITEM_GOLD));
      basicBlock.add(blockFactory.newBlock(Type.ITEM_LADDER));
   }
   
   public Block getBlockByType(int type){
     return basicBlock.get(type);
   }
   
   public Player getPlayer(){
       return this.player;
   }
   
   public void addPlayer(Player player){
        this.player = player;
   }
   
   public void setGridSize(int size){
      this.gridSize = size;
   }
   
   public int getGridSize(){
      return this.gridSize;
   }
   
   public ArrayList<Enemy> getEnemies(){
       return map.getEnemies();
   }
   
   //public void addBlock(Block block){
   //     this.block = block;
   //}
   
   //public float getBlockSize(){
   //   return block.getSizeX();
   //}
   
   //public PImage getBlockImg(int type){
   //   return block.getImg(type);
   //}
   
   public void addRoom(int type){
      map.addRoom(roomFactory.newRoom(type));
   }
   
   public Room getNewRoom(){
      return map.getNewRoom(roomFactory.getId() - 1);
   }
   
   public Room getCurrentRoom(){
      return map.getCurrentRoom();
   }
   
   public int getIndexByDirection(int type){
      return map.getIndexByDirection(type);
   }
   
   public void setCurrentRoomIndex(int index){
       map.setCurrentRoomIndex(index);
   }
   

   
   //public void setGameWin(boolean flag){
   //    this.gameWin = flag;
   //}
   
   //public void setGameOver(boolean flag){
   //    this.gameOver = flag;
   //}
   
   //public void setCurrentEnemyId(int enemyId){
   //    currentEnemyId = enemyId;
   //}
   
   //public int getCurrentEnemyId(){
   //    return currentEnemyId;
   //}
   
}
