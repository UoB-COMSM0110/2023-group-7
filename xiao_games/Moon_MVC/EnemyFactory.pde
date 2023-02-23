public class EnemyFactory extends Factory{    
    
    public EnemyFactory(){
       this.setImgs(new ArrayList());
       this.setId(0);
       this.init();  //<>// //<>// //<>//
    }
    
    private void init(){
       this.addImg(loadImage("imgs/ememy/ghost.png"));  //<>// //<>// //<>//
       this.addImg(loadImage("imgs/ememy/worm.png"));
       this.addImg(loadImage("imgs/ememy/gunner.png"));
    }
    
    public Enemy newEnemy(int type){
       Enemy e; 
       if(type == Type.ENEMY_GHOST){
           e = new Ghost((int)(height * 1.5/20), (int)(height * 1.5 /20));  //<>// //<>// //<>//
       }else if(type == Type.ENEMY_WORM){
           e = new Worm((int)(height/20), (int)(height * 0.5 /20));
           e.setX(width/3);
           e.setY(height/2);
       }else if(type == Type.ENEMY_GUNNER){
           e = new Gunner((int)(height/20), (int)(height * 1.5 /20));
           e.setX(width * 2/3);
           e.setY(height/2);
       }else{
           e = new Enemy();
       } //<>// //<>//
       e.setId(this.getId());
       e.setImg(this.getImgs().get(type));
       e.getImg().resize(e.getWidth(), e.getHeight());
       this.increaseId();
       return e;
    }
    
}
