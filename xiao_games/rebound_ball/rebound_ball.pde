// initial position for our circle
float circle_x = 300;
float circle_y = 20;
// how much to move the circle on each frame
float move_x = 2;
float move_y = -2;
float board_x_left = 0;
float board_x_right = 0;
float board_y_up = 0;
float board_y_down = 0;
float board_width = 40;
float board_height = 5;
 
void setup() {
  size(400, 200);
}

void draw() {
  frameRate(60);
  background(#21EA73);
  board();
  ellipse(circle_x, circle_y, 20, 20);
  circle_x = circle_x + move_x;
  circle_y = circle_y + move_y;
  
  if(crash()){
     crashBoard();
  }else{
     crashBorder();
  }
}

void crashBoard(){
    if(circle_x >= board_x_left && circle_x <= board_x_right){
         move_y = -move_y;
    }
    if(circle_y >= board_y_up && circle_y <= board_y_down){
          move_x = -move_x;
    }
}

void crashBorder(){
  if(circle_x > width) {
    circle_x = width;
    move_x = -move_x;
    println("too far right");
  }
  if(circle_y > height) {
    circle_y = height;
    move_y = -move_y;
    println("too far bottom");
  }
  if(circle_x < 0) {
    circle_x = 0;
    move_x = -move_x;
    println("too far left");
  }
  if(circle_y < 0) {
    circle_y = 0;
    move_y = -move_y;
    println("too far top");
  }
}

boolean crash(){
   if(circle_x <= board_x_right && circle_x >= board_x_left
   && circle_y >= board_y_up && circle_y <= board_y_down){
        return true;
   }
   return false;
}

void board(){
    fill(100,100,100);
    rectMode(CENTER);
    rect(mouseX,mouseY,board_width,board_height);
    board_x_left = mouseX-board_width;
    board_x_right = mouseX+board_width;
    board_y_up = mouseY-board_height;
    board_y_down = mouseY+board_height;
}
