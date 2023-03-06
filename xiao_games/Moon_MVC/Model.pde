/**
* Contains all data
*/
public class Model{
   private Map map;
   private Player player;
   private EnemyFactory enemyFactory;
   private RoomFactory roomFactory;
   private BlockFactory blockFactory;
   private ArrayList<Block> basicBlock;
   private ArrayList<Gif> gifs;
   private boolean startMenu, startGame, gameOver, globalList, instructions;
   
   public Model(){
       this.enemyFactory = new EnemyFactory();
       this.blockFactory = new BlockFactory();
       this.roomFactory = new RoomFactory(enemyFactory, blockFactory);
       map = new Map();
       map.addEnemy(enemyFactory.newEnemy(Type.ENEMY_GHOST));  //<>// //<>// //<>//
       map.addRoom(roomFactory.newRoom(Type.ROOM_START));
       this.basicBlock = new ArrayList();
       this.init();
       
       this.startGame = true;
   }
   
   /**
   * Add all types of blocks to model, so View.class can get PImage of them more conveniently
   */
   public void init(){
      basicBlock.add(blockFactory.newBlock(Type.BLOCK_EMPTY));
      basicBlock.add(blockFactory.newBlock(Type.BLOCK_WALL));
      basicBlock.add(blockFactory.newBlock(Type.BLOCK_GOLD));
      basicBlock.add(blockFactory.newBlock(Type.BLOCK_BOUNCE));
      basicBlock.add(blockFactory.newBlock(Type.BLOCK_PORTAL));
      basicBlock.add(blockFactory.newBlock(Type.BLOCK_BORDER));
      basicBlock.add(blockFactory.newBlock(Type.BLOCK_CRATE));
      basicBlock.add(blockFactory.newBlock(Type.BLOCK_SPIKE));
   }
   
    public void setGifs(ArrayList<Gif> gifs){
       this.gifs = gifs;
    }
    
    public ArrayList<Gif> getGifs(){
      return this.gifs;
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
   
   public ArrayList<Enemy> getEnemies(){
       return map.getEnemies();
   }
      
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
   
   public Enemy getGhost(){
      return map.getEnemeyById(0);
   }

   public void setStartMenu(boolean flag){
       this.startMenu = flag;
   }
   
   public boolean getStartMenu(){
       return this.startMenu;
   }
   
   public void setStartGame(boolean flag){
       this.startGame = flag;
   }
   
   public boolean getStartGame(){
       return this.startGame;
   }
   
   public void setGameOver(boolean flag){
       this.gameOver = flag;
   }
   
   public boolean getGameOver(){
       return this.gameOver;
   }
   
   public void setGlobalList(boolean flag){
       this.globalList = flag;
   }
   
   public boolean getGlobalList(){
       return this.globalList;
   }
   
   public void setInstructions(boolean flag){
       this.instructions = flag;
   }
   
   public boolean getInstructions(){
       return this.instructions;
   }
   
}
