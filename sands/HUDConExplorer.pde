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

  //explorer graphic
  PGraphics mask;


  //==================================================CONSTRUCT================================
  HUDConExplorer(int x, int y, int w, int h, HUDMenu menu)
  {
    super(menu);
    pos.x = x;
    pos.y = y;
    size.x = w;
    size.y = h;
    mask = createGraphics((int)size.x, (int)size.y-explorerBarHeight);

    //buttons
    addFolderButton       = new HUDButton((int)menu.pos.x, (int)(menu.pos.y+menu.barMargin), (int)menu.size.x/2-1, explorerBarHeight, "add folder", menu);
    addConversationButton = new HUDButton((int)menu.pos.x+(int)menu.size.x/2, (int)(menu.pos.y+menu.barMargin), (int)menu.size.x/2, explorerBarHeight, "add conversation", menu);
  }

  //==================================================UPDATE================================
  void Show()
  {
    CheckOnWindow();
    //fill(globals.HUDItemDentColor);
    //stroke(globals.HUDStroke);
    //rect(pos.x,pos.y,size.x,size.y);

    mask.beginDraw();
    mask.clear();

    mask.fill(globals.HUDItemDentColor);
    mask.stroke(globals.HUDStroke);
    mask.rect(0, 0, mask.width, mask.height);

    mask.endDraw();
    image(mask, menu.pos.x, pos.y+explorerBarHeight);
    ShowButtons();
  }
  
  void Update()
  {
    if(addFolderButton.Released())
    {
      folders.add(new WorkspaceFolder("folder" + folders.size()));
    }
    
    if(addConversationButton.Released())
    {
      workspaces.add(new Workspace("workspace" + workspaces.size(),folders.get(folders.size()-1)));
    }
  }

  //==================================================FUNCTIONS================================
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

  //==================================================CLASSES================================
  class MaskGraphic
  {
    PGraphics mask;
    PVector gpos = new PVector(0, 0);
    PVector gsize = new PVector(0, 0);
    MaskGraphic(PGraphics m)
    {
      mask = m;
    }

    void Show() {
    };
    void Update() {
    };
  }
}
