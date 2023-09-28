class Node
{
  //========================================VALUES==============================//
  PVector pos = new PVector(-200, 0);
  PVector size = new PVector(200, 100); 
  float barMargin = 0;
  String title = "Node";

  boolean held = false;
  boolean mouseDown = false;
  
  PVector grabOffset = new PVector(0,0);

  //========================================INIT==============================//
  Node( int _w, int _h, float _barMargin)
  {
    pos = PVector.random2D();
    pos.mult(random(2000));
    barMargin = _barMargin;
    size.x = _w;
    size.y = _h;
  }

  //========================================MAIN==============================//
  void Show()
  {
    textAlign(LEFT,CENTER);
    stroke(globals.NodeStrokeColor);
    fill(globals.NodeColor);
    rect(pos.x, pos.y, size.x, size.y, 10);
    fill(globals.NodeBarColor);
    rect(pos.x, pos.y, size.x, barMargin, 10, 10, 0, 0);
    text("x:" + round(pos.x) + " - y:" + round(pos.y),pos.x,pos.y-15);
    
    fill(255);
    text("Node",pos.x+10,pos.y+barMargin/2);
  }

  void Update()
  {
    Move();
  }

  //========================================FUNCTIONS==============================//
  void Move()
  {
    PVector mousePos = globals.GetMousePos();
    PVector pmousePos = globals.GetPrevMousePos();
    
    if (mousePressed)
    {
      if(!mouseDown)
      {
        mouseDown = true;
        if (mouseButton == LEFT)
        {
          if (mousePos.x > pos.x && mousePos.x < pos.x+size.x && mousePos.y > pos.y && mousePos.y < pos.y+barMargin)
          {
            held = true;
            grabOffset.x = mousePos.x-pos.x;
            grabOffset.y = mousePos.y-pos.y;
          }
        }
      }
    } else
    {
      held = false;
      mouseDown = false;
    }

    if (held)
    {
      if(globals.IsShift())
      {
        pos.x = mousePos.x-grabOffset.x;
        pos.y = mousePos.y-grabOffset.y;
        
        pos.x -= pos.x%20;
        pos.y -= pos.y%20;
      }
      else
      {
        pos.x -= pmousePos.x-mousePos.x;
        pos.y -= pmousePos.y-mousePos.y;
      }
    }
  }
}
