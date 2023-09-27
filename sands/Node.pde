class Node
{
  //========================================VALUES==============================//
  PVector pos = new PVector(-200, 0);
  PVector size = new PVector(200, 100); 
  float barMargin = 0;
  String title = "Node";

  boolean held = false;
  boolean mouseDown = false;

  //========================================INIT==============================//
  Node( int _w, int _h, float _barMargin)
  {
    barMargin = _barMargin;
    size.x = _w;
    size.y = _h;
  }

  //========================================MAIN==============================//
  void Show()
  {
    fill(160, 28, 164,200);
    rect(pos.x, pos.y, size.x, size.y, 10);
    fill(168, 96, 120);
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
        pos.x = mousePos.x - mousePos.x%20;
        pos.y = mousePos.y - mousePos.y%20;
      }
      else
      {
        pos.x -= pmousePos.x-mousePos.x;
        pos.y -= pmousePos.y-mousePos.y;
      }
    }
  }
}
