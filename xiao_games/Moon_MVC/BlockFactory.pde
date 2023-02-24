public class BlockFactory extends Factory{
    
    public BlockFactory(){
       this.setImgs(new ArrayList());
       this.setId(0);
       this.init();
    }
    
    public Block newBlock(int type){
       Block b = new Block(Type.BOARD_GRIDSIZE);
       b.setType(type); 
       b.setId(this.getId());
       b.setImg(this.getImg(type));
       b.getImg().resize(Type.BOARD_GRIDSIZE,Type.BOARD_GRIDSIZE);
       this.increaseId();
       return b;
    }
    
    private void init(){
       this.addImg(loadImage("imgs/empty.png"));
       this.addImg(loadImage("imgs/wall.png"));
       this.addImg(loadImage("imgs/gold.png"));
       this.addImg(loadImage("imgs/bounce_up.png"));
       this.addImg(loadImage("imgs/portal.png"));
    }
    

}
