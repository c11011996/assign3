int fighterX, fighterY, fighterW, fighterH;
int bgX;
int hp1;
int treasureX, treasureY, treasureW, treasureH;
int enemyX, enemyY, enemyW, enemyH;
PImage bg1, bg2, enemy, fighter, hp, treasure, start1, start2, end1, end2;
final int GAME_START = 0, GAME_RUN = 1, GAME_WIN = 2, GAME_OVER = 3;
final int STRAIGHT = 0, TILT = 1, DIAMOND = 2;
int gameState, enemyState;

boolean upPressed = false;   // as a triger
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

void setup () {
  size(640, 480) ;
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");

  gameState = GAME_START; 
  enemyState = STRAIGHT;

  fighterX = 590;
  fighterY = 240;
  fighterW = 50;
  fighterH = 50;
  bgX = 0;
  hp1 = 38;
  treasureX = 0;
  treasureY = 0;
  treasureW = 40;
  treasureH = 40;
  enemyX = 0;
  enemyY = 0;
  enemyW = 60;
  enemyH = 60;
  enemyY = floor(random(50, 240)); 

  //treasure
  treasureX = floor(random(600));
  treasureY = floor(random(30, 440));
}


void draw() {

  switch(gameState) {

    //GAME START
  case GAME_START:
    image(start2, 0, 0);
    if (mouseY > 365 && mouseY < 420 && mouseX > 200 && mouseX < 408) {
      image(start1, 0, 0);
      if (mousePressed) {
        gameState = GAME_RUN;
      }
    }
    break;

    //GAME RUN
  case GAME_RUN:
    //background
    image(bg1, bgX, 0);
    bgX++;
    image(bg2, bgX-640, 0);
    image(bg1, bgX-1280, 0);
    bgX%=1280;
    image(treasure, treasureX, treasureY);
    //hp
    fill(255, 0, 0, 240);
    rect(18, 10, hp1, 14);    
    image(hp, 5, 1);
    
    //enemy
    switch(enemyState) {
       case STRAIGHT:
       for(int i=0;i<5;i++){
       image(enemy,enemyX-i*enemyW,enemyY);
       }
       enemyX += 5;
       if(enemyX-enemyW*4 > width){
         enemyState = TILT;
         enemyX=0;
         enemyY = floor(random(50, 200)); 
       }
       break;
       
    case TILT:
      for (int j=0; j<5; j++) {
        image(enemy, enemyX-j*enemyW, enemyY+j*enemyH);
      }
      enemyX+=5;
      if (enemyX-4*enemyW > width) {
        enemyState = DIAMOND;
         enemyX=0;
         enemyY = floor(random(100, 300)); 
      }
      break; 
        
    case DIAMOND:
        image(enemy, enemyX, enemyY);
        image(enemy, enemyX-enemyW, enemyY-enemyH);
        image(enemy, enemyX-2*enemyW, enemyY-2*enemyH);
        image(enemy, enemyX-3*enemyW, enemyY-enemyH);
        image(enemy, enemyX-4*enemyW, enemyY);
        image(enemy, enemyX-3*enemyW, enemyY+enemyH);
        image(enemy, enemyX-2*enemyW, enemyY+2*enemyH);
        image(enemy, enemyX-enemyW, enemyY+enemyH);
        enemyX+=5;
      if (enemyX-enemyW*4 > width) {
        enemyState = STRAIGHT;
        enemyX=0;
        enemyY = floor(random(240, 360)); 
      }
      break;
    }

    //fighter
    image(fighter, fighterX, fighterY);
    if (upPressed) {
      fighterY -= 5;
      if (fighterY < 0) {
        fighterY = 0;
      }
    }
    if (downPressed) {
      fighterY += 5;
      if (fighterY > 430) {
        fighterY = 430;
      }
    }
    if (leftPressed) {
      fighterX -= 5;
      if (fighterX < 0) {
        fighterX = 0;
      }
    }
    if (rightPressed) {
      fighterX += 5;
      if (fighterX > 590) {
        fighterX = 590;
      }
    }

    /* 
     //hit detection   
     if(fighterX >= enemyX && fighterX <= enemyX+enemyW && fighterY >= enemyY && fighterY <= enemyY+enemyH){
     hp1-=38;
     println (hp1) ;
     enemyX=0;
     }
         
     if(fighterX >= treasureX && fighterX <= treasureX+treasureW && fighterY >= treasureY && fighterY <= treasureY+treasureH){
     hp1 += 19;
     println(hp1);
     treasureX = floor(random(600));
     treasureY = floor(random(440));
     }
     */

    if (hp1 <= 0) {
      gameState=GAME_OVER;
    }
    if (hp1 >= 190) {
      hp1 = 190;
    }
    break;

    //GAME OVER
  case GAME_OVER:
    image(end2, 0, 0);
    if (mouseY > 305 && mouseY < 350 && mouseX > 200 && mouseX < 434) {
      image(end1, 0, 0);
      if (mousePressed) {
        hp1 = 190;
        fighterX = 590;
        fighterY = 240;

        gameState = GAME_RUN;
      }
    }
    break;
  }
}

void keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
    case UP:
      upPressed = true;
      break;
    case DOWN:
      downPressed = true;
      break;
    case LEFT:
      leftPressed = true;
      break;
    case RIGHT:
      rightPressed = true;
      break;
    }
  }
}
void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
    case UP:
      upPressed = false;
      break;
    case DOWN:
      downPressed = false;
      break;
    case LEFT:
      leftPressed = false;
      break;
    case RIGHT:
      rightPressed = false;
      break;
    }
  }
}
