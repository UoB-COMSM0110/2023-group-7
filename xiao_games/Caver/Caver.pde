Map map;
Player p;
Block b;

void setup(){
    size(900,600);
    this.map = new Map();
    this.p = new Player();
    this.b = new Block();
}

void draw(){
      for(int i = 0; i < 4; i++){
        for(int j = 0; j < 4; j++){
            System.out.print(map.rooms[i][j].desc);
        }
        System.out.println("");
    }
    System.out.println(map.roomNum[0] +"," + map.roomNum[1]);

     background(200);
     map.display();
     p.display();

}

void keyPressed(){
  if(keyCode == LEFT){
    p.x -= 15;
  }
  if(keyCode == RIGHT){
    p.x += 15;
  }
    if(keyCode == UP){
    p.y -= 15;
  }
  if(keyCode == DOWN){
    p.y += 15;
  }
  
  //if(keyCode == UP){
  //  p.jump = true;
  //  p.jumpHeight = height * 3/20;
  //}

}
