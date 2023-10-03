class MaskClickable extends MaskGraphic
{
  //========================================VALUES==============================//
  boolean hover = false;
  boolean hoverEnabled = true;
  boolean keepHoverOnHeld = true;

  boolean held = false;
  boolean mouseDown = false;

  boolean pressed, down, released, missed;
  PVector mouseOffset = new PVector(0, 0);

  int clickMarginLeft = 0;
  int clickMarginRight = 0;
  int clickMarginTop = 0;
  int clickMarginBottom = 0;

  color itemColor;
  color itemHeldColor;

  //========================================INIT==============================//
  MaskClickable(int _x, int _y, int _w, int _h, PGraphics _mask, HUDConExplorer _owner)
  {
    super(_x, _y, _w, _h, _mask, _owner);
    mouseOffset.x = _owner.menu.pos.x+_owner.sliderWidth;
    mouseOffset.y = _owner.menu.pos.y+_owner.menu.barMargin+_owner.explorerBarHeight;
    itemColor = globals.HUDItemColor;
    itemHeldColor = globals.HUDItemHeldColor;
  }

  //========================================MAIN==============================//
  void Show(int offset)
  {
    if (hover && hoverEnabled)
    {
      mask.stroke(globals.HUDHoverStroke);
    } else
    {
      mask.stroke(globals.HUDStroke);
    }

    if (held)
    {
      mask.fill(itemHeldColor);
      if (!keepHoverOnHeld)
      {
        mask.stroke(globals.HUDStroke);
      }
    } else
    {
      mask.fill(itemColor);
    }

    mask.rect(pos.x, pos.y+offset, size.x, size.y, 5);
    mask.fill(globals.HUDTextColor);
  }

  void Update()
  {
    if (owner.onWindow)
    {
      hover = CheckHover();
      CheckPressed();
      CheckReleased();
    }
  }

  //========================================FUNCTIONS==============================//
  void SetClickMarginLeft(int m)
  {
    clickMarginLeft = m;
  }

  void SetClickMarginRight(int m)
  {
    clickMarginRight = m;
  }

  void SetClickMarginTop(int m)
  {
    clickMarginTop = m;
  }

  void SetClickMarginBottom(int m)
  {
    clickMarginBottom = m;
  }

  void SetKeepHoverOnHeld(boolean b)
  {
    keepHoverOnHeld = b;
  }

  void SetHoverEnabled(boolean b)
  {
    hoverEnabled = b;
  }  

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
    int offset = owner.areaOffset;
    PVector mousePos = PVector.sub(globals.GetMouseHudPos(), mouseOffset);

    if (mousePos.x > pos.x-1+clickMarginLeft && mousePos.x < pos.x+size.x-clickMarginRight && mousePos.y > pos.y-1+offset+clickMarginTop && mousePos.y < pos.y+size.y+offset-clickMarginBottom)
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
        } else
        {
          missed = true;
        }
      } else
      {
        pressed =  false;
      }
    } else
    {
      missed = false;
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
  boolean Missed() {
    return missed;
  }
}
