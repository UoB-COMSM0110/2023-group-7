/**
* @author imyuanxiao
* Class for handling enemies
*/
public class HandleEnemies{
   private ArrayList<Enemy> enemies;
   
   public void addEnemy(Enemy enemy){
       this.enemies.add(enemy);
   }
   
   public void setEnemies(){
       this.enemies = new ArrayList();
   }
   
   public ArrayList<Enemy> getEnemies(){
       return this.enemies;
   }
   
   public Enemy getEnemeyById(int id){
       for(int i = 0; i < enemies.size(); i++){
           Enemy enemy = enemies.get(i);
           if(enemy.getId() == id) return enemy;
       }
       return null;
   }
   
   public void removeEnemyById(int id){
       for(int i = 0; i < enemies.size(); i++){
           if(enemies.get(i).getId() == id){
              enemies.remove(i);
              println("remove" + id);
              return;
           }
       }
   }
   
}
