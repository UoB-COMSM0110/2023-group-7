class Enemy extends BasicProp{
  private int[] spawn;

  Enemy(){};
   
  public void setSpawn(int[] spawn){
     this.spawn[0] = spawn[0];
     this.spawn[1] = spawn[1];
  }
  
  public void move(){
    
     if(getX() + getSizeX() > width){
         setX(getX() - getSpeed());
         return;
     }
     if(getX() < 0){
         setX(getX() + getSpeed());
         return;
     }
     
     int i = (int)random(4);
     if(i == 0 || i == 1){
          setX(getX()+ getSpeed());
     }else{
         setX(getX()- getSpeed());
     }
  }
  
}
