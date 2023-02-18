public class Player extends BasicProp{
    
  public Player(int x, int y, int sizeX, int sizeY, int speed, String imgPath){
    this.setX(x);
    this.setY(y);
    this.setSizeX(sizeX);
    this.setSizeY(sizeY);
    this.setSpeed(speed);
    this.setImg(loadImage(imgPath));
    this.getImg().resize(sizeX, sizeY); 
  };
  
}
