class Map{

  void loadMap(int num){
     switch(num){
         case 1: 
          map1();
          break;
         case 2:
          map2();
          break;
          default:
          map1();
          break;
     }
  }
  
  void map1(){
      dbs.blocks.add(new Block(width, gy_CORNER - p.size, p.size * 2, p.size/3, 20));
      dbs.blocks.add(new Block(width, gy_CORNER - p.size * 2, p.size * 2, p.size/3, 45));
      dbs.blocks.add(new Block(width, gy_CORNER - p.size * 3, p.size * 2, p.size/3, 70));
      
      dbs.blocks.add(new Block(width, gy_CORNER - p.size, p.size * 6, p.size, 100));
      dbs.blocks.add(new Block(width, gy_CORNER - p.size * 2, p.size * 6, p.size, 140));
      dbs.blocks.add(new Block(width, gy_CORNER - p.size, p.size * 2, p.size, 200));
      dbs.blocks.add(new Block(width, gy_CORNER - p.size, p.size * 1, p.size, 240));
     
      //dbs.blocks.add(new Block(p.size, gy_CORNER - p.size, width/3, p.size, 100));
      //dbs.blocks.add(new Block(p.size, gy_CORNER - p.size * 2, width/3, p.size, 120));
      //dbs.blocks.add(new Block(p.size, gy_CORNER - p.size * 4, width/3, p.size, 140));
      
  }
  
  void map2(){
      dbs.spines.add(new Spine(width, height*2/3 + height/22, 20));
      dbs.spines.add(new Spine(width, height*2/3 + height/22, 45));
      dbs.spines.add(new Spine(width, height*2/3 + height/22, 70));
      dbs.spines.add(new Spine(width, height*2/3 + height/22, 120));
      dbs.spines.add(new Spine(width, height*2/3 + height/22, 145));
      dbs.spines.add(new Spine(width, height*2/3 + height/22, 170));
      //dbs.blocks.add(new Block(width, gy_CORNER - p.size, width, p.size, 20));
  }
  
}
