// Balance

PVector pos = new PVector();
PVector v = new PVector();
PVector a = new PVector();
PVector mouse = new PVector(mouseX, mouseY);
float V_FACTOR = 0.01;
float A_FACTOR = 1000;
float GRAVITY = 0.1;
int RADIUS = 25;
int oldTime, deltaTime;
boolean gameover = true;
int START_DELAY = 3000;
int timer;
int bLeft, bTop, bRight, bBottom;
int START_AREA = 1000;
float areasize = START_AREA;
float SHRINK_FACTOR = 0.04;
int endtime, gametimer;

void setup() {
  size(1000, 1000);
  pos.x = width/2;
  pos.y = height/5;
  oldTime = millis();
  textAlign(CENTER);
  rectMode(CENTER);

  background(0);
}


void draw() {
  int deltaTime = millis()-oldTime;
  oldTime = millis();
  timer += deltaTime;
  if (!gameover) {
    background(0);
    fill(255);
    rect(width/2, height/2, areasize, areasize);
    fill(0);
    circle(pos.x, pos.y, RADIUS*2);

    if (timer>= START_DELAY) {
      gametimer += deltaTime;
      areasize -= deltaTime*SHRINK_FACTOR;
      mouse.set(mouseX, mouseY);
      a.set(PVector.sub(pos, mouse));
      a.setMag(1/sq(a.mag()));
      //   a.setMag(1/a.mag());
      v.add(PVector.mult(a, deltaTime*A_FACTOR));
      v.y += GRAVITY*deltaTime;
      pos.add(PVector.mult(v, deltaTime*V_FACTOR));

      if (pos.x >= (width+areasize)/2 - RADIUS|| pos.x <= (width-areasize)/2+RADIUS || pos.y >= (height+areasize)/2-RADIUS|| pos.y <= (height-areasize)/2+RADIUS) {

        gameover = true;
        endtime = gametimer;
      }
    } else {
      float resttime = float((START_DELAY-timer)/100)/10;
      println(resttime);
      text(int (resttime) + "." + (int(resttime *10))%10, width/2, height/2);
    }
  } else {
    fill(255);
    background(0);
    textSize(100);
    text("GAMEOVER", width/2, height/2);
    textSize(50);
    text("SCORE: " + endtime, width/2, height/2+100);
  }
}
void keyPressed() {
  if ( key == ' ' && gameover) {
    gameover = false;
    pos.set(width/2, height/5);
    v.set(0, 0);
    a.set(0, 0);
    timer = 0;
    gametimer = 0;
    areasize = START_AREA;
  }
}
