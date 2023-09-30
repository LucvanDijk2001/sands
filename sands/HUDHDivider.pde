class HUDHDivider extends HUDItem
{
  float margin;

  HUDHDivider(float m, HUDMenu menu)
  {
    super(menu);
    margin = m;
  }

  void Show()
  {
    stroke(globals.HUDStroke);
    line(pos.x, pos.y+margin, pos.x+menu.GetWidth(), pos.y+margin);
  }

  void Update()
  {
  }
}
