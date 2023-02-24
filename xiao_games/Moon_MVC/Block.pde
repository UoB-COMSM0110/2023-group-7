class Block extends BasicProp{
   
    private int[] pos;//where this block is, the position in itemType[][] in Room.class
    private int[] portal;//where portal block can transfer palyer to

    public Block(int size){
       this.portal = new int[2];
       this.pos = new int[2];
       this.setWidth(size);
       this.setHeight(size);
    } //<>//
    
    public int[] getPos(){
       return pos;
    }
    
    public void setPos(int i, int j){
       this.portal[0] = i;
       this.portal[1] = j;
    }
    
    public int[] getPortal(){
       return portal;
    }
    
    public void setPortal(int i, int j){
       this.pos[0] = i;
       this.pos[1] = j;
    }
    
}
