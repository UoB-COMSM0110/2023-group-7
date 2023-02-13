class Block {
    PImage img;
    boolean visible;
    int size;
    Block(){
      this.size = height/20;
       this.img = loadImage("imgs/clod.png");
       this.img.resize(this.size, this.size); 
    }

    public void drawBolck(float x, float y){
        fill(255);
        //rect(this.x, this.y, height/20, width*20/height);
        image(this.img,x,y);
        noFill();
    }
}
