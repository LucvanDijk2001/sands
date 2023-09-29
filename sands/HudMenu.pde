class HUDMenu
{
  //===================================VALUES=========================//
  PVector pos;
  PVector size;
  float barMargin;
  boolean dragable;
  String title = "Menu";
  ArrayList<HUDItem> HUDItems;
  ArrayList<HUDButton> HUDButtons;

  //===================================INIT=========================//
  HUDMenu(int x, int y, int w, int h, int bm, String t, boolean d)
  {
    HUDItems = new ArrayList<HUDItem>();
    pos = new PVector(x, y);
    size = new PVector(w, h);
    dragable = d;
    barMargin = bm;
    title = t;
  }

  //===================================MAIN=========================//
  void Show()
  {
    textAlign(LEFT,CENTER);
    fill(globals.HUDMenuColor);
    stroke(globals.HUDStroke);
    rect(pos.x, pos.y, size.x, size.y);
    fill(globals.HUDMenuBarColor);
    rect(pos.x, pos.y, size.x, barMargin);
    fill(globals.HUDTextColor);
    text(title, pos.x+10, pos.y+barMargin/2);
  }

  void Update()
  {
    for (int i = 0; i < HUDItems.size(); i++)
    {
      HUDItem item = HUDItems.get(i);
      item.Show();
      item.Update();
    }
  }

  //===================================FUNCTIONS=========================//

  void ShowText(int x, int y, String t)
  {
    textAlign(LEFT,CENTER);
    fill(globals.HUDTextColor);
    text(t, pos.x+x, pos.y+y+barMargin);
  }
  
  float GetWidth()
  {
   return size.x; 
  }
  float GetHeight()
  {
   return size.y-barMargin; 
  }

   //===================================HUDITEMS=========================//

  HUDButton AddHUDButton(HUDButton item)
  {
    AddHUDItem(item);
    return item;
  }
  
  HUDHDivider AddHUDHDivider(HUDHDivider item)
  {
    AddHUDItem(item);
    return item;
  }
  
  HUDVDivider AddHUDVDivider(HUDVDivider item)
  {
    AddHUDItem(item);
    return item;
  }
  
  HUDConExplorer AddHUDConExplorer(HUDConExplorer item)
  {
    AddHUDItem(item);
    return item;
  }
  
  private void AddHUDItem(HUDItem item)
  {
    item.pos.x += pos.x;
    item.pos.y += pos.y;
    item.pos.y += barMargin;
    item.menu = this;
    HUDItems.add(item);
  }

  //===================================CLASSES=========================//
}
