class HUDMenu
{
  //===================================VALUES=========================//
  PVector pos;
  PVector size;
  float barMargin;
  boolean dragable;
  String title = "Menu";
  ArrayList<HUDIdentifier> HUDIdentifiers;
  ArrayList<HUDButton> HUDButtons;

  //===================================INIT=========================//
  HUDMenu(int x, int y, int w, int h, int bm, String t, boolean d)
  {
    HUDIdentifiers = new ArrayList<HUDIdentifier>();
    HUDButtons = new ArrayList<HUDButton>();
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
    for (int i = 0; i < HUDIdentifiers.size(); i++)
    {
      HUDItem item = HUDIdentifiers.get(i).item;
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

  HUDButton GetButton(String ID)
  {
    for (int i = 0; i < HUDIdentifiers.size(); i++)
    {
      HUDIdentifier hid = HUDIdentifiers.get(i);
      if (hid.id == ID)
      {
        return (HUDButton)hid.item;
      }
    }
    return null;
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

  HUDButton AddHUDButton(HUDButton item, String ID)
  {
    AddHUDItem(item,ID);
    return item;
  }
  
  HUDHDivider AddHUDHDivider(HUDHDivider item, String ID)
  {
    AddHUDItem(item,ID);
    return item;
  }
  
  HUDVDivider AddHUDVDivider(HUDVDivider item, String ID)
  {
    AddHUDItem(item,ID);
    return item;
  }
  
  HUDConExplorer AddHUDConExplorer(HUDConExplorer item, String ID)
  {
    AddHUDItem(item,ID);
    return item;
  }
  
  private void AddHUDItem(HUDItem item, String ID)
  {
    item.pos.x += pos.x;
    item.pos.y += pos.y;
    item.pos.y += barMargin;
    item.menu = this;
    HUDIdentifier newItem = new HUDIdentifier(item, ID);
    HUDIdentifiers.add(newItem);
  }

  //===================================CLASSES=========================//
  class HUDIdentifier
  {
    HUDItem item;
    String id;

    HUDIdentifier(HUDItem i, String ID)
    {
      item = i;
      id = ID;
    }
  }
}
