class Block {
    private PImage img;
    private int size;
    public Block(int size){
       this.size = size;
    }
    
    public int getSize(){
       return this.size;
    }
    
    public PImage getImg(int type){
        if(type == 1){
            this.img = loadImage("imgs/clod.png");
        }else if(type == 2){
            this.img = loadImage("imgs/iron_core.png");
        }else if(type == 3){
            this.img = loadImage("imgs/gold_core.png");
        }else{
            this.img = loadImage("imgs/empty.png");
        }
        this.img.resize(this.size, this.size); 
        return img;
    }

}
