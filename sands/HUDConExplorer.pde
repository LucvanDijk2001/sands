class HUDConExplorer extends HUDItem
{
  //needs
  //open/close folders
  //folder items
  //scrollbar based on amount of content vertically
  //vertical items probably need a set size to calculate scrollbar size
  //need some sort of mask
  //items need to be clickable and dragable?

  //make area in menu
  //put some content in area
  //make it so area has a vertical offset, masks anything outside of the area
  //make scrollbar for offset
  //make folder object
  //make folder item object

  //==================================================DATA================================
  //explorer window
  PVector size = new PVector(0, 0);
  boolean onWindow = false;
  int explorerBarHeight = 30;

  //explorer bar
  HUDButton addFolderButton;
  HUDButton addConversationButton;

  //explorer area
  HUDSlider slider;
  int sliderWidth = 20;
  int contentSize = 0;
  int areaOffset = 0;
  int scrollSpeed = 15;
  int maxScroll = 0;

  //explorer graphic
  PGraphics mask;
  ArrayList<MaskGraphic> maskGraphics = new ArrayList<MaskGraphic>();
  
  SimpleMaskGraphic g1;
  SimpleMaskClickable g2;
  MaskToggable t1;
  //==================================================CONSTRUCT================================
  HUDConExplorer(int x, int y, int w, int h, HUDMenu menu)
  {
    super(menu);
    pos.x = x;
    pos.y = y;
    size.x = w;
    size.y = h;
    mask = createGraphics((int)size.x-sliderWidth, (int)size.y-explorerBarHeight);

    //buttons
    addFolderButton       = new HUDButton((int)menu.pos.x, (int)(menu.pos.y+menu.barMargin), (int)menu.size.x/2-1, explorerBarHeight, "add folder", menu);
    addConversationButton = new HUDButton((int)menu.pos.x+(int)menu.size.x/2, (int)(menu.pos.y+menu.barMargin), (int)menu.size.x/2, explorerBarHeight, "add conversation", menu);
    slider                = new HUDSlider((int)menu.pos.x, (int)menu.pos.y+explorerBarHeight+(int)menu.barMargin, sliderWidth, (int)menu.size.y-explorerBarHeight-(int)menu.barMargin, menu);
    
    g1 = new SimpleMaskGraphic(0,600,100,100,mask,this);
    g2 = new SimpleMaskClickable(0,120,100,30,mask,this);
    t1 = new MaskToggable(100,800,20,20,"masktoggle",true,mask,this);

    maskGraphics.add(g1);
    maskGraphics.add(g2);
    maskGraphics.add(t1);
  }

  //==================================================UPDATE================================
  void Show()
  {
    CheckOnWindow();
    fill(globals.HUDItemDentColor);
    stroke(globals.HUDStroke);
    rect(pos.x, pos.y, size.x, size.y);

    mask.beginDraw();
    mask.clear();

    for (int i = 0; i < maskGraphics.size(); i++)
    {
      maskGraphics.get(i).Show(areaOffset);
    }

    mask.endDraw();
    image(mask, menu.pos.x+sliderWidth, pos.y+explorerBarHeight);
    ShowButtons();
    slider.Show();
    slider.Update();
  }

  void Update()
  {
    if (addFolderButton.Released())
    {
      WorkspaceFolder newFolder = new WorkspaceFolder("folder" + folders.size());
      folders.add(newFolder);
    }

    if (addConversationButton.Released())
    {
      workspaces.add(new Workspace("workspace" + workspaces.size(), folders.get(folders.size()-1)));
    }

    for (int i = 0; i < maskGraphics.size(); i++)
    {
      maskGraphics.get(i).Update();
    }

    maxScroll = (int)constrain((size.y-explorerBarHeight)-contentSize, -100000, 0);

    CheckContentSize();
    slider.contentSize = contentSize;

    if (slider.HandleHeld())
    {
      areaOffset = (int)(maxScroll*slider.GetHandleScrollMargin());
    }
  }

  //==================================================FUNCTIONS================================
  void ScrollArea(int amount)
  {
    if (!slider.HandleHeld())
    {
      PVector mp = globals.GetMouseHudPos();
      if (mp.x > pos.x+sliderWidth && mp.x < pos.x+size.x && mp.y > pos.y && mp.y < pos.y+size.y)
      {
        areaOffset -= amount * scrollSpeed;
        areaOffset = (int)constrain(areaOffset, maxScroll, 0);
        if (areaOffset < 0)
        {
          slider.UpdateHandlePosition((float)areaOffset/(float)maxScroll);
        }
      }
    }
  }

  void CheckContentSize()
  {
    int maxy = 0;
    for (int i = 0; i < maskGraphics.size(); i++)
    {
      MaskGraphic mg = maskGraphics.get(i);
      if (mg.enabled)
      {
        float myReach = mg.pos.y+mg.size.y;
        if (myReach > maxy)
        {
          maxy = (int)myReach;
        }
      }
    }
    contentSize = maxy+ 50;
  }

  void ShowButtons()
  {
    addFolderButton.Show();
    addFolderButton.Update();
    addConversationButton.Show();
    addConversationButton.Update();
  }

  void CheckOnWindow()
  {
    onWindow = false;
    PVector mousePos = globals.GetMouseHudPos();
    if (mousePos.x > pos.x && mousePos.x < pos.x+size.x && mousePos.y > pos.y && mousePos.y < pos.y + size.y)
    {
      onWindow = true;
    }
  }
}

//==================================================CLASSES================================
class MaskGraphic
{
  PGraphics mask;
  boolean enabled = true;
  PVector pos = new PVector(0, 0);
  PVector size = new PVector(0, 0);
  HUDConExplorer owner;
  MaskGraphic(int _x, int _y, int _w, int _h, PGraphics _mask, HUDConExplorer _owner)
  {
    pos.x = _x;
    pos.y = _y;
    size.x = _w;
    size.y = _h;
    mask = _mask;
    owner = _owner;
  }

  void Show(int offset) {
  };
  void Update() {
  };
}

class SimpleMaskGraphic extends MaskGraphic
{
  SimpleMaskGraphic(int _x, int _y, int _w, int _h, PGraphics _mask, HUDConExplorer _owner)
  {
    super(_x, _y, _w, _h, _mask, _owner);
  }

  void Show(int offset)
  {
    mask.rect(pos.x, pos.y+offset, size.x, size.y);
  }
}

class SimpleMaskClickable extends MaskClickable
{
  SimpleMaskClickable(int _x, int _y, int _w, int _h, PGraphics _mask, HUDConExplorer _owner)
  {
    super(_x, _y, _w, _h, _mask, _owner);
  }

  void Show(int offset)
  {
    super.Show(offset);
  }

  void Update()
  {
    super.Update();
  }
}
