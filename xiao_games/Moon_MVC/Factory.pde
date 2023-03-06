 /**
 * Common properties and methods for all factory classes
 */
public class Factory{
    private int id;
    private ArrayList<PImage> imgs;

    public void setId(int id){
       this.id = id;
    }

    public int getId(){
       return this.id;
    }
    
    public void increaseId(){
       this.id++;
    }
    
    public void setImgs(ArrayList<PImage> imgs){
       this.imgs = imgs;
    }
    
   public ArrayList<PImage> getImgs(){
       return this.imgs;
    } 
    
    public void addImg(PImage img){
       this.imgs.add(img);
    } //<>// //<>// //<>// //<>//
    
    public PImage getImg(int i){
       return this.imgs.get(i);
    }

}
