import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
int scene=0;
int x = 300;
int y= 300;

float startTime;

boolean gameover=false;
int y2 = 1800;
Box2DProcessing box2d;

ArrayList<Boundary> boundaries;

//ArrayList<Box> boxes;
Box b;

void setup() {
  size(360, 360);
  smooth();
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);

  boundaries = new ArrayList<Boundary>();
  //boxes = new ArrayList<Box>();

  b = new Box(180, 10);
  //boxes.add(p);


  for (int i=0; i < 1000; i++)
  {

    int w1=(int)random(60, width);

    int x2=w1+50;


    boundaries.add(new Boundary(0, height+(i*60), w1, 5));
    boundaries.add(new Boundary(x2, height+(i*50), 100, 5));
    boundaries.add(new Boundary(x2, height+(i*60), 100, 5));
  }
}

void draw() {
  if (scene==0)
  {
    SceneZero();
  } else if (scene==1)
  {
    SceneOne();
  } else if (scene==2)
  {
    SceneTwo();
  } else if (scene==3)
  {
    background(255, 0, 255);
  }
}

void SceneZero()
{
  background (0);
  text("Move mouse to circle to start", 100, 100);
  text("Get passed all the walls to win", 100, 200);
  fill(0, 140, 140);
  ellipse(x, y, 50, 50);
  if (dist(x, y, mouseX, mouseY)<50)
  {
    scene=1;
  }
}

void SceneOne()
{
  if (gameover==false)
  {


    background(255, 255, 255);

    box2d.step();

    //for (Box b : boxes) {
      b.display();
    //}
    for (Boundary w : boundaries) {
      w.display();
    }
  } else
  {
    scene=2;
  }
}

void SceneTwo()
{
  background(255, 0, 0); 
  fill(250, 250, 250);
  text("you lose", 100, 100);
  text("'r' to respart game", 80, 200);
  if (key=='r')
  {
    Restart();
  }
}

void Restart()
{
  scene = 0;
  b = new Box(180, 180);
  gameover = false;

/*  for (Box b : boxes)
  {
    b.x = 180;
    b.y = 100;

    b = new Box(180, 10);
  }
 }*/
 
 
}
