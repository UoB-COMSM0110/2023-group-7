/**
* @author imyuanxiao, participants
* Contains all data
*/
public class Model{
   private Map map;
   private Player player;
   private ItemFactory itemFactory;
   private EnemyFactory enemyFactory;
   private RoomFactory roomFactory;
   private BlockFactory blockFactory;
   //private ArrayList<Block> basicBlock;
   private ArrayList<Gif> gifs;

   private boolean isMusicPlaying = false;
   private boolean menuHomePage = false;
   private boolean menuControl = false;
   private boolean gameStart = true;
   private boolean gamePause = false;
   private boolean gameOver = false;
   private boolean globalList = false;

   
   public Model(){
       this.enemyFactory = new EnemyFactory();
       this.blockFactory = new BlockFactory();
       this.roomFactory = new RoomFactory(blockFactory);
       map = new Map();
       map.addEnemy(enemyFactory.newEnemy(Type.ENEMY_GHOST));  //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
       map.addRoom(roomFactory.newRoom(Type.ROOM_START));
       //this.basicBlock = new ArrayList();
       //this.init();
       
       // gameStart = true;
   }
   
   /**
   * Add all types of blocks to model, so View.class can get PImage of them more conveniently
   * Need to simplify this by only add PImage instead of ArrayList<Block>
   */
   //public void init(){
   //   basicBlock.add(blockFactory.newBlock(Type.BLOCK_EMPTY));
   //   basicBlock.add(blockFactory.newBlock(Type.BLOCK_WALL));
   //   basicBlock.add(blockFactory.newBlock(Type.BLOCK_GOLD));
   //   basicBlock.add(blockFactory.newBlock(Type.BLOCK_BOUNCE));
   //   basicBlock.add(blockFactory.newBlock(Type.BLOCK_PORTAL));
   //   basicBlock.add(blockFactory.newBlock(Type.BLOCK_BORDER));
   //   basicBlock.add(blockFactory.newBlock(Type.BLOCK_CRATE));
   //   basicBlock.add(blockFactory.newBlock(Type.BLOCK_SPIKE));
   //   basicBlock.add(blockFactory.newBlock(Type.BLOCK_PLATFORM));
   //}
      
    public void setGifs(ArrayList<Gif> gifs){
       this.gifs = gifs;
    }
    
    public ArrayList<Gif> getGifs(){
      return this.gifs;
    }
   
   
   public void addEnemiesToRoom(Room r){
       this.enemyFactory.addEnemiesToRoom(r);
   }
   
   public void addItemsToRoom(Room r){
        this.itemFactory.addItemsToRoom(r);
   }
   
   public void setItemFactory(ItemFactory t){
      this.itemFactory = t;
   }
   
   public BlockFactory getBlockFactory(){
      return this.blockFactory;
   }
   
   public Item newItem(int[] pos){
      return itemFactory.newItem(pos);
   }

   //public Block getBlockByType(int type){
   //  return basicBlock.get(type);
   //}
   
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


   //menuHomePage, menuControl, gameStart, gamePause, gameOver, globalList;
   
   public void setIsMusicPlaying(boolean flag){
       this.isMusicPlaying = flag;
   }
   
   public boolean getIsMusicPlaying(){
       return this.isMusicPlaying;
   }
   
   
   public void setMenuHomePage(boolean flag){
       this.menuHomePage = flag;
   }
   
   public boolean getMenuHomePage(){
       return this.menuHomePage;
   }
   
   public void setMenuControl(boolean flag){
       this.menuControl = flag;
   }
   
   public boolean getMenuControl(){
       return this.menuControl;
   }
   
   public void setGameStart(boolean flag){
       this.gameStart = flag;
   }
   
   public boolean getGameStart(){
       return this.gameStart;
   }
   
   public void setGamePause(boolean flag){
       this.gamePause = flag;
   }
   
   public boolean getGamePause(){
       return this.gamePause;
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
   
   public void useItemByPlayer(){
      itemFactory.useItemByPlayer(player);
   }
   
   public void enemiesMove(){
       ArrayList<Enemy> enemies = map.getCurrentRoom().getEnemies();
       
       for(int i = 0; i < enemies.size(); i++){
          enemies.get(i).move();
       }
   }

   
}
