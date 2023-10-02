class HUDMenu
{
  //===================================VALUES=========================//
  PVector pos;
  PVector size;
  float barMargin;
  boolean dragable;
  String title = "Menu";
  ArrayList<HUDItem> HUDItems;
  boolean isExitMenu = false;
  HUDButton exitButton;
  HUDToggable debugToggle;

  //===================================INIT=========================//
  HUDMenu(int x, int y, int w, int h, int bm, String t, boolean IsExitMenu)
  {
    HUDItems = new ArrayList<HUDItem>();
    pos = new PVector(x, y);
    size = new PVector(w, h);
    isExitMenu = IsExitMenu;
    barMargin = bm;
    title = t;

    if (isExitMenu)
    {
      exitButton = new HUDButton(0, 0, 20, 20, "X", this);
      debugToggle = new HUDToggable((int)size.x-20,0,20,20,"Debug",true,this);
    }
  }

  //===================================MAIN=========================//
  void Show()
  {
    textAlign(LEFT, CENTER);
    fill(globals.HUDMenuColor);
    stroke(globals.HUDStroke);
    rect(pos.x, pos.y, size.x, size.y);
    fill(globals.HUDMenuBarColor);
    rect(pos.x, pos.y, size.x, barMargin);
    fill(globals.HUDTextColor);
    if (isExitMenu)
    {
      text(title, pos.x+30, pos.y+barMargin/2);
      exitButton.Show();
      debugToggle.Show();
    } else
    {
      text(title, pos.x+10, pos.y+barMargin/2);
    }
  }

  void Update()
  {
    for (int i = 0; i < HUDItems.size(); i++)
    {
      HUDItem item = HUDItems.get(i);
      item.Show();
      item.Update();
    }

    if (isExitMenu)
    {
      exitButton.Update();
      debugToggle.Update();
      debug = debugToggle.GetToggled();
      if (exitButton.Released())
      {
        //launch("%windir%/explorer.exe shell:::{3080F90D-D7AD-11D9-BD98-0000947B0257}");
        exit();
      }
    }
  }

  //===================================FUNCTIONS=========================//

  void ShowText(int x, int y, String t)
  {
    textAlign(LEFT, CENTER);
    fill(globals.HUDTextColor);
    text(t, pos.x+x, pos.y+y+barMargin);
  }

  void ShowText(int x, int y, String t, color c)
  {
    textAlign(LEFT, CENTER);
    fill(c);
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
    HUDButton button = new HUDButton(x, y, w, h, title, this);
    AddHUDItem(button);
    return button;
  }

  HUDHDivider AddHUDHDivider(int m)
  {
    HUDHDivider divider = new HUDHDivider(m, this);
    AddHUDItem(divider);
    return divider;
  }

  HUDVDivider AddHUDVDivider(int m)
  {
    HUDVDivider divider = new HUDVDivider(m, this);
    AddHUDItem(divider);
    return divider;
  }

  HUDConExplorer AddHUDConExplorer(int x, int y, int w, int h)
  {
    HUDConExplorer explorer = new HUDConExplorer(x, y, w, h, this);
    AddHUDItem(explorer);
    return explorer;
  }

  HUDToggable AddHUDToggable(int x, int y, int w, int h, String name)
  {
    HUDToggable toggable = new HUDToggable(x, y, w, h,name, this);
    AddHUDItem(toggable);
    return toggable;
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
