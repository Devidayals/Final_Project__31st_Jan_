class Box {

  Body body;
  float w;
  float h;
  int x;
  int y;


  Box(float x, float y) {
    w = 14;
    h = w;

    makeBody(new Vec2(x, y), w, h);
  }


  void killBody() 
  {
    box2d.destroyBody(body);
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+w*h) 
    {
      killBody();
      //return true;
    }
  }

  void attract(float x, float y) {

    Vec2 worldTarget = box2d.coordPixelsToWorld(x, y);   
    Vec2 bodyVec = body.getWorldCenter();

    worldTarget.subLocal(bodyVec);

    worldTarget.normalize();
    worldTarget.mulLocal((float) 50);

    body.applyForce(worldTarget, bodyVec);
  }


  void display() {
    PollInputs();

    Vec2 pos = box2d.getBodyPixelCoord(body);

    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    rect(0, 0, w, h);
    popMatrix();


    if (pos.y<0)
    {
      gameover=true;
    }

    if (pos.y>360)
    {
      gameover=true;
    }

    if (pos.x<0)
    {
      gameover=true;
    }

    if (pos.x>360)
    {
      gameover=true;
    }
  }

  void makeBody(Vec2 center, float w_, float h_) {

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;

    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);
  }

  void PollInputs()
  {
    if (keyPressed)
    {
      if (key=='d')
      {
        Vec2 move = new Vec2(8, 2);
        body.setLinearVelocity(move);
        println("Moving Right");
      }
      if (key=='a')
      {
        Vec2 move = new Vec2(-8, 2);
        body.setLinearVelocity(move);
        println("Moving Left");
      }
      if (key=='s')
      {
        Vec2 move = new Vec2(0, -5);
        body.setLinearVelocity(move);
        println("Moving Down");
      }
      if (key=='w')
      {
        Vec2 move = new Vec2(0, 10);
        body.setLinearVelocity(move);
        println("Moving Up");
      }
    }
  }
}
