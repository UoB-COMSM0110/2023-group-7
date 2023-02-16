class Map{
    private ArrayList<Room> rooms;
    private int currentRoomIndex;//current Room's index;
    private int roomIndex;//next new Room's index
    private RoomGenerator roomGenerator;
    
    //TO DELETE
    public void printRooms(){
       for(int i = 0; i < rooms.size(); i++){
          print(rooms.get(i).getType() + ", ");
       }
       println("");
    }
    
    public Map(){
        this.rooms = new ArrayList();
        this.roomGenerator = new RoomGenerator(this);
        this.rooms.add(roomGenerator.newRoom(0, roomIndex++));
    }
    
    public void addRoom(int type){
      rooms.add(roomGenerator.newRoom(type, roomIndex++));
   }
   
    public void setCurrentRoomIndex(int i){
        currentRoomIndex = i;
    }
    
    public int getIndexByDirection(int type){
        Room curRoom = this.getCurrentRoom();
        return curRoom.getAdjacent()[type];
    }
    
    //get room that is just generated
    public Room getNewRoom(){
       return rooms.get(roomIndex - 1);
    }
    
    public Room getCurrentRoom(){
        return rooms.get(currentRoomIndex);
    }
    
    public int getRoomNumer(){
        return roomIndex;
    }

}
