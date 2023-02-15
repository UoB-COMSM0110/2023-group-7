class Block {
    private PImage img0, img1, img2, img3;
    private int size;
    public Block(int size){
       this.size = size;
       this.img0 = loadImage("imgs/empty.png");
       this.img1 = loadImage("imgs/clod.png");
       this.img2 = loadImage("imgs/iron_core.png");
       this.img3 = loadImage("imgs/gold_core.png");
       img0.resize(size, size);
       img1.resize(size, size);
       img2.resize(size, size);
       img3.resize(size, size);
    }
    
    public int getSize(){
       return this.size;
    }
    
    public PImage getImg(int type){
        if(type == 1){
            return img1;
        }else if(type == 2){
            return this.img2;
        }else if(type == 3){
            return this.img3;
        }else{
            return this.img0;
        }
    }
    
    //public PImage getImg(int type){
    //    if(type == 1){
    //        this.img = loadImage("imgs/clod.png");
    //    }else if(type == 2){
    //        this.img = loadImage("imgs/iron_core.png");
    //    }else if(type == 3){
    //        this.img = loadImage("imgs/gold_core.png");
    //    }else{
    //        this.img = loadImage("imgs/empty.png");
    //    }
    //    this.img.resize(this.size, this.size); 
    //    return img;
    //}

}
