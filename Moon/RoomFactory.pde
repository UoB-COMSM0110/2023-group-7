import java.util.*;

/**
* @author Edsat, imyuanxiao
* Factry for room generation. When player enter a new room, this class will generate a new room with different structure.
*/
public class RoomFactory extends Factory{    
    
    //private EnemyFactory enemyFactory;
    private BlockFactory blockFactory;
    private final int sectionSize=9;
    private String[] level;
    private List<Integer> sectionIndex = new ArrayList<>(14);
    private boolean portal;
    private int[] portalCoordinates = new int[4];
   
    public RoomFactory(BlockFactory b){
      //this.enemyFactory = e;
      this.blockFactory = b;
      for(int i=0; i<14; i++){
        sectionIndex.add(i);
      }
    }
    
    public int getSectionIndex(int i){
      return sectionIndex.get(i);
    }
    
    public Room newRoom(int type){
        Room r;
        if(type == Type.ROOM_START){
           r =  generateStart(this.getId());
        }else if(type == Type.ROOM_UP){
           r =  generateUp(this.getId());
        }else if(type == Type.ROOM_DOWN){
           r =  generateDown(this.getId());
        }else{
           r =  generateLR(this.getId());
        }
        this.increaseId();
        return r;
        
    }
    
    private Room generateStart(int id){
        int i = (int)random(5);//0~4
        Room r;
        if(i == 0){
           r = roomType0();
        }else if(i == 1){
           r = roomType1();
        }else if(i == 2){
           r = roomType2();
        }else if(i == 3){
           r = roomType3();
        }else{
           r = roomType4();
        }
        r.setIndex(id);
        return r;
    }
    
    private Room generateUp(int id){
        int i = (int)random(10);//0~9
        Room r;
        if(i >= 0 && i < 3){
           r = roomType0();
        }else if(i >= 3 && i < 6){
           r = roomType3();
        }else{
           r = roomType4();
        }
        r.setIndex(id);
        return r;
    }
    
   private Room generateDown(int id){
        int i = (int)random(10);//0~9
        Room r;
        if(i >= 0 && i < 3){
           r =  roomType0();
        }else if(i >= 3 && i < 6){
           r = roomType1();
        }else if(i >=6 && i < 9){
           r = roomType4();
        }else{
           r = roomType5();
        }
        r.setIndex(id);
        return r;
    }
    
    private Room generateLR(int id){
        int i = (int)random(10);//0~9
        Room r;
        if(i >= 0 && i < 3){
           r = roomType1();
        }else if(i >= 3 && i < 6){
           r = roomType2();
        }else{
           r = roomType4();
        }
        r.setIndex(id);
        return r;
    }
    
    private void generateLevel(Room r){
      this.level = new String[6];
      Collections.shuffle(sectionIndex);
      for(int i=0; i<6; i++){
        int section = getSectionIndex(i);
        level[i]=r.getSection(section);
      }
    }
    
    private void addSection(String filename, Room r, int rowNum, int colNum)
    {
      setPortal(false);
      String[] lines = loadStrings(filename);
      for(int row=0; row<sectionSize; row++){
        String[] values=split(lines[row],",");
        for(int col=0; col<sectionSize; col++){
          switch(values[col].codePointAt(0)){
            case '1':
              if(blockOrCrystal()){
                r.blockType[rowNum+row][colNum+col] = Type.BLOCK_CRYSTAL;
            }else if(!blockOrCrystal()){
              r.blockType[rowNum+row][colNum+col] = Type.BLOCK_WALL;
            }
              break;
            case '2':
              r.blockType[rowNum+row][colNum+col] = Type.BLOCK_BOUNCE;
              break;
            case '3':
              r.blockType[rowNum+row][colNum+col] = Type.BLOCK_PLATFORM;
              break;
            case '4':
              r.blockType[rowNum+row][colNum+col] = Type.BLOCK_SPIKE;
              break;
            case 'p':
              setPortal(true);
              setPortalCoordinates(rowNum+row,colNum+col,'p');
              r.blockType[rowNum+row][colNum+col] = Type.BLOCK_PORTAL;
              break;
            case 'q':
              setPortalCoordinates(rowNum+row,colNum+col,'q');
              r.blockType[rowNum+row][colNum+col] = Type.BLOCK_PORTAL;
              break;
          }
        }
      }
      makePortal(r);
    }
    
    
    public boolean blockOrCrystal(){
      int i = (int)random(20);
      if(i<1){
        return true;
      }
      return false;
    }
    
    
    public void setPortal(boolean p){
      portal = p;
    }
    
    
    public void setPortalCoordinates(int row, int col, char portal){
      switch(portal){
        case 'p':
          portalCoordinates[0]=row;
          portalCoordinates[1]=col;
          break;
        case 'q':
          portalCoordinates[2]=row;
          portalCoordinates[3]=col;
          break;
      }
    }
    
    
    public void makePortal(Room r){
      if(!portal){
        return;
      }
      Block b1 = blockFactory.newBlock(Type.BLOCK_PORTAL);
      b1.setPos(portalCoordinates[0], portalCoordinates[1]);
      b1.setPortal(portalCoordinates[2], portalCoordinates[3]);
      r.addBlock(b1);
      Block b2 = blockFactory.newBlock(Type.BLOCK_PORTAL);
      b2.setPos(portalCoordinates[2], portalCoordinates[3]);
      b2.setPortal(portalCoordinates[0], portalCoordinates[1]);
      r.addBlock(b2);
    }
    
    
    private void addBorders(Room r)
    {
      for(int i=0; i<20; i++){
          for(int j=0; j<29; j++){
            if(borderCheck(i,j)){
              r.blockType[i][j] = Type.BLOCK_BORDER;
            }
          }
          r.blockType[6][0] = Type.BLOCK_EMPTY;
          r.blockType[7][0] = Type.BLOCK_EMPTY;
          r.blockType[8][0] = Type.BLOCK_EMPTY;
          r.blockType[6][28] = Type.BLOCK_EMPTY;
          r.blockType[7][28] = Type.BLOCK_EMPTY;
          r.blockType[8][28] = Type.BLOCK_EMPTY;
          r.blockType[15][0] = Type.BLOCK_EMPTY;
          r.blockType[16][0] = Type.BLOCK_EMPTY;
          r.blockType[17][0] = Type.BLOCK_EMPTY;
          r.blockType[15][28] = Type.BLOCK_EMPTY;
          r.blockType[16][28] = Type.BLOCK_EMPTY;
          r.blockType[17][28] = Type.BLOCK_EMPTY;
          r.blockType[0][15] = Type.BLOCK_EMPTY;
          r.blockType[0][16] = Type.BLOCK_EMPTY;
          r.blockType[19][15] = Type.BLOCK_EMPTY;
          r.blockType[19][16] = Type.BLOCK_EMPTY;
        }
    }
    
    
    private boolean borderCheck(int r, int c){
      if(r==0 || c==0){
        return true;
      }
      if(r==19 || c==28){
        return true;
      }
      return false;
    }
    
    
    private void fillLevel(Room r){
      generateLevel(r);
      addSection(level[0],r,1,1);
      addSection(level[1],r,1,10);
      addSection(level[2],r,1,19);
      addSection(level[3],r,10,1);
      addSection(level[4],r,10,10);
      addSection(level[5],r,10,19);
    }
    
    
    //0 - Only up and down exits
    private Room roomType0(){
        Room r = new Room();
        r.setType(0);
        addBorders(r);
        r.blockType[6][0] = Type.BLOCK_BORDER;
        r.blockType[7][0] = Type.BLOCK_BORDER;
        r.blockType[8][0] = Type.BLOCK_BORDER;
        r.blockType[6][28] = Type.BLOCK_BORDER;
        r.blockType[7][28] = Type.BLOCK_BORDER;
        r.blockType[8][28] = Type.BLOCK_BORDER;
        r.blockType[15][0] = Type.BLOCK_BORDER;
        r.blockType[16][0] = Type.BLOCK_BORDER;
        r.blockType[17][0] = Type.BLOCK_BORDER;
        r.blockType[15][28] = Type.BLOCK_BORDER;
        r.blockType[16][28] = Type.BLOCK_BORDER;
        r.blockType[17][28] = Type.BLOCK_BORDER;
        fillLevel(r);
        return r;
    }
    
    // 1 - all exits
    private Room roomType1(){
        Room r = new Room();
        r.setType(1);
        addBorders(r);
        fillLevel(r);
        return r;
    }
   
    // 2 - only left and right exits
    private Room roomType2(){
        Room r = new Room();
        r.setType(2);
        addBorders(r);
        r.blockType[0][15] = Type.BLOCK_BORDER;
        r.blockType[0][16] = Type.BLOCK_BORDER;
        r.blockType[19][15] = Type.BLOCK_BORDER;
        r.blockType[19][16] = Type.BLOCK_BORDER;
        fillLevel(r);
        return r;
    }

    // 3 - only bottom exits
    private Room roomType3(){
        Room r = new Room();
        r.setType(3);
        addBorders(r);
        r.blockType[6][0] = Type.BLOCK_BORDER;
        r.blockType[7][0] = Type.BLOCK_BORDER;
        r.blockType[8][0] = Type.BLOCK_BORDER;
        r.blockType[6][28] = Type.BLOCK_BORDER;
        r.blockType[7][28] = Type.BLOCK_BORDER;
        r.blockType[8][28] = Type.BLOCK_BORDER;
        r.blockType[15][0] = Type.BLOCK_BORDER;
        r.blockType[16][0] = Type.BLOCK_BORDER;
        r.blockType[17][0] = Type.BLOCK_BORDER;
        r.blockType[15][28] = Type.BLOCK_BORDER;
        r.blockType[16][28] = Type.BLOCK_BORDER;
        r.blockType[17][28] = Type.BLOCK_BORDER;
        r.blockType[0][15] = Type.BLOCK_BORDER;
        r.blockType[0][16] = Type.BLOCK_BORDER;
        fillLevel(r);
        return r;
    }

    // 4 - all exits
    private Room roomType4(){
        Room r = new Room();
        r.setType(4);
        addBorders(r);
        fillLevel(r);
        return r;
    }
    
    // 5 - only top and right exit
    private Room roomType5(){
        Room r = new Room();
        r.setType(5);
        addBorders(r);
        r.blockType[6][0] = Type.BLOCK_BORDER;
        r.blockType[7][0] = Type.BLOCK_BORDER;
        r.blockType[8][0] = Type.BLOCK_BORDER;
        r.blockType[15][0] = Type.BLOCK_BORDER;
        r.blockType[16][0] = Type.BLOCK_BORDER;
        r.blockType[17][0] = Type.BLOCK_BORDER;
        r.blockType[19][15] = Type.BLOCK_BORDER;
        r.blockType[19][16] = Type.BLOCK_BORDER;
        fillLevel(r);
        return r;
    }

}
