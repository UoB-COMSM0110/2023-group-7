public class Player{
  private float x, y, size;
  private PImage img;
  private int jumpHeight;
  private boolean jump;
  
  public Player(int bornX, int bornY, int bornSize, String imgPath){
    this.x = bornX;
    this.y =  bornY;
    this.size = bornSize;
    this.img = loadImage(imgPath);
    this.img.resize(bornSize, 2 * bornSize); 
  };
  
  public float getSize(){
    return this.size;
  }
  
  public float getX(){
    return this.x;
  }
  public void setX(float newX){
    this.x = newX;
  }
  public float getY(){
    return this.y;
  }
  public void setY(float newY){
    this.y = newY;
  }
  
  public PImage getImg(){
    return this.img;
  }
  
  
}
