public class Player extends BasicProperties{
  private PImage img;
  private int jumpHeight;
  private boolean jump;
  
  public Player(int bornX, int bornY, int bornSize, String imgPath){
    this.setX(bornX);
    this.setY(bornY);
    this.setSize(bornSize);
    this.img = loadImage(imgPath);
    this.img.resize(bornSize, 2 * bornSize); 
  };
  
  public PImage getImg(){
    return this.img;
  }
  
  
}
