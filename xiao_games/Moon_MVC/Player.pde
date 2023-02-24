public class Player extends BasicProp{
  
  private boolean left;
  
  public Player(int x, int y, int w, int h, String imgPath){
    this.left = false;
    this.setType(Type.PLAYER);
    this.setX(x);
    this.setY(y);
    this.setWidth(w);
    this.setHeight(h);
    this.setImg(loadImage(imgPath));
    this.getImg().resize(w, h); 
  };
  
  public void setLeft(boolean flag){
     this.left = flag;
  }
  
  public boolean getLeft(){
     return left;
  }
  
}
