int sx, sy; 
float density = 0.1; 
int[][][] world;

void setup(){
  size(screen.width/3, screen.height/3);
  frameRate(12);
  sx = (int)width;
  sy = (int)height;
  world = new int[sx][sy][3]; 
  colorMode(HSB, 360); 

  // Set random cells to 'on' 
  for (int i = 0; i < sx * sy * density; i++) { 
    world[(int)random(sx)][(int)random(sy)][1] = 1; 
  } 

  for (int x = 0; x < sx; x++) { 
    for (int y = 0; y < sy; y++) {
      world[x][y][2] = random(360); 
    }
  }

} 

void draw(){ 

  background(0,0,360); 
  // Drawing and update cycle 
  for (int x = 0; x < sx; x++) { 
    for (int y = 0; y < sy; y++) { 
      if ((world[x][y][1] == 1) || (world[x][y][1] == 0 && world[x][y][0] == 1)) { 
        world[x][y][0] = 1;
        stroke(world[x][y][2],180,360); 
        point(x, y); 
      } 
      if (world[x][y][1] == -1){ 
        world[x][y][0] = 0; 
      } 
      world[x][y][1] = 0; 
    } 
  } 

  // Birth and death cycle 
  for (int x = 0; x < sx; x++) { 
    for (int y = 0; y < sy; y++) { 
      int count = neighbors(x, y); 
      if (count == 3 && world[x][y][0] == 0){ 
        world[x][y][1] = 1;
        world[x][y][2] = (parent_color(x,y)/3)%360;
      } 
      if ((count < 2 || count > 3) && world[x][y][0] == 1) 
      { 
        world[x][y][1] = -1; 
      } 
    } 
  } 
} 

// Count the number of adjacent cells 'on' 

int neighbors(int x, int y){ 
  return world[(x + 1) % sx][y][0] + 
         world[x][(y + 1) % sy][0] + 
         world[(x + sx - 1) % sx][y][0] + 
         world[x][(y + sy - 1) % sy][0] + 
         world[(x + 1) % sx][(y + 1) % sy][0] + 
         world[(x + sx - 1) % sx][(y + 1) % sy][0] + 
         world[(x + sx - 1) % sx][(y + sy - 1) % sy][0] + 
         world[(x + 1) % sx][(y + sy - 1) % sy][0]; 
}

int parent_color(int x, int y){
  int color = 0;
  int[] exist = {world[(x + 1) % sx][y][0],world[x][(y + 1) % sy][0],world[(x + sx - 1) % sx][y][0],world[x][(y + sy - 1) % sy][0],
                 world[(x + 1) % sx][(y + 1) % sy][0],world[(x + sx - 1) % sx][(y + 1) % sy][0],world[(x + sx - 1) % sx][(y + sy - 1) % sy][0],
                 world[(x + 1) % sx][(y + sy - 1) % sy][0]};
  int[] colors = {world[(x + 1) % sx][y][2],world[x][(y + 1) % sy][2],world[(x + sx - 1) % sx][y][2],world[x][(y + sy - 1) % sy][2],
                 world[(x + 1) % sx][(y + 1) % sy][2],world[(x + sx - 1) % sx][(y + 1) % sy][2],world[(x + sx - 1) % sx][(y + sy - 1) % sy][2],
                 world[(x + 1) % sx][(y + sy - 1) % sy][2]};

  for(int i = 0; i < 8; i++){
    if(exist[i]==1){
      color += colors[i];
    }
  }

  return color;
}