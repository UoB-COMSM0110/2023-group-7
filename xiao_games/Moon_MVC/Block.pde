class Block extends BasicProperties{
    private ArrayList<PImage> imgs;
    public Block(int size){
       this.setSize(size);
       this.imgs = new ArrayList();
       this.init();
    }
    
    private void init(){
       this.imgs.add(loadImage("imgs/empty.png"));
       this.imgs.add(loadImage("imgs/clod.png"));
       this.imgs.add(loadImage("imgs/iron_core.png"));
       this.imgs.add(loadImage("imgs/gold_core.png"));
       int size = (int)this.getSize();
       for(int i = 0; i < imgs.size(); i++){
           imgs.get(i).resize(size, size);
       }
    }
    
    public PImage getImg(int type){
        return this.imgs.get(type);
    }

}
