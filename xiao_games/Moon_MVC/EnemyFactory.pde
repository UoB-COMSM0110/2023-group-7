public class EnemyFactory extends Factory{    
    
    public EnemyFactory(){
       this.setImgs(new ArrayList());
       this.setId(0);
       this.init(); //<>// //<>// //<>// //<>//
    }
    
    private void init(){
       this.addImg(loadImage("imgs/ememy/ghost.png")); //<>// //<>// //<>// //<>//
       this.addImg(loadImage("imgs/ememy/worm.png"));
       this.addImg(loadImage("imgs/ememy/gunner.png"));
    }
    
    public Enemy newEnemy(int type){
       Enemy e; 
       if(type == Type.ENEMY_GHOST){
           e = new Ghost((int)(height * 1.5/20), (int)(height * 1.5 /20)); //<>// //<>// //<>// //<>//
           e.setSpeed(15);
       }else if(type == Type.ENEMY_WORM){
           e = new Worm((int)(height/20), (int)(height * 0.5 /20));
           e.setX(random(width));
           e.setY(random(height));
           e.setSpeed(5);
       }else if(type == Type.ENEMY_GUNNER){
           e = new Gunner((int)(height/20), (int)(height * 1.5 /20));
           e.setSpeed(10);
       }else{
           e = new Enemy();
       } //<>// //<>// //<>// //<>//
       e.setId(this.getId());
       e.setType(type); 
       e.setImg(this.getImgs().get(type));
       e.getImg().resize(e.getSizeX(), e.getSizeY());
       this.increaseId();
       return e;
    }
    
}
