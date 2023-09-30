class HUDVDivider extends HUDItem
{
  float margin;

  HUDVDivider(float m, HUDMenu menu)
  {
    super(menu);
    margin = m;
  }

  void Show()
  {
    stroke(globals.HUDStroke);
    line(pos.x+margin, pos.y+menu.barMargin, pos.x+margin, pos.y+menu.barMargin+menu.size.y);
  }

  void Update()
  {
  }
}
