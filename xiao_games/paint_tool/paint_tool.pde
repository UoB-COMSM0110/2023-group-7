PImage brush_img;
PImage line_img;
PImage eraser_img;
PImage clear_img;
PImage add_img;
PImage sub_img;
PFont font;
float icon_size = 20;
float brush_size = 10;
int brush_type = 0;
float red = 123;
float green = 123;
float blue = 123;
float offset_x = 20;
float offset_y = 25;
float p_mx = 0;
float p_my = 0;
int panel_x = 800;
int panel_y = 400;
float panel_right_x = offset_x*2 + icon_size;
float panel_right_y = offset_y*2;
float panel_right_x_2 = panel_x - panel_right_x - offset_x;
float panel_right_y_2 =  panel_y - panel_right_y - offset_y;
float brushButton_x = offset_x;
float brushButton_y = offset_y * 2;
float lineButton_x = offset_x;
float lineButton_y = brushButton_y + offset_y;
float eraserButton_x = offset_x;
float eraserButton_y = lineButton_y + offset_y;
float clearButton_x = offset_x;
float clearButton_y = eraserButton_y + offset_y;
float colorButton_x = offset_x;
float colorButton_y = clearButton_y + offset_y;
float addButton_x = offset_x;
float addButton_y =colorButton_y + offset_y;
float subButton_x = offset_x;
float subButton_y = addButton_y + offset_y;
float sizeButton_x = offset_x;
float sizeButton_y = subButton_y + offset_y;
char brush_model = 'b';

void setup(){
    size(800, 400);
    background(255);  
    noStroke();
    brush_img = loadImage("brush.png");
    line_img = loadImage("line.png");
    eraser_img = loadImage("eraser.png");
    clear_img = loadImage("clear.png");
    add_img = loadImage("add.png");
    sub_img = loadImage("sub.png");
    font = loadFont("OPPOSans-M-20.vlw");
    panel_left();
    panel_right();
}

void draw(){
  frameRate(30);
  panel_left();
  colorButton();
  if(mousePressed == true && mouseButton == LEFT){
     inAddButton();
     inSubButton();
  }
}

void mouseDragged(){
   if(in_panel_right()){
      paint();
      erase();
   }
}

void mouseClicked(){
  inColorButton();
  inBrushButton();
  inLineButton();
  inEraserButton();
  inClearButton();
}

void mousePressed(){
  if(mouseButton == LEFT){
    this.p_mx = mouseX;
    this.p_my = mouseY;
    //println("p_mx:"+ p_mx +", p_my:" + p_my);
  }
}

void mouseReleased(){
  if(brush_model == 'l'){
      fill(red,green,blue);
      stroke(red, green, blue);
      strokeWeight(brush_size);
      line(p_mx, p_my, mouseX, mouseY);
      noStroke();
  }
}

void keyReleased(){
    if(key == 's'){
        changeShape();
    }
}

void keyPressed(){
    if(key == '+') change_brush_size(true);
    if(key == '-') change_brush_size(false);
}

void panel_left(){
   panel_left_back();
   sizeButton();
   colorButton();
   brushButton();
   lineButton();
   eraserButton();
   clearButton();
   addButton();
   subButton();
   tips();
}

void backColor(){
    fill(255,255,255);
}

void panel_left_back(){
    backColor();
    //top
    rect(0, 0, panel_x, panel_right_y);
    //bottom
    rect(0, panel_right_y + panel_right_y_2+1, panel_x, panel_right_y);
    //left
    rect(0, 0, panel_right_x, panel_y);
    //right
    rect(panel_right_x + panel_right_x_2+1, 0, panel_right_x, panel_y);
}

void panel_right(){
    stroke(1);
    strokeWeight(1);
    backColor();
    rect(panel_right_x, panel_right_y, panel_right_x_2, panel_right_y_2);
    noStroke();
}

boolean in_panel_right(){
   if(mouseX >= panel_right_x && mouseX <= panel_right_x+ panel_right_x_2 && mouseY >= panel_right_y && mouseY <= panel_right_y + panel_right_y_2){
       return true;
   }
   return false;
}

void tips(){   
   fill(100,100,100);
   textFont(font, 15);
   text("tips: use 'S' to change brush type(ret or circle), " + "use '+/-' to change size of brush", 20, 30); 
}

void brushButton(){
  image(brush_img, brushButton_x, brushButton_y);
}

void lineButton(){
  image(line_img, lineButton_x, lineButton_y);
}

void colorButton(){
     stroke(1);
     strokeWeight(1);   
     fill(red,green, blue);
     rect(colorButton_x,colorButton_y, 20, 20);
     noStroke();
}

void sizeButton(){
     rectMode(CENTER);
     backColor();
     rect(sizeButton_x + offset_x/2,sizeButton_y + offset_y, brush_size+3,brush_size+3);
     stroke(1);
     strokeWeight(1);   
     fill(255,255, 255);
     if(brush_type % 2 == 0){
          rect(sizeButton_x + offset_x/2,sizeButton_y + offset_y, brush_size,brush_size);
     }else{
         ellipse(sizeButton_x + offset_x/2,sizeButton_y + offset_y, brush_size,brush_size);
     }
     noStroke();
     rectMode(CORNER);
}

void eraserButton(){
   image(eraser_img, eraserButton_x, eraserButton_y);
}

void clearButton(){
   image(clear_img, clearButton_x, clearButton_y);
}

void addButton(){
  image(add_img, addButton_x, addButton_y);
}

void subButton(){
  image(sub_img, subButton_x, subButton_y);
}

void inBrushButton(){
  if(mouseX >= brushButton_x && mouseX <= brushButton_x+icon_size && mouseY >= brushButton_y && mouseY <= brushButton_y+icon_size){
        this.brush_model = 'b';
        //println(this.brush_model);
  }
}

void inClearButton(){
  if(mouseX >= clearButton_x && mouseX <= clearButton_x+icon_size && mouseY >= clearButton_y && mouseY <= clearButton_y+icon_size){
        backColor();
        panel_right();
  }
}

void inLineButton(){
  if(mouseX >= lineButton_x && mouseX <= lineButton_x+icon_size && mouseY >= lineButton_y && mouseY <= lineButton_y+icon_size){
        this.brush_model = 'l';
  }
}

void inColorButton(){
  if(mouseX >= colorButton_x && mouseX <= colorButton_x+icon_size && mouseY >= colorButton_y && mouseY <= colorButton_y+icon_size){
     setColor();
     colorButton();
  }
}

void inEraserButton(){
  if(mouseX >= eraserButton_x && mouseX <= eraserButton_x+icon_size && mouseY >= eraserButton_y && mouseY <= eraserButton_y+icon_size){
        this.brush_model = 'e';
  }
}

void inAddButton(){
  if(mouseX >= addButton_x && mouseX <= addButton_x+icon_size && mouseY >= addButton_y && mouseY <= addButton_y+icon_size){
        change_brush_size(true);
  }
}

void inSubButton(){
  if(mouseX >= subButton_x && mouseX <= subButton_x+icon_size && mouseY >= subButton_y && mouseY <= subButton_y+icon_size){
        change_brush_size(false);
  }
}

void change_brush_size(boolean is_add){
  if(is_add){
    if(brush_size < 50)   brush_size++;
  }else{
     if(brush_size > 1)   brush_size--;
  }
}

void paint(){
  if(brush_model == 'b'){
       fill(red,green, blue);
       use_Brush();
  }
}

void erase(){
  if(brush_model == 'e'){
       backColor();
       use_Brush();
  }
}

void use_Brush(){
       if(brush_type % 2 == 0){
            rect(mouseX-brush_size/2, mouseY-brush_size/2, brush_size, brush_size);
       }
       if(brush_type % 2 == 1){
           ellipse(mouseX, mouseY, brush_size, brush_size);
       }
}

void setColor(){
   this.red = random(255);
   this.green = random(255);
   this.blue = random(255);
   fill(red,green, blue);
}

void changeShape(){
   this.brush_type++;
}
