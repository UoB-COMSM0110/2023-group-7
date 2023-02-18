public class BlockFactory extends Factory{
    
    public BlockFactory(){
       this.setImgs(new ArrayList());
       this.setId(0);
       this.init();
    }
    
    public Block newBlock(int type){
       Block b = new Block(height/20);
       b.setType(type); 
       b.setId(this.getId());
       b.setImg(this.getImg(type));
       b.getImg().resize(height/20,height/20);
       this.increaseId();
       return b;
    }
    
    private void init(){
       this.addImg(loadImage("imgs/empty.png"));
       this.addImg(loadImage("imgs/wall.png"));
       this.addImg(loadImage("imgs/gold_core.png"));
       this.addImg(loadImage("imgs/ladder.png"));
    }
    

}
