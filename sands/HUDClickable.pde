class HUDClickable extends HUDItem
{
  //========================================VALUES==============================//
  PVector size; 
  boolean hover = false;
  
  boolean held = false;
  boolean mouseDown = false;

  boolean pressed, down, released;
  PVector mouseOffset;
  
  color itemColor;
  color itemHeldColor;

  //========================================INIT==============================//
  HUDClickable(int x, int y, int w, int h, HUDMenu menu)
  {
    super(menu);
    Constructor(x,y,w,h,0,0,menu);
  }
  
  HUDClickable(int x, int y, int w, int h, int mox, int moy, HUDMenu menu)
  {
    super(menu);
     Constructor(x,y,w,h,mox,moy,menu);
  }

  void Constructor(int x, int y, int w, int h, int mox, int moy, HUDMenu menu)
  {
    mouseOffset = new PVector(mox,moy);
    pos = new PVector(x, y);
    size = new PVector(w, h);
    itemColor = globals.HUDItemColor;
    itemHeldColor = globals.HUDItemHeldColor;
  }

  //========================================MAIN==============================//
  void Show()
  {
    if (held)
    {
      fill(itemHeldColor);
    } else
    {
      fill(itemColor);
    }

    if (hover)
    {
      stroke(globals.HUDHoverStroke);
    } else
    {
      stroke(globals.HUDStroke);
    }
    rect(pos.x, pos.y, size.x, size.y, 5);
    fill(globals.HUDTextColor);
  }

  void Update()
  {
    hover = CheckHover();
    CheckPressed();
    CheckReleased();
  }

  //========================================FUNCTIONS==============================//
  void SetItemColor(color c)
  {
    itemColor = c;
  }
  
  void SetItemHeldColor(color c)
  {
    itemHeldColor = c;
  }
  
  boolean CheckHover()
  {
    PVector mousePos = PVector.sub(globals.GetMouseHudPos(),mouseOffset);

    if (mousePos.x > pos.x-1 && mousePos.x < pos.x+size.x && mousePos.y > pos.y-1 && mousePos.y < pos.y+size.y)
    {
      return true;
    }
    return false;
  }

  void CheckPressed()
  {
    if (mousePressed)
    {
      if (!mouseDown)
      {
        mouseDown = true;
        if (hover)
        {
          if (mouseButton == LEFT)
          {
            held = true;
            pressed = true;
          }
        }
      } else
      {
        pressed =  false;
      }
    } else
    {
      mouseDown = false; 
      pressed =  false;
    }
  }

  void CheckReleased()
  {
    if (mouseDown == false && held)
    {
      held = false;
      released = true;
    } else
    {
      released = false;
    }
  }

  boolean Pressed() {
    return pressed;
  }
  boolean Held() {
    return held;
  }
  boolean Released() {
    return released;
  }
}
