/**
* BlockFactory is reponsible for generating new Block object.
*/
public class BlockFactory extends Factory{
    
    public BlockFactory(){
       this.setImgs(new ArrayList());
       this.setId(0);
       this.init();
    }
    
    /**
    * Return a new Block object according to type passed in
    */
    public Block newBlock(int type){
       Block b = new Block(Type.BOARD_GRIDSIZE);
       b.setType(type); 
       b.setId(this.getId());
       b.setImg(this.getImg(type));
       b.getImg().resize(Type.BOARD_GRIDSIZE,Type.BOARD_GRIDSIZE);
       this.increaseId();
       return b;
    }
    
    /**
    * Preload all imgs for all typee of blocks
    */
    private void init(){
       this.addImg(loadImage("imgs/empty.png"));
       this.addImg(loadImage("imgs/wall.png"));
       this.addImg(loadImage("imgs/gold.png"));
       this.addImg(loadImage("imgs/bounce_up.png"));
       this.addImg(loadImage("imgs/portal.png"));
       this.addImg(loadImage("imgs/border.png"));
       this.addImg(loadImage("imgs/crate.png"));
       this.addImg(loadImage("imgs/spike.png"));
    }
    

}
