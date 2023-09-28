class MouseMenu
{
  PVector pos;
  PVector size;
  float alpha = 255;
  float alphaTo = 255;
  boolean active = false;
  boolean mouseDown = false;
  PVector mouseMove = new PVector(0, 0);
  float moveForgive = 20;
  float alphaLerpSpeed = 5;

  MouseMenu(int w, int h)
  {
    pos = new PVector(0, 0);
    size = new PVector(w, h);
  }

  void Show()
  {
    alpha += (alphaTo-alpha)/alphaLerpSpeed;
    if (active)
    {
      alphaTo = 255;
    } else
    {
      alphaTo = 0;
    }
    if(alpha > 0)
    {
      fill(globals.HUDMenuColor, alpha);
      stroke(globals.HUDStroke, alpha);
      rect(pos.x, pos.y, size.x, size.y);
    }
  }

  void Update()
  {
    CheckActivate();
  }

  void CheckActivate()
  {
    PVector mhp = globals.GetMouseHudPos();
    PVector pmhp = globals.GetPrevMouseHudPos();

    if (mousePressed)
    {
      if (mouseButton == RIGHT)
      {
        if (!mouseDown)
        {
          
          mouseDown = true; 
          active = false;
          alphaLerpSpeed = 2;
          mouseMove.x = 0;
          mouseMove.y = 0;
        } else
        {
          mouseMove.x += mhp.x-pmhp.x;
          mouseMove.y += mhp.y-pmhp.y;
        }
      }
      if (mouseButton == LEFT)
      {
        if (!(mhp.x > pos.x && mhp.x < pos.x+size.x && mhp.y > pos.y && mhp.y < pos.y+size.y))
        {
          active = false;
          alphaLerpSpeed = 2;
        }
      }
    } else
    {
      if (mouseDown)
      {
        if (mouseMove.mag() < moveForgive)
        {
          pos = globals.GetMouseHudPos();
          active = true;
          alphaLerpSpeed = 5;
        }
      }
      mouseDown = false;
    }
  }
}
