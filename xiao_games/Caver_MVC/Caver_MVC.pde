Controller controller;
View view;

void setup(){
    size(900,600);
    Model model = new Model();
    model.addPlayer(new Player(width/2, height/2, height/20,"imgs/player.png"));
    model.addBlock(new Block(height/20));
    controller = new Controller(model);
    view = new View(model);
}

void draw(){
    controller.display();
    view.paint();
}

public void keyPressed(){
  if(keyCode == LEFT){
    controller.changePlayerPos(1);
  }
  if(keyCode == RIGHT){
    controller.changePlayerPos(2);
  }
  if(keyCode == UP){
    controller.changePlayerPos(3);
  }
  if(keyCode == DOWN){
    controller.changePlayerPos(4);
  }
  
}
