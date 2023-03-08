/**
* @author imyuanxiao
* Class used to contain all rooms
*/
class Map extends HandleEnemies{
    private ArrayList<Room> rooms;
    private int currentRoomIndex;
    
    public Map(){
        this.rooms = new ArrayList();
        this.setEnemies();
    }
    
    public void addRoom(Room room){
      rooms.add(room);
   }
   
   //get room that is just generated
    public Room getNewRoom(int id){
       return rooms.get(id);
    }
    
    public void setCurrentRoomIndex(int i){
        currentRoomIndex = i;
    }
    
    public Room getCurrentRoom(){
        return rooms.get(currentRoomIndex);
    }
    
    public int getIndexByDirection(int type){
        Room curRoom = this.getCurrentRoom();
        return curRoom.getAdjacent()[type];
    }
    
}
