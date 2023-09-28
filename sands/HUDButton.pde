class HUDButton extends HUDItem
{
  //========================================VALUES==============================//
  PVector size; 
  boolean hover = false;
  String title = "Button";
  
  boolean held = false;
  boolean mouseDown = false;

  boolean pressed, down, released;
  

  //========================================INIT==============================//
  HUDButton(int x, int y, int w, int h, String text)
  {
    pos = new PVector(x, y);
    size = new PVector(w, h);
    title = text;
  }

  //========================================MAIN==============================//
  void Show()
  {
    if (held)
    {
      fill(globals.HUDItemHeldColor);
    } else
    {
      fill(globals.HUDItemColor);
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
    textAlign(CENTER,CENTER);
    text(title,pos.x+size.x/2,pos.y+size.y/2);
  }

  void Update()
  {
    hover = CheckHover();
    CheckPressed();
    CheckReleased();
  }

  //========================================FUNCTIONS==============================//
  boolean CheckHover()
  {
    PVector mousePos = globals.GetMouseHudPos();

    if (mousePos.x > pos.x && mousePos.x < pos.x+size.x && mousePos.y > pos.y && mousePos.y < pos.y+size.y)
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
