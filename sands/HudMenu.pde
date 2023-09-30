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

  HUDButton AddHUDButton(int x, int y, int w, int h, String title)
  {
    HUDButton button = new HUDButton(x,y,w,h,title,this);
    AddHUDItem(button);
    return button;
  }
  
  HUDButton AddHUDButton(int x, int y, int w, int h, String title, int mox, int moy)
  {
    HUDButton button = new HUDButton(x,y,w,h,title,mox,moy,this);
    AddHUDItem(button);
    return button;
  }
  
  HUDHDivider AddHUDHDivider(int m)
  {
    HUDHDivider divier = new HUDHDivider(m,this);
    AddHUDItem(divier);
    return divier;
  }
  
  HUDVDivider AddHUDVDivider(int m)
  {
    HUDVDivider divier = new HUDVDivider(m,this);
    AddHUDItem(divier);
    return divier;
  }
  
  HUDConExplorer AddHUDConExplorer(int x, int y, int w, int h)
  {
    HUDConExplorer explorer = new HUDConExplorer(x,y,w,h,this);
    AddHUDItem(explorer);
    return explorer;
  }
  
  private void AddHUDItem(HUDItem item)
  {
    item.pos.x += pos.x;
    item.pos.y += pos.y;
    item.pos.y += barMargin;
    HUDItems.add(item);
  }

  //===================================CLASSES=========================//
}
