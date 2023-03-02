public class Player extends BasicProp{
  
  public Player(int x, int y, int w, int h){
    this.setType(Type.PLAYER);
    this.setTransported(true);
    this.setX(x);
    this.setY(y);
    this.setWidth(w);
    this.setHeight(h);
  };
  
  /**
  * Using img instead of gifs, then use this constructor
  */
  public Player(int x, int y, int w, int h, String imgPath){
    this.setType(Type.PLAYER);
    this.setTransported(true);
    this.setX(x);
    this.setY(y);
    this.setWidth(w);
    this.setHeight(h);
    this.setImg(loadImage(imgPath));
    this.getImg().resize(w, h); 
  };
  
}
