PImage brush_img;
PImage line_img;
PImage eraser_img;
PImage add_img;
PImage sub_img;
PFont font;
float brush_size = 10;
int brush_type = 0;
float red = 123;
float green = 123;
float blue = 123;
float p_mx = 0;
float p_my = 0;
float brushButton_x = 20;
float brushButton_y = 50;
float lineButton_x = 20;
float lineButton_y = 75;
float eraserButton_x = 20;
float eraserButton_y = 100;
float colorButton_x = 20;
float colorButton_y = 125;
float addButton_x = 20;
float addButton_y = 150;
float subButton_x = 20;
float subButton_y = 175;
float sizeButton_x = 20;
float sizeButton_y = 200;
char brush_model = 'b';

void setup(){
    size(800, 400);
    background(255);  
    noStroke();
    brush_img = loadImage("brush.png");
    line_img = loadImage("line.png");
    eraser_img = loadImage("eraser.png");
    add_img = loadImage("add.png");
    sub_img = loadImage("sub.png");
    font = loadFont("OPPOSans-L-20.vlw");
    panel();
}

void draw(){
  frameRate(30);
  panel();
  colorButton();
  if(mousePressed == true && mouseButton == LEFT){
     inAddButton();
     inSubButton();
  }
}

void mouseDragged(){
   paint();
   erase();
}

void mouseClicked(){
  inColorButton();
  inBrushButton();
  inLineButton();
  inEraserButton();
}

void mousePressed(){
  if(mouseButton == LEFT){
    this.p_mx = mouseX;
    this.p_my = mouseY;
    println("p_mx:"+ p_mx +", p_my:" + p_my);
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

void panel(){
   sizeButton();
   colorButton();
   brushButton();
   lineButton();
   eraserButton();
   addButton();
   subButton();
   tips();
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
     fill(255,255,255);
     rect(sizeButton_x,sizeButton_y, brush_size+2,brush_size+2);
     stroke(1);
     strokeWeight(1);   
     fill(255,255, 255);
     if(brush_type % 2 == 0){
          rect(sizeButton_x,sizeButton_y, brush_size,brush_size);
     }else{
         ellipseMode(CORNER);
         ellipse(sizeButton_x,sizeButton_y, brush_size,brush_size);
         ellipseMode(CENTER);
     }
     noStroke();
}

void eraserButton(){
   image(eraser_img, eraserButton_x, eraserButton_y);
}

void addButton(){
  image(add_img, addButton_x, addButton_y);
}

void subButton(){
  image(sub_img, subButton_x, subButton_y);
}

void inBrushButton(){
  if(mouseX >= brushButton_x && mouseX <= brushButton_x+20 && mouseY >= brushButton_y && mouseY <= brushButton_y+20){
        this.brush_model = 'b';
        println(this.brush_model);
  }
}

void inLineButton(){
  if(mouseX >= lineButton_x && mouseX <= lineButton_x+20 && mouseY >= lineButton_y && mouseY <= lineButton_y+20){
        this.brush_model = 'l';
  }
}

void inColorButton(){
  if(mouseX >= colorButton_x && mouseX <= colorButton_x+20 && mouseY >= colorButton_y && mouseY <= colorButton_y+20){
     setColor();
     colorButton();
  }
}

void inEraserButton(){
  if(mouseX >= eraserButton_x && mouseX <= eraserButton_x+20 && mouseY >= eraserButton_y && mouseY <= eraserButton_y+20){
        this.brush_model = 'e';
  }
}

void inAddButton(){
  if(mouseX >= addButton_x && mouseX <= addButton_x+20 && mouseY >= addButton_y && mouseY <= addButton_y+20){
        change_brush_size(true);
  }
}

void inSubButton(){
  if(mouseX >= subButton_x && mouseX <= subButton_x+20 && mouseY >= subButton_y && mouseY <= subButton_y+20){
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
       fill(255,255, 255);
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
   fill(100,100,100);
}
