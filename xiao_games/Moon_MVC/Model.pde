public class Model{
   private Map map;
   private Player player;
   private ArrayList<Enemy> enemies;
   private boolean gameOver;
   private boolean gameWin;
   private int currentEnemyId;
   private Block block;
   
   public Model(){
       //create map
       map = new Map();
   }
   
   public Player getPlayer(){
       return this.player;
   }
   
   public void addPlayer(Player player){
        this.player = player;
   }
   
   public void addBlock(Block block){
        this.block = block;
   }
   
   public float getBlockSize(){
      return block.getSize();
   }
   
   public PImage getBlockImg(int type){
      return block.getImg(type);
   }
   
   public int getIndexByDirection(int type){
      return map.getIndexByDirection(type);
   }
   
   public void setCurrentRoomIndex(int index){
       map.setCurrentRoomIndex(index);
   }
   
   public Room getNewRoom(){
      return map.getNewRoom();
   }
   
   public Room getCurrentRoom(){
      return map.getCurrentRoom();
   }
   
   public void addRoom(int type){
      map.addRoom(type);
   }
   
   public void setGameWin(boolean flag){
       this.gameWin = flag;
   }
   
   public void setGameOver(boolean flag){
       this.gameOver = flag;
   }
   
   public void addEnemy(Enemy enemy){
       this.enemies.add(enemy);
   }
   
   public void setCurrentEnemyId(int enemyId){
       currentEnemyId = enemyId;
   }
   
   public int getCurrentEnemyId(){
       return currentEnemyId;
   }
   
   public Enemy getEnemeyById(int id){
       for(int i = 0; i < enemies.size(); i++){
           Enemy enemy = enemies.get(i);
           if(enemy.getId() == id) return enemy;
       }
       return null;
   }
   
   public void removeEnemy(){
       
   //    this.enemies.remove();
   //}
   }
   
   

}
